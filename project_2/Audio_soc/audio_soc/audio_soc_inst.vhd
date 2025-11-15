	component audio_soc is
		port (
			clk_clk               : in    std_logic                     := 'X';             -- clk
			reset_reset_n         : in    std_logic                     := 'X';             -- reset_n
			seven_segments_export : out   std_logic_vector(27 downto 0);                    -- export
			buttons_export        : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- export
			audio_xclkx_clk       : out   std_logic;                                        -- clk
			audio_config_SDAT     : inout std_logic                     := 'X';             -- SDAT
			audio_config_SCLK     : out   std_logic                                         -- SCLK
		);
	end component audio_soc;

	u0 : component audio_soc
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --            clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --          reset.reset_n
			seven_segments_export => CONNECTED_TO_seven_segments_export, -- seven_segments.export
			buttons_export        => CONNECTED_TO_buttons_export,        --        buttons.export
			audio_xclkx_clk       => CONNECTED_TO_audio_xclkx_clk,       --    audio_xclkx.clk
			audio_config_SDAT     => CONNECTED_TO_audio_config_SDAT,     --   audio_config.SDAT
			audio_config_SCLK     => CONNECTED_TO_audio_config_SCLK      --               .SCLK
		);

