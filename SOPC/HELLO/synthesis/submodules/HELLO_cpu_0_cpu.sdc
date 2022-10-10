# Legal Notice: (C)2022 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	HELLO_cpu_0_cpu 	HELLO_cpu_0_cpu:*
set 	HELLO_cpu_0_cpu_oci 	HELLO_cpu_0_cpu_nios2_oci:the_HELLO_cpu_0_cpu_nios2_oci
set 	HELLO_cpu_0_cpu_oci_break 	HELLO_cpu_0_cpu_nios2_oci_break:the_HELLO_cpu_0_cpu_nios2_oci_break
set 	HELLO_cpu_0_cpu_ocimem 	HELLO_cpu_0_cpu_nios2_ocimem:the_HELLO_cpu_0_cpu_nios2_ocimem
set 	HELLO_cpu_0_cpu_oci_debug 	HELLO_cpu_0_cpu_nios2_oci_debug:the_HELLO_cpu_0_cpu_nios2_oci_debug
set 	HELLO_cpu_0_cpu_wrapper 	HELLO_cpu_0_cpu_debug_slave_wrapper:the_HELLO_cpu_0_cpu_debug_slave_wrapper
set 	HELLO_cpu_0_cpu_jtag_tck 	HELLO_cpu_0_cpu_debug_slave_tck:the_HELLO_cpu_0_cpu_debug_slave_tck
set 	HELLO_cpu_0_cpu_jtag_sysclk 	HELLO_cpu_0_cpu_debug_slave_sysclk:the_HELLO_cpu_0_cpu_debug_slave_sysclk
set 	HELLO_cpu_0_cpu_oci_path 	 [format "%s|%s" $HELLO_cpu_0_cpu $HELLO_cpu_0_cpu_oci]
set 	HELLO_cpu_0_cpu_oci_break_path 	 [format "%s|%s" $HELLO_cpu_0_cpu_oci_path $HELLO_cpu_0_cpu_oci_break]
set 	HELLO_cpu_0_cpu_ocimem_path 	 [format "%s|%s" $HELLO_cpu_0_cpu_oci_path $HELLO_cpu_0_cpu_ocimem]
set 	HELLO_cpu_0_cpu_oci_debug_path 	 [format "%s|%s" $HELLO_cpu_0_cpu_oci_path $HELLO_cpu_0_cpu_oci_debug]
set 	HELLO_cpu_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $HELLO_cpu_0_cpu_oci_path $HELLO_cpu_0_cpu_wrapper $HELLO_cpu_0_cpu_jtag_tck]
set 	HELLO_cpu_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $HELLO_cpu_0_cpu_oci_path $HELLO_cpu_0_cpu_wrapper $HELLO_cpu_0_cpu_jtag_sysclk]
set 	HELLO_cpu_0_cpu_jtag_sr 	 [format "%s|*sr" $HELLO_cpu_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$HELLO_cpu_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$HELLO_cpu_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$HELLO_cpu_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$HELLO_cpu_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$HELLO_cpu_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$HELLO_cpu_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$HELLO_cpu_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$HELLO_cpu_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$HELLO_cpu_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$HELLO_cpu_0_cpu_jtag_sr*]
set_false_path -from *$HELLO_cpu_0_cpu_jtag_sr*    -to *$HELLO_cpu_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$HELLO_cpu_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$HELLO_cpu_0_cpu_oci_debug_path|monitor_go
