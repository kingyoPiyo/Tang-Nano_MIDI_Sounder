//Copyright (C)2014-2019 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.2.02Beta
//Part Number: GW1N-LV1QN48C6/I5
//Created Time: Sat Feb 01 16:18:49 2020

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    SP_ACC your_instance_name(
        .dout(dout_o), //output [25:0] dout
        .clk(clk_i), //input clk
        .oce(oce_i), //input oce
        .ce(ce_i), //input ce
        .reset(reset_i), //input reset
        .wre(wre_i), //input wre
        .ad(ad_i), //input [5:0] ad
        .din(din_i) //input [25:0] din
    );

//--------Copy end-------------------
