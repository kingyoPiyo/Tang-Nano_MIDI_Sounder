/********************************************************
 * Title    : MIDI Note Num to DDS AccVal Table
 * Date     : 2020/01/26
 * Design   : kingyo
 ********************************************************/
module NoteNumTable (
    input   wire    [ 6:0]  notenum,
    output  wire    [23:0]  val
    );
    
    assign val[23:0] = accTable( notenum );
    
    function [23:0] accTable;
        input   [6:0]   notenum;
        
        begin
            case (notenum)
                0: accTable = 24'h0003CF;
                1: accTable = 24'h000409;
                2: accTable = 24'h000447;
                3: accTable = 24'h000488;
                4: accTable = 24'h0004CD;
                5: accTable = 24'h000516;
                6: accTable = 24'h000563;
                7: accTable = 24'h0005B5;
                8: accTable = 24'h00060C;
                9: accTable = 24'h000668;
                10: accTable = 24'h0006CA;
                11: accTable = 24'h000731;
                12: accTable = 24'h00079F;
                13: accTable = 24'h000813;
                14: accTable = 24'h00088E;
                15: accTable = 24'h000910;
                16: accTable = 24'h00099A;
                17: accTable = 24'h000A2C;
                18: accTable = 24'h000AC7;
                19: accTable = 24'h000B6B;
                20: accTable = 24'h000C19;
                21: accTable = 24'h000CD1;
                22: accTable = 24'h000D94;
                23: accTable = 24'h000E63;
                24: accTable = 24'h000F3E;
                25: accTable = 24'h001026;
                26: accTable = 24'h00111B;
                27: accTable = 24'h001220;
                28: accTable = 24'h001334;
                29: accTable = 24'h001458;
                30: accTable = 24'h00158E;
                31: accTable = 24'h0016D6;
                32: accTable = 24'h001831;
                33: accTable = 24'h0019A2;
                34: accTable = 24'h001B28;
                35: accTable = 24'h001CC5;
                36: accTable = 24'h001E7B;
                37: accTable = 24'h00204B;
                38: accTable = 24'h002237;
                39: accTable = 24'h002440;
                40: accTable = 24'h002668;
                41: accTable = 24'h0028B0;
                42: accTable = 24'h002B1C;
                43: accTable = 24'h002DAC;
                44: accTable = 24'h003063;
                45: accTable = 24'h003344;
                46: accTable = 24'h003650;
                47: accTable = 24'h00398B;
                48: accTable = 24'h003CF7;
                49: accTable = 24'h004097;
                50: accTable = 24'h00446E;
                51: accTable = 24'h00487F;
                52: accTable = 24'h004CCF;
                53: accTable = 24'h005160;
                54: accTable = 24'h005637;
                55: accTable = 24'h005B57;
                56: accTable = 24'h0060C6;
                57: accTable = 24'h006687;
                58: accTable = 24'h006CA0;
                59: accTable = 24'h007315;
                60: accTable = 24'h0079ED;
                61: accTable = 24'h00812D;
                62: accTable = 24'h0088DC;
                63: accTable = 24'h0090FF;
                64: accTable = 24'h00999E;
                65: accTable = 24'h00A2C1;
                66: accTable = 24'h00AC6E;
                67: accTable = 24'h00B6AF;
                68: accTable = 24'h00C18C;
                69: accTable = 24'h00CD0E;
                70: accTable = 24'h00D940;
                71: accTable = 24'h00E62B;
                72: accTable = 24'h00F3DA;
                73: accTable = 24'h01025A;
                74: accTable = 24'h0111B7;
                75: accTable = 24'h0121FE;
                76: accTable = 24'h01333C;
                77: accTable = 24'h014581;
                78: accTable = 24'h0158DC;
                79: accTable = 24'h016D5E;
                80: accTable = 24'h018318;
                81: accTable = 24'h019A1C;
                82: accTable = 24'h01B27F;
                83: accTable = 24'h01CC55;
                84: accTable = 24'h01E7B5;
                85: accTable = 24'h0204B5;
                86: accTable = 24'h02236E;
                87: accTable = 24'h0243FC;
                88: accTable = 24'h026678;
                89: accTable = 24'h028B02;
                90: accTable = 24'h02B1B8;
                91: accTable = 24'h02DABC;
                92: accTable = 24'h03062F;
                93: accTable = 24'h033438;
                94: accTable = 24'h0364FE;
                95: accTable = 24'h0398AA;
                96: accTable = 24'h03CF69;
                97: accTable = 24'h040969;
                98: accTable = 24'h0446DD;
                99: accTable = 24'h0487F7;
                100: accTable = 24'h04CCF1;
                101: accTable = 24'h051604;
                102: accTable = 24'h056370;
                103: accTable = 24'h05B577;
                104: accTable = 24'h060C5E;
                105: accTable = 24'h066870;
                106: accTable = 24'h06C9FC;
                107: accTable = 24'h073155;
                108: accTable = 24'h079ED2;
                109: accTable = 24'h0812D3;
                110: accTable = 24'h088DB9;
                111: accTable = 24'h090FEE;
                112: accTable = 24'h0999E2;
                113: accTable = 24'h0A2C09;
                114: accTable = 24'h0AC6E1;
                115: accTable = 24'h0B6AEE;
                116: accTable = 24'h0C18BC;
                117: accTable = 24'h0CD0E1;
                118: accTable = 24'h0D93F8;
                119: accTable = 24'h0E62A9;
                120: accTable = 24'h0F3DA5;
                121: accTable = 24'h1025A6;
                122: accTable = 24'h111B72;
                123: accTable = 24'h121FDD;
                124: accTable = 24'h1333C3;
                125: accTable = 24'h145812;
                126: accTable = 24'h158DC2;
                127: accTable = 24'h16D5DC;
            endcase
        end
    endfunction

endmodule
