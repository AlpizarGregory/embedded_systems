
module BasicNIOS (
	clk_clk,
	leds_output_export,
	reset_reset_n,
	gpio_input_export);	

	input		clk_clk;
	output	[7:0]	leds_output_export;
	input		reset_reset_n;
	input	[3:0]	gpio_input_export;
endmodule
