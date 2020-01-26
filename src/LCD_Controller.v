 /********************************************************
 * Title    : LCD Controller
 * Date     : 2020/01/26
 * Design   : kingyo
 ********************************************************/
module LCD_Controller (
    input   wire            i_clk,
    input   wire            i_res_n,
    input   wire            i_note_en,
    input   wire    [ 6:0]  i_note_num,
    output  wire            o_clk,
    output  wire            o_hsync,
    output  wire            o_vsync,
    output  wire            o_de,
    output  wire    [ 9:0]  o_x_cnt,
    output  wire    [ 8:0]  o_y_cnt,
    output  wire    [15:0]  o_lcd_data
    );

    /**************************************************************
    *  LCDパラメータ (ATM0430D25)
    *************************************************************/
    localparam DispHPeriodTime  = 531;
    localparam DispWidth        = 480;
    localparam DispHBackPorch   = 43;
    localparam DispHFrontPorch  = 8;
    localparam DispHPulseWidth  = 1;

    localparam DispVPeriodTime  = 288;
    localparam DispHeight       = 272;	
    localparam DispVBackPorch   = 12;
    localparam DispVFrontPorch  = 4;
    localparam DispVPulseWidth  = 10;
    

    // カウンタ
    reg [ 9:0]  r_hPeriodCnt;
    reg [ 8:0]  r_vPeriodCnt;
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            r_hPeriodCnt[9:0] <= 10'd0;
            r_vPeriodCnt[8:0] <= 9'd0;
        end else begin
            // 水平カウンタ
            if (r_hPeriodCnt[9:0] == (DispHPeriodTime - 10'd1)) begin
                r_hPeriodCnt[9:0] <= 10'd0;
            end else begin
                r_hPeriodCnt[9:0] <= r_hPeriodCnt[9:0] + 10'b1;
            end

            // 垂直カウンタ
            if (r_hPeriodCnt[9:0] == (DispHPeriodTime - 10'd1)) begin
                if (r_vPeriodCnt[8:0] == (DispVPeriodTime - 9'd1)) begin
                    r_vPeriodCnt[8:0] <= 9'd0;
                end else begin
                    r_vPeriodCnt[8:0] <= r_vPeriodCnt[8:0] + 9'b1;
                end
            end
        end
    end

    // 書き込み領域判定
    reg         r_hInVisibleArea;
    reg         r_vInVisibleArea;
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            r_hInVisibleArea <= 1'd0;
            r_vInVisibleArea <= 1'd0;
        end else begin
            // 書き込み領域判定
            r_hInVisibleArea <= (r_hPeriodCnt[9:0] == DispHBackPorch)  ? 1'b1 :
                                (r_hPeriodCnt[9:0] == DispHBackPorch + DispWidth) ? 1'b0 : r_hInVisibleArea;
            r_vInVisibleArea <= (r_vPeriodCnt[8:0] == DispVBackPorch)  ? 1'b1 :
                                (r_vPeriodCnt[8:0] == DispVBackPorch + DispHeight) ? 1'b0 : r_vInVisibleArea;
        end
    end


    assign o_clk = i_clk;
    assign o_hsync = (r_hPeriodCnt[9:0] < DispHPulseWidth) ? 1'b0 : 1'b1;   // HSYNC信号生成
    assign o_vsync = (r_vPeriodCnt[8:0] < DispVPulseWidth) ? 1'b0 : 1'b1;   // VSYNC信号生成
    assign o_de = r_hInVisibleArea & r_vInVisibleArea;
    assign o_x_cnt = r_hPeriodCnt - DispHBackPorch;
    assign o_y_cnt = r_vPeriodCnt - DispVBackPorch;


    /**************************************************************
     *  UI生成
     *************************************************************/
    // 横線(点線)
    wire w_sep_line = (o_y_cnt[3:0] == 4'd0) && (o_x_cnt[0] == 1'b1);

    // バーグラフ
    wire    [5:0]   w_noteAddr = o_y_cnt[7:2];
    wire            w_bar      = (o_x_cnt[9:2] == i_note_num[6:0]) ? i_note_en : 1'b0;
    
    // ドットデータ生成
    wire w_bar_r = w_noteAddr[1:0] == 2'd0 || w_noteAddr[1:0] == 2'd3;
    wire w_bar_g = w_noteAddr[1:0] == 2'd1 || w_noteAddr[1:0] == 2'd3;
    wire w_bar_b = w_noteAddr[1:0] == 2'd2 || w_noteAddr[1:0] == 2'd3;
    assign o_lcd_data[15:0] = o_y_cnt[8:0] > 9'd256 ? 16'h0000 :                // 範囲外
                            (w_bar && o_y_cnt[8:0] <= 9'd255) ? {{5{w_bar_r}}, {6{w_bar_g}}, {5{w_bar_b}}} :    // バー
                            w_sep_line ? 16'hFFFF : 16'h0000;                   // 横線


endmodule
