
module BasicNIOS (
	clk_clk,
	gpio_input_export,
	leds_output_export,
	reset_reset_n);	

	input		clk_clk;
	inout	[3:0]	gpio_input_export;
	output	[7:0]	leds_output_export;
	input		reset_reset_n;
endmodule
