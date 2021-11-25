project_new blink -overwrite
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE6E22C8
set_global_assignment -name TOP_LEVEL_ENTITY blink
set_parameter -name clk_freq_hz 50000000
set_global_assignment -name VERILOG_FILE blink.v
set_global_assignment -name SDC_FILE rz_easyfpga_a2.x.sdc
source pinmap.tcl
