	audio_soc u0 (
		.clk_clk               (<connected-to-clk_clk>),               //            clk.clk
		.reset_reset_n         (<connected-to-reset_reset_n>),         //          reset.reset_n
		.seven_segments_export (<connected-to-seven_segments_export>), // seven_segments.export
		.buttons_export        (<connected-to-buttons_export>),        //        buttons.export
		.audio_xclkx_clk       (<connected-to-audio_xclkx_clk>),       //    audio_xclkx.clk
		.audio_config_SDAT     (<connected-to-audio_config_SDAT>),     //   audio_config.SDAT
		.audio_config_SCLK     (<connected-to-audio_config_SCLK>)      //               .SCLK
	);

