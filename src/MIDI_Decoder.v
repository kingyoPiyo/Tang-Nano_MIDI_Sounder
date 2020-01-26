 /********************************************************
 * MIDI Decoder
 * Date: 2016/09/08
 * kingyo
 * 2016/10/03
 * last update : 2020/01/26
 ********************************************************/
 module MIDI_Decoder (
        input   wire            i_clk,
        input   wire            i_res_n,
        input   wire            i_rx_flg,
        input   wire    [ 7:0]  i_rx_data,
        
        // RAM B-Port
        input   wire    [ 5:0]  i_rdaddr,	// 0-3:MIDI ch1, 4-7:MIDI ch2, ...
        output  wire    [15:0]  o_rddata 	// {noteOnOff[0], noteNum[6:0], 1'b0, velocity[6:0]}
    );
    
    //-----------------------
    // MIDI受信コマンド解析
    //-----------------------
    reg 	[1:0]	r_state;
    reg		[3:0]	r_midi_ch;
    reg		[6:0]	r_midi_note;
    reg		[6:0]	r_midi_velocity;
    reg				r_midi_noteen;
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            r_state <= 2'd0;
            r_midi_ch <= 4'd0;
            r_midi_note <= 7'd0;
            r_midi_velocity <= 7'd0;
            r_midi_noteen <= 1'b0;
        end else if (i_rx_flg) begin
            case (r_state)
                // 第1バイト
                2'd0: begin
                    if (i_rx_data[7:4] == 4'd8) begin
                        // ノートオフ
                        r_midi_noteen <= 1'b0;
                        r_midi_ch <= i_rx_data[3:0];
                        r_state <= 2'd1;
                    end else if (i_rx_data[7:4] == 4'd9) begin
                        // ノートオン
                        r_midi_noteen <= 1'b1;
                        r_midi_ch <= i_rx_data[3:0];
                        r_state <= 2'd1;
                    end
                end

                // 第2バイト
                2'd1: begin	
                    // ノート番号
                    r_midi_note <= i_rx_data[6:0];
                    r_state <= 2'd2;
                end

                // 第3バイト
                2'd2: begin
                    r_midi_velocity <= i_rx_data[6:0];
                    r_state <= 2'd0;
                end
            endcase
        end
    end

    //--------------------------
    // 受信データをRAMに格納する
    //--------------------------
    reg	r_ram_busy;
    // 書き込みデータ            ノートON/OFF ,        ノート番号,    0,             ベロシティ
    wire	[15:0] w_wrdata = {r_midi_noteen, r_midi_note[6:0], 1'b0, r_midi_velocity[6:0]};
    // Write Enable
    reg            r_wen;
    // 読み出しデータ
    wire    [15:0] w_rddata;
    // 読み書きアドレス
    reg     [5: 0] r_rwaddr;
    // 書き込みOK条件（ノートON要求時：対象スロットがノートOFF中であること
    //               ノートOFF要求時：対象スロットがノートON中かつ、ノート番号が一致）
    wire           w_wok = r_midi_noteen ? (w_rddata[15] == 1'b0) :
                                           (w_rddata[15:8] == {1'b1, r_midi_note[6:0]});
    // RAMのリードアドレスを指定してデータが読まれるのに1レイテンシ存在
    reg r_tien;
    always @(posedge i_clk or negedge i_res_n) begin
        if (~i_res_n) begin
            r_ram_busy <= 1'b0;
            r_rwaddr <= 6'd0;
            r_wen <= 1'b0;
            r_tien <= 1'b0;
        end else begin
            if (r_state == 2'd2 && i_rx_flg) begin
                // データ揃ったので処理開始
                r_ram_busy <= 1'b1;
                r_tien <= 1'b0;
                // 初期アドレス生成
                r_rwaddr[5:0] <= {r_midi_ch[3:0], 2'd0};
            end else if (r_ram_busy) begin
                // RAM Read/Write制御
                
                // 読み出しレイテンシ考慮して1/2i_clkで動作させる
                r_tien <= ~r_tien;

                // 対象スロットの確認
                if (r_tien) begin
                    if (w_wok) begin
                        // 対象スロットを発見したのでWrite
                        r_wen <= 1'b1;
                        // 処理終了
                        r_ram_busy <= 1'b0;
                    end else begin     
                        // 空いてないぞ　次のスロットへ
                        r_rwaddr[5:0] <= r_rwaddr + 6'd1;
                        // 最後まで埋まってたら諦める
                        if (r_rwaddr[1:0] == 2'd3) begin
                            r_ram_busy <= 1'b0;
                        end
                    end
                end
            end else begin
                r_wen <= 1'b0;
                r_tien <= 1'b0;
            end
        end
    end

    //--------------------------
    // ノート番号格納RAM (A Port:INPUT / B Port:OUTPUT)
    //--------------------------
    DP_MIDIMSG midi_note_ram (
        .douta ( w_rddata[15:0] ), //output [15:0] douta
        .doutb ( o_rddata[15:0] ), //output [15:0] doutb
        .clka ( i_clk ), //input i_clka
        .ocea ( 1'b1 ), //input ocea
        .cea ( 1'b1 ), //input cea
        .reseta ( ~i_res_n ), //input reseta
        .wrea ( r_wen ), //input wrea
        .clkb ( i_clk ), //input i_clkb
        .oceb ( 1'b1 ), //input oceb
        .ceb ( 1'b1 ), //input ceb
        .resetb ( ~i_res_n ), //input resetb
        .wreb ( 1'b0 ), //input wreb
        .ada ( r_rwaddr[5:0] ), //input [5:0] ada
        .dina ( w_wrdata[15:0] ), //input [15:0] dina
        .adb ( i_rdaddr[5:0] ), //input [5:0] adb
        .dinb ( 16'd0 ) //input [15:0] dinb
    );


endmodule
