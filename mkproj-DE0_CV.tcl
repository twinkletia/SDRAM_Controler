#!quartus_sh -t
#

package require cmdline
set options {
	{ "project.arg" "" "project name" }
	{ "script.arg" "" "script file" }
	{ "reset.arg" "" "reset name" }
	{ "fit.arg" "" "fit name" }
}
set usage "\[options\] \[files...\]"
array set opt [::cmdline::getoptions ::argv $options $usage]

if {$opt(project) == ""} {
	return -code error "Usage: $argv0 $usage"
}

########

project_new $opt(project) -overwrite

set_global_assignment -name TOP_LEVEL_ENTITY $opt(project)
foreach arg $argv {
	set_global_assignment -name VERILOG_FILE $arg
}

if {$opt(script) != ""} {
	set_global_assignment -name PRE_FLOW_SCRIPT_FILE "quartus_sh:$opt(script)"
}

if {$opt(fit) != ""} {
	set_global_assignment -name FITTER_EFFORT "$opt(fit)"
}

########

create_base_clock -fmax 50MHz -duty_cycle 50 m_clock

set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"

set_location_assignment PIN_M9 -to m_clock
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to m_clock

set_location_assignment PIN_P22 -to p_reset
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to p_reset




#============================================================
# Altera DE1-SoC board settings
#============================================================

set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CEBA4F23C7
set_global_assignment -name TOP_LEVEL_ENTITY "DE0_CV"

set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name SDC_FILE DE0_CV.sdc
set_global_assignment -name ENABLE_SIGNALTAP ON
set_global_assignment -name USE_SIGNALTAP_FILE stp1.stp


