
#Begin clock constraint
define_clock -name {DP_DDS|clkb} {p:DP_DDS|clkb} -period 100000.000 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 50000.000 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {DP_DDS|clka} {p:DP_DDS|clka} -period 100000.000 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 50000.000 -route 0.000 
#End clock constraint
