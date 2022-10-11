
module Bp_Led (
	bp_external_connection_export,
	clk_clk,
	led_external_connection_export,
	out_pwm_writeresponsevalid_n);	

	input	[1:0]	bp_external_connection_export;
	input		clk_clk;
	output	[7:0]	led_external_connection_export;
	output		out_pwm_writeresponsevalid_n;
endmodule
