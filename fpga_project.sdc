//Copyright (C)2014-2019 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.2.02 Beta
//Created Time: 2019-12-25 22:24:03
#**************************************************************
# Time Information
#**************************************************************



#**************************************************************
# Create Clock
#**************************************************************
create_clock -name mco -period 41.667 -waveform {0.000 20.834} [get_ports {mco}]
create_generated_clock -name w_Clk72m -source [get_ports {mco}] -master_clock mco -divide_by 2 -multiply_by 6 [get_nets {w_Clk72m}]
create_generated_clock -name w_Clk9m -source [get_ports {mco}] -master_clock mco -divide_by 8 -multiply_by 3 [get_nets {w_Clk9m}]


#**************************************************************
# Set Input Delay
#**************************************************************


#**************************************************************
# Set Output Delay
#**************************************************************
set_output_delay -add_delay -max -clock [get_clocks {w_Clk9m}]  3.000 [get_ports {lcd_clk}]
set_output_delay -add_delay -min -clock [get_clocks {w_Clk9m}]  0.000 [get_ports {lcd_clk}]
set_output_delay -add_delay -max -clock [get_clocks {w_Clk9m}]  3.000 [get_ports {lcd_hsync}]
set_output_delay -add_delay -min -clock [get_clocks {w_Clk9m}]  0.000 [get_ports {lcd_hsync}]
set_output_delay -add_delay -max -clock [get_clocks {w_Clk9m}]  3.000 [get_ports {lcd_vsync}]
set_output_delay -add_delay -min -clock [get_clocks {w_Clk9m}]  0.000 [get_ports {lcd_vsync}]
set_output_delay -add_delay -max -clock [get_clocks {w_Clk9m}]  3.000 [get_ports {lcd_de}]
set_output_delay -add_delay -min -clock [get_clocks {w_Clk9m}]  0.000 [get_ports {lcd_de}]
set_output_delay -add_delay -max -clock [get_clocks {w_Clk9m}]  3.000 [get_ports {lcd_data[*]}]
set_output_delay -add_delay -min -clock [get_clocks {w_Clk9m}]  0.000 [get_ports {lcd_data[*]}]


#**************************************************************
# Set Clock Groups
#**************************************************************
set_clock_groups -asynchronous -group {w_Clk9m}
set_clock_groups -asynchronous -group {w_Clk72m}

#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from [get_ports {res_n}]
set_false_path -from [get_ports {btn_b}]
