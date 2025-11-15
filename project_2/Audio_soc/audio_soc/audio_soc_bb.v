
module audio_soc (
	clk_clk,
	reset_reset_n,
	seven_segments_export,
	buttons_export,
	audio_xclkx_clk,
	audio_config_SDAT,
	audio_config_SCLK);	

	input		clk_clk;
	input		reset_reset_n;
	output	[27:0]	seven_segments_export;
	input	[2:0]	buttons_export;
	output		audio_xclkx_clk;
	inout		audio_config_SDAT;
	output		audio_config_SCLK;
endmodule
