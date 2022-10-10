
module Bp_Led (
	clk_clk,
	bp_external_connection_export,
	led_external_connection_export);	

	input		clk_clk;
	input	[1:0]	bp_external_connection_export;
	output	[7:0]	led_external_connection_export;
endmodule
