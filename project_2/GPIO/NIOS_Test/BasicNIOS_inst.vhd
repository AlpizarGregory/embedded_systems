	component BasicNIOS is
		port (
			clk_clk            : in    std_logic                    := 'X';             -- clk
			gpio_input_export  : inout std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_output_export : out   std_logic_vector(7 downto 0);                    -- export
			reset_reset_n      : in    std_logic                    := 'X'              -- reset_n
		);
	end component BasicNIOS;

	u0 : component BasicNIOS
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			gpio_input_export  => CONNECTED_TO_gpio_input_export,  --  gpio_input.export
			leds_output_export => CONNECTED_TO_leds_output_export, -- leds_output.export
			reset_reset_n      => CONNECTED_TO_reset_reset_n       --       reset.reset_n
		);

