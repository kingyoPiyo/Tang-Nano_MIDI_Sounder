/********************************************************
 * Title    : UART Receive module
 * Date     : 2016/09/08
 * Design   : kingyo
 ********************************************************/
module UART_Rx (
    input   wire            i_clk,
    input   wire            i_res_n,
    input   wire    [15:0]  i_baud,   // bpsの8倍
    input   wire            i_rx_pin,
    output  reg             o_rxFlg,
    output  reg     [ 7:0]  o_rxData
    );
    
    //-----------
    // register
    //-----------
    reg [ 7:0]  rxBuf;
    reg [ 1:0]  stbit_reg;
    reg [ 7:0]  bitCounter_reg;
    reg [15:0]  i_baud_cnt;
    
    //------
    // wire
    //------
    wire        serial_clk;
    
    //--------------
    // UART CLK GEN
    //--------------
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            i_baud_cnt <= 16'h0000;
        end else begin
            if (serial_clk) begin
                i_baud_cnt <= 16'h0000;
            end else begin
                i_baud_cnt <= i_baud_cnt + 16'h0001;
            end
        end
    end
    assign	serial_clk = (i_baud_cnt == i_baud);
    
    //-------------------
    // UART Receive Core
    //-------------------
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            o_rxFlg <= 1'b0;
            o_rxData <= 8'd0;
            rxBuf <= 8'd0;
            stbit_reg <= 2'b11;
            bitCounter_reg <= 8'd0;
        end else if (o_rxFlg) begin
            o_rxFlg <= 0;
        end else if (serial_clk) begin
        // 8倍オーバーサンプリング
            // データ読み取り
            case (bitCounter_reg)
                // 立ち下がり待ち
                0 : begin
                    // 立ち下がりエッジ検出
                    stbit_reg[1:0] <= {stbit_reg[0], i_rx_pin};
                    if (stbit_reg == 2'b10) begin
                        bitCounter_reg <= 1;
                    end
                end
            
                // Start bit
                4 : begin
                    if (~i_rx_pin) begin
                        bitCounter_reg <= bitCounter_reg + 8'd1;
                    end else begin
                        stbit_reg <= 2'b11;
                        bitCounter_reg <= 0;
                    end
                end
                
                // Data bit
                12,20,28,36,44,52,60,68 : begin
                    bitCounter_reg <= bitCounter_reg + 8'd1;
                    rxBuf <= {i_rx_pin, rxBuf[7:1]};
                end
                
                // Stop bit
                76 : begin
                    bitCounter_reg <= 0;
                    stbit_reg <= 2'b11;
                    
                    // 出力データコピー
                    o_rxData <= rxBuf;
                    
                    // データ受信通知
                    o_rxFlg <= 1;
                end
                
                // oter 
                default : begin
                    bitCounter_reg <= bitCounter_reg + 8'd1;
                end
            endcase
        end		
    end
    
endmodule
    