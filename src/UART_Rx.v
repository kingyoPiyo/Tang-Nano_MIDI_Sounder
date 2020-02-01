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
    output  reg             o_rxDone,
    output  reg     [ 7:0]  o_rxData
    );
    
    //-----------
    // register
    //-----------
    reg [ 7:0]  r_rxBuf;
    reg [ 1:0]  r_stbit;
    reg [ 7:0]  r_bitCounter;
    reg [15:0]  r_baud_cnt;
    
    //------
    // wire
    //------
    wire        w_serial_clk;
    
    //--------------
    // UART CLK GEN
    //--------------
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            r_baud_cnt <= 16'h0000;
        end else begin
            if (w_serial_clk) begin
                r_baud_cnt <= 16'h0000;
            end else begin
                r_baud_cnt <= r_baud_cnt + 16'h0001;
            end
        end
    end
    assign  w_serial_clk = (r_baud_cnt == i_baud);
    
    //-------------------
    // UART Receive Core
    //-------------------
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            o_rxDone <= 1'b0;
            o_rxData <= 8'd0;
            r_rxBuf <= 8'd0;
            r_stbit <= 2'b11;
            r_bitCounter <= 8'd0;
        end else if (o_rxDone) begin
            o_rxDone <= 0;
        end else if (w_serial_clk) begin
        // 8倍オーバーサンプリング
            // データ読み取り
            case (r_bitCounter)
                // 立ち下がり待ち
                0 : begin
                    // 立ち下がりエッジ検出
                    r_stbit[1:0] <= {r_stbit[0], i_rx_pin};
                    if (r_stbit == 2'b10) begin
                        r_bitCounter <= 1;
                    end
                end
            
                // Start bit
                4 : begin
                    if (~i_rx_pin) begin
                        r_bitCounter <= r_bitCounter + 8'd1;
                    end else begin
                        r_stbit <= 2'b11;
                        r_bitCounter <= 0;
                    end
                end
                
                // Data bit
                12,20,28,36,44,52,60,68 : begin
                    r_bitCounter <= r_bitCounter + 8'd1;
                    r_rxBuf <= {i_rx_pin, r_rxBuf[7:1]};
                end
                
                // Stop bit
                76 : begin
                    r_bitCounter <= 0;
                    r_stbit <= 2'b11;
                    
                    // 出力データコピー
                    o_rxData <= r_rxBuf;
                    
                    // データ受信通知
                    o_rxDone <= 1;
                end
                
                // other
                default : begin
                    r_bitCounter <= r_bitCounter + 8'd1;
                end
            endcase
        end
    end
    
endmodule
    