//Copyright (C)2014-2019 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.2.02Beta
//Part Number: GW1N-LV1QN48C6/I5
//Created Time: Sun Jan 26 07:33:19 2020

module DP_ADDVAL (douta, doutb, clka, ocea, cea, reseta, wrea, clkb, oceb, ceb, resetb, wreb, ada, dina, adb, dinb);

output [24:0] douta;
output [24:0] doutb;
input clka;
input ocea;
input cea;
input reseta;
input wrea;
input clkb;
input oceb;
input ceb;
input resetb;
input wreb;
input [5:0] ada;
input [24:0] dina;
input [5:0] adb;
input [24:0] dinb;

wire gw_vcc;
wire gw_gnd;

assign gw_vcc = 1'b1;
assign gw_gnd = 1'b0;

DP dp_inst_0 (
    .DOA(douta[15:0]),
    .DOB(doutb[15:0]),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSEL({gw_gnd,gw_gnd,gw_gnd}),
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,gw_vcc,gw_vcc}),
    .DIA(dina[15:0]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,gw_vcc,gw_vcc}),
    .DIB(dinb[15:0])
);

defparam dp_inst_0.READ_MODE0 = 1'b0;
defparam dp_inst_0.READ_MODE1 = 1'b0;
defparam dp_inst_0.WRITE_MODE0 = 2'b00;
defparam dp_inst_0.WRITE_MODE1 = 2'b00;
defparam dp_inst_0.BIT_WIDTH_0 = 16;
defparam dp_inst_0.BIT_WIDTH_1 = 16;
defparam dp_inst_0.BLK_SEL = 3'b000;
defparam dp_inst_0.RESET_MODE = "SYNC";

DPX9 dpx9_inst_1 (
    .DOA(douta[24:16]),
    .DOB(doutb[24:16]),
    .CLKA(clka),
    .OCEA(ocea),
    .CEA(cea),
    .RESETA(reseta),
    .WREA(wrea),
    .CLKB(clkb),
    .OCEB(oceb),
    .CEB(ceb),
    .RESETB(resetb),
    .WREB(wreb),
    .BLKSEL({gw_gnd,gw_gnd,gw_gnd}),
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIA(dina[24:16]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,gw_gnd}),
    .DIB(dinb[24:16])
);

defparam dpx9_inst_1.READ_MODE0 = 1'b0;
defparam dpx9_inst_1.READ_MODE1 = 1'b0;
defparam dpx9_inst_1.WRITE_MODE0 = 2'b00;
defparam dpx9_inst_1.WRITE_MODE1 = 2'b00;
defparam dpx9_inst_1.BIT_WIDTH_0 = 9;
defparam dpx9_inst_1.BIT_WIDTH_1 = 9;
defparam dpx9_inst_1.BLK_SEL = 3'b000;
defparam dpx9_inst_1.RESET_MODE = "SYNC";

endmodule //DP_ADDVAL
