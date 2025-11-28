
module BasicNIOS (
	clk_clk,
	gpio_input_export,
	leds_output_export,
	reset_reset_n,
	switch_input_export);	

	input		clk_clk;
	input	[3:0]	gpio_input_export;
	output	[31:0]	leds_output_export;
	input		reset_reset_n;
	input	[9:0]	switch_input_export;
endmodule
