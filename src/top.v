 /********************************************************
 * Title    : Tang-Nano MIDI Sounder
 * Date     : 2020/01/26
 * Design   : kingyo
 ********************************************************/
module top (
    // CLK
    input   wire            mco,    // 24MHz

    // Button
    input   wire            res_n,
    input   wire            btn_b,  // 未使用

    // MIDI INPUT
    input   wire            uart_rx,

    // Audio Out
    output  wire            audio_o,
    
    // LCD
    output  wire            lcd_clk,
    output  wire            lcd_hsync,
    output  wire            lcd_vsync,
    output  wire            lcd_de,
    output  wire    [15:0]  lcd_data
    );

    /**************************************************************
     *  Wires
     *************************************************************/
    wire            clk9m;
    wire            clk72m;
    wire            w_RxDone;
    wire    [ 7:0]  w_RxData;
    wire    [ 5:0]  w_NoteAddr;
    wire    [15:0]  w_NoteData;
    wire    [23:0]  w_AddVal;
    wire    [ 5:0]  w_Sound;
    wire    [ 8:0]  w_LcdPosY;

    /**************************************************************
     *  PLL
     *************************************************************/
    Gowin_PLL Gowin_PLL_isnt (
        .clkin ( mco ),         // input clkin
        .clkout ( clk72m ),     // output clkout
        .clkoutd ( clk9m )      // output clkoutd
    );

    /**************************************************************
     *  UART Receiver
     *************************************************************/
    UART_Rx UART_Rx_inst (
        .i_clk ( clk9m ),
        .i_res_n ( res_n ),
        .i_baud ( 28 ),         // bpsの8倍 (clk / (38400 x 8)) - 1
        .i_rx_pin ( uart_rx ),
        .o_rxDone ( w_RxDone ),
        .o_rxData ( w_RxData )
    );

    /**************************************************************
     *  MIDI Decoder
     *************************************************************/
    MIDI_Decoder MIDI_Decoder_inst (
        .i_clk ( clk9m ),
        .i_res_n ( res_n ),
        .i_rx_flg ( w_RxDone ),
        .i_rx_data ( w_RxData ),
        .i_rdaddr ( w_NoteAddr[5:0] ),  // 0-3:MIDI ch1, 4-7:MIDI ch2, ...
        .o_rddata ( w_NoteData[15:0] )  // {noteOnOff[0], noteNum[6:0], 1'b0, velocity[6:0]}
    );

    /**************************************************************
     *  Note Num -> DDS Add Value Convert
     *************************************************************/
    NoteNumTable NoteNumTable_inst (
        .i_notenum ( w_NoteData[14:8] ),
        .o_val ( w_AddVal[23:0] )
    );

    /**************************************************************
     *  DDS
     *************************************************************/
    DDS DDS_inst (
        .i_clk1 ( clk9m ),      // 9MHz
        .i_clk2 ( clk72m ),     // 72MHz
        .i_res_n ( res_n ),
        .i_note_addr ( w_NoteAddr[5:0] ),
        .i_note_en ( w_NoteData[15] ),
        .i_add_val ( w_AddVal[23:0] ),
        .i_note_wren ( w_LcdPosY[1:0] == 2'd1 ),
        .o_sound ( w_Sound[5:0] )
    );
    
    /**************************************************************
     *  Delta Sigma DAC
     *************************************************************/
    DeltaSigma_DAC DeltaSigma_DAC_inst (
        .i_clk ( clk72m ),
        .i_res_n ( res_n ),
        .i_adata ( w_Sound[5:0] ),
        .o_out ( audio_o )
    );

    /**************************************************************
     *  LCD Controller
     *************************************************************/
    LCD_Controller LCD_Controller_inst (
        .i_clk ( clk9m ),
        .i_res_n ( res_n ),
        .i_note_en ( w_NoteData[15] ),
        .i_note_num ( w_NoteData[14:8] ),
        .o_clk ( lcd_clk ),
        .o_hsync ( lcd_hsync ),
        .o_vsync ( lcd_vsync ),
        .o_de ( lcd_de ),
        .o_x_cnt (  ),
        .o_y_cnt ( w_LcdPosY[8:0] ),
        .o_lcd_data ( lcd_data[15:0] )
    );
    assign  w_NoteAddr[5:0] = w_LcdPosY[7:2];
    
endmodule