set_location_assignment PIN_H13 -to CLOCK2_50
set_location_assignment PIN_E10 -to CLOCK3_50
set_location_assignment PIN_V15 -to CLOCK4_50
set_location_assignment PIN_M9 -to CLOCK_50
set_location_assignment PIN_W8 -to DRAM_ADDR[0]
set_location_assignment PIN_T8 -to DRAM_ADDR[1]
set_location_assignment PIN_U11 -to DRAM_ADDR[2]
set_location_assignment PIN_Y10 -to DRAM_ADDR[3]
set_location_assignment PIN_N6 -to DRAM_ADDR[4]
set_location_assignment PIN_AB10 -to DRAM_ADDR[5]
set_location_assignment PIN_P12 -to DRAM_ADDR[6]
set_location_assignment PIN_P7 -to DRAM_ADDR[7]
set_location_assignment PIN_P8 -to DRAM_ADDR[8]
set_location_assignment PIN_R5 -to DRAM_ADDR[9]
set_location_assignment PIN_U8 -to DRAM_ADDR[10]
set_location_assignment PIN_P6 -to DRAM_ADDR[11]
set_location_assignment PIN_R7 -to DRAM_ADDR[12]
set_location_assignment PIN_T7 -to DRAM_BA[0]
set_location_assignment PIN_AB7 -to DRAM_BA[1]
set_location_assignment PIN_V6 -to DRAM_CAS_N
set_location_assignment PIN_R6 -to DRAM_CKE
set_location_assignment PIN_AB11 -to DRAM_CLK
set_location_assignment PIN_U6 -to DRAM_CS_N
set_location_assignment PIN_Y9 -to DRAM_DQ[0]
set_location_assignment PIN_T10 -to DRAM_DQ[1]
set_location_assignment PIN_R9 -to DRAM_DQ[2]
set_location_assignment PIN_Y11 -to DRAM_DQ[3]
set_location_assignment PIN_R10 -to DRAM_DQ[4]
set_location_assignment PIN_R11 -to DRAM_DQ[5]
set_location_assignment PIN_R12 -to DRAM_DQ[6]
set_location_assignment PIN_AA12 -to DRAM_DQ[7]
set_location_assignment PIN_AA9 -to DRAM_DQ[8]
set_location_assignment PIN_AB8 -to DRAM_DQ[9]
set_location_assignment PIN_AA8 -to DRAM_DQ[10]
set_location_assignment PIN_AA7 -to DRAM_DQ[11]
set_location_assignment PIN_V10 -to DRAM_DQ[12]
set_location_assignment PIN_V9 -to DRAM_DQ[13]
set_location_assignment PIN_U10 -to DRAM_DQ[14]
set_location_assignment PIN_T9 -to DRAM_DQ[15]
set_location_assignment PIN_U12 -to DRAM_LDQM
set_location_assignment PIN_AB6 -to DRAM_RAS_N
set_location_assignment PIN_N8 -to DRAM_UDQM
set_location_assignment PIN_AB5 -to DRAM_WE_N
set_location_assignment PIN_U21 -to HEX0[0]
set_location_assignment PIN_V21 -to HEX0[1]
set_location_assignment PIN_W22 -to HEX0[2]
set_location_assignment PIN_W21 -to HEX0[3]
set_location_assignment PIN_Y22 -to HEX0[4]
set_location_assignment PIN_Y21 -to HEX0[5]
set_location_assignment PIN_AA22 -to HEX0[6]
set_location_assignment PIN_AA20 -to HEX1[0]
set_location_assignment PIN_AB20 -to HEX1[1]
set_location_assignment PIN_AA19 -to HEX1[2]
set_location_assignment PIN_AA18 -to HEX1[3]
set_location_assignment PIN_AB18 -to HEX1[4]
set_location_assignment PIN_AA17 -to HEX1[5]
set_location_assignment PIN_U22 -to HEX1[6]
set_location_assignment PIN_Y19 -to HEX2[0]
set_location_assignment PIN_AB17 -to HEX2[1]
set_location_assignment PIN_AA10 -to HEX2[2]
set_location_assignment PIN_Y14 -to HEX2[3]
set_location_assignment PIN_V14 -to HEX2[4]
set_location_assignment PIN_AB22 -to HEX2[5]
set_location_assignment PIN_AB21 -to HEX2[6]
set_location_assignment PIN_Y16 -to HEX3[0]
set_location_assignment PIN_W16 -to HEX3[1]
set_location_assignment PIN_Y17 -to HEX3[2]
set_location_assignment PIN_V16 -to HEX3[3]
set_location_assignment PIN_U17 -to HEX3[4]
set_location_assignment PIN_V18 -to HEX3[5]
set_location_assignment PIN_V19 -to HEX3[6]
set_location_assignment PIN_U20 -to HEX4[0]
set_location_assignment PIN_Y20 -to HEX4[1]
set_location_assignment PIN_V20 -to HEX4[2]
set_location_assignment PIN_U16 -to HEX4[3]
set_location_assignment PIN_U15 -to HEX4[4]
set_location_assignment PIN_Y15 -to HEX4[5]
set_location_assignment PIN_P9 -to HEX4[6]
set_location_assignment PIN_N9 -to HEX5[0]
set_location_assignment PIN_M8 -to HEX5[1]
set_location_assignment PIN_T14 -to HEX5[2]
set_location_assignment PIN_P14 -to HEX5[3]
set_location_assignment PIN_C1 -to HEX5[4]
set_location_assignment PIN_C2 -to HEX5[5]
set_location_assignment PIN_W19 -to HEX5[6]
set_location_assignment PIN_U7 -to KEY[0]
set_location_assignment PIN_W9 -to KEY[1]
set_location_assignment PIN_M7 -to KEY[2]
set_location_assignment PIN_M6 -to KEY[3]
set_location_assignment PIN_AA2 -to LEDR[0]
set_location_assignment PIN_AA1 -to LEDR[1]
set_location_assignment PIN_W2 -to LEDR[2]
set_location_assignment PIN_Y3 -to LEDR[3]
set_location_assignment PIN_N2 -to LEDR[4]
set_location_assignment PIN_N1 -to LEDR[5]
set_location_assignment PIN_U2 -to LEDR[6]
set_location_assignment PIN_U1 -to LEDR[7]
set_location_assignment PIN_L2 -to LEDR[8]
set_location_assignment PIN_L1 -to LEDR[9]
#set_location_assignment PIN_P22 -to RESET_N
set_location_assignment PIN_U13 -to SW[0]
set_location_assignment PIN_V13 -to SW[1]
set_location_assignment PIN_T13 -to SW[2]
set_location_assignment PIN_T12 -to SW[3]
set_location_assignment PIN_AA15 -to SW[4]
set_location_assignment PIN_AB15 -to SW[5]
set_location_assignment PIN_AA14 -to SW[6]
set_location_assignment PIN_AA13 -to SW[7]
set_location_assignment PIN_AB13 -to SW[8]
set_location_assignment PIN_AB12 -to SW[9]

#============================================================
# CLOCK2
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK2_50

#============================================================
# CLOCK3
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK3_50

#============================================================
# CLOCK4
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK4_50

#============================================================
# CLOCK
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CLOCK_50

#============================================================
# DRAM
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CAS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CKE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_LDQM
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_RAS_N
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_UDQM
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_WE_N

#============================================================
# HEX0
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[6]

#============================================================
# HEX1
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[6]

#============================================================
# HEX2
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[6]

#============================================================
# HEX3
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3[6]

#============================================================
# HEX4
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4[6]

#============================================================
# HEX5
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5[6]

#============================================================
# KEY
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to KEY[3]

#============================================================
# LEDR
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LEDR[9]

#============================================================
# RESET
#============================================================
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to RESET_N

#============================================================
# SW
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW[9]

#============================================================
# End of pin and io_standard assignments
#============================================================

set_instance_assignment -name PLL_COMPENSATION_MODE DIRECT -to "*pll*|altera_pll:altera_pll_i*|*" 
set_instance_assignment -name PLL_AUTO_RESET OFF -to "*pll*|altera_pll:altera_pll_i*|*"
set_instance_assignment -name PLL_BANDWIDTH_PRESET AUTO -to "*pll*|altera_pll:altera_pll_i*|*"
project_close

