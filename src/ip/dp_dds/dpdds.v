//Copyright (C)2014-2019 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.2.02Beta
//Part Number: GW1N-LV1QN48C6/I5
//Created Time: Sun Jan 26 17:48:47 2020

module DP_DDS (douta, doutb, clka, ocea, cea, reseta, wrea, clkb, oceb, ceb, resetb, wreb, ada, dina, adb, dinb, byte_ena, byte_enb);

output [63:0] douta;
output [63:0] doutb;
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
input [63:0] dina;
input [5:0] adb;
input [63:0] dinb;
input [7:0] byte_ena;
input [7:0] byte_enb;

wire gw_gnd;

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
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,byte_ena[1:0]}),
    .DIA(dina[15:0]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,byte_enb[1:0]}),
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

DP dp_inst_1 (
    .DOA(douta[31:16]),
    .DOB(doutb[31:16]),
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
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,byte_ena[3:2]}),
    .DIA(dina[31:16]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,byte_enb[3:2]}),
    .DIB(dinb[31:16])
);

defparam dp_inst_1.READ_MODE0 = 1'b0;
defparam dp_inst_1.READ_MODE1 = 1'b0;
defparam dp_inst_1.WRITE_MODE0 = 2'b00;
defparam dp_inst_1.WRITE_MODE1 = 2'b00;
defparam dp_inst_1.BIT_WIDTH_0 = 16;
defparam dp_inst_1.BIT_WIDTH_1 = 16;
defparam dp_inst_1.BLK_SEL = 3'b000;
defparam dp_inst_1.RESET_MODE = "SYNC";

DP dp_inst_2 (
    .DOA(douta[47:32]),
    .DOB(doutb[47:32]),
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
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,byte_ena[5:4]}),
    .DIA(dina[47:32]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,byte_enb[5:4]}),
    .DIB(dinb[47:32])
);

defparam dp_inst_2.READ_MODE0 = 1'b0;
defparam dp_inst_2.READ_MODE1 = 1'b0;
defparam dp_inst_2.WRITE_MODE0 = 2'b00;
defparam dp_inst_2.WRITE_MODE1 = 2'b00;
defparam dp_inst_2.BIT_WIDTH_0 = 16;
defparam dp_inst_2.BIT_WIDTH_1 = 16;
defparam dp_inst_2.BLK_SEL = 3'b000;
defparam dp_inst_2.RESET_MODE = "SYNC";

DP dp_inst_3 (
    .DOA(douta[63:48]),
    .DOB(doutb[63:48]),
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
    .ADA({gw_gnd,gw_gnd,gw_gnd,gw_gnd,ada[5:0],gw_gnd,gw_gnd,byte_ena[7:6]}),
    .DIA(dina[63:48]),
    .ADB({gw_gnd,gw_gnd,gw_gnd,gw_gnd,adb[5:0],gw_gnd,gw_gnd,byte_enb[7:6]}),
    .DIB(dinb[63:48])
);

defparam dp_inst_3.READ_MODE0 = 1'b0;
defparam dp_inst_3.READ_MODE1 = 1'b0;
defparam dp_inst_3.WRITE_MODE0 = 2'b00;
defparam dp_inst_3.WRITE_MODE1 = 2'b00;
defparam dp_inst_3.BIT_WIDTH_0 = 16;
defparam dp_inst_3.BIT_WIDTH_1 = 16;
defparam dp_inst_3.BLK_SEL = 3'b000;
defparam dp_inst_3.RESET_MODE = "SYNC";

endmodule //DP_DDS
