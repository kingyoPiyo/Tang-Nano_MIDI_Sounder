//Copyright (C)2014-2019 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.2.02Beta
//Part Number: GW1N-LV1QN48C6/I5
//Created Time: Sun Jan 26 07:33:19 2020

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    DP_ADDVAL your_instance_name(
        .douta(douta_o), //output [24:0] douta
        .doutb(doutb_o), //output [24:0] doutb
        .clka(clka_i), //input clka
        .ocea(ocea_i), //input ocea
        .cea(cea_i), //input cea
        .reseta(reseta_i), //input reseta
        .wrea(wrea_i), //input wrea
        .clkb(clkb_i), //input clkb
        .oceb(oceb_i), //input oceb
        .ceb(ceb_i), //input ceb
        .resetb(resetb_i), //input resetb
        .wreb(wreb_i), //input wreb
        .ada(ada_i), //input [5:0] ada
        .dina(dina_i), //input [24:0] dina
        .adb(adb_i), //input [5:0] adb
        .dinb(dinb_i) //input [24:0] dinb
    );

//--------Copy end-------------------
