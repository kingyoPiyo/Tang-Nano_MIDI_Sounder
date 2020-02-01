 /********************************************************
 * Title    : DDS Module
 * Date     : 2020/01/26
 * Design   : kingyo
 ********************************************************/
module DDS (
    input   wire            i_clk1, // 9MHz
    input   wire            i_clk2, // 72MHz
    input   wire            i_res_n,
    input   wire    [ 5:0]  i_note_addr,
    input   wire            i_note_en,
    input   wire    [23:0]  i_add_val,
    input   wire            i_note_wren,
    output  reg     [ 5:0]  o_sound
);

    wire    [24:0]  w_dram2_rddata;
    reg     [ 5:0]  r_dds_ram_addr;
    wire    [25:0]  w_acc_ram_rddata;
    wire    [25:0]  w_acc_ans = w_dram2_rddata[24] ? w_acc_ram_rddata[25:0] + w_dram2_rddata[23:0] : w_acc_ram_rddata[25:0];
    reg     [ 5:0]  r_acc_sum;
    reg             r_dpram_tien;
    always @(posedge i_clk2 or negedge i_res_n) begin
        if (~i_res_n) begin
            r_dds_ram_addr <= 6'd0;
            r_dpram_tien <= 1'b0;
            r_acc_sum <= 6'd0;
            o_sound <= 6'd0;
        end else begin
            r_dpram_tien <= ~r_dpram_tien;
            if (r_dpram_tien) begin
                r_dds_ram_addr <= r_dds_ram_addr + 6'd1;

                // sum
                if (r_dds_ram_addr == 6'd0) begin
                    o_sound <= r_acc_sum;
                    r_acc_sum <= {5'd0, w_acc_ram_rddata[25]};
                end else begin
                    r_acc_sum <= r_acc_sum + {5'd0, w_acc_ram_rddata[25]};
                end
            end
        end
    end

    //--------------------------
    // DDS加算値RAM 
    // [  24]: ノートON/OFF
    // [23:0]: DDS位相加算値
    // A Port: 入力 9MHz
    // B Port: 出力 72MHz
    //--------------------------
    DP_ADDVAL dram2 (
        .douta ( /* none */ ),              // output [24:0] douta
        .doutb ( w_dram2_rddata[24:0] ),    // output [24:0] doutb
        .clka ( i_clk1 ),                   // input clka
        .ocea ( 1'b1) ,                     // input ocea
        .cea ( 1'b1 ),                      // input cea
        .reseta ( ~i_res_n ),               // input reseta
        .wrea ( i_note_wren ),              // input wrea
        .clkb ( i_clk2 ),                   // input clkb
        .oceb ( 1'b1 ),                     // input oceb
        .ceb ( 1'b1 ),                      // input ceb
        .resetb ( ~i_res_n ),               // input resetb
        .wreb ( 1'b0 ),                     // input wreb
        .ada ( i_note_addr[5:0] ),          // input [5:0] ada
        .dina ( {i_note_en, i_add_val[23:0]} ), // input [24:0] dina
        .adb ( r_dds_ram_addr[5:0] ),       // input [5:0] adb
        .dinb ( 25'd0 )                     // input [24:0] dinb
    );

    //--------------------------
    // DDS アキュムレータ値RAM
    //--------------------------
    SP_ACC spram1 (
        .dout ( w_acc_ram_rddata[25:0] ),   // output [31:0] dout
        .clk ( i_clk2 ),                    // input clk
        .oce ( 1'b1 ),                      // input oce
        .ce ( 1'b1 ),                       // input ce
        .reset ( ~i_res_n ),                // input reset
        .wre ( r_dpram_tien ),              // input wre
        .ad ( r_dds_ram_addr[5:0] ),        // input [5:0] ad
        .din ( w_acc_ans[25:0] )            // input [31:0] din
    );

endmodule
