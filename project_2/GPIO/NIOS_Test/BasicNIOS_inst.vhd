	component BasicNIOS is
		port (
			clk_clk             : in  std_logic                     := 'X';             -- clk
			gpio_input_export   : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			leds_output_export  : out std_logic_vector(31 downto 0);                    -- export
			reset_reset_n       : in  std_logic                     := 'X';             -- reset_n
			switch_input_export : in  std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component BasicNIOS;

	u0 : component BasicNIOS
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --          clk.clk
			gpio_input_export   => CONNECTED_TO_gpio_input_export,   --   gpio_input.export
			leds_output_export  => CONNECTED_TO_leds_output_export,  --  leds_output.export
			reset_reset_n       => CONNECTED_TO_reset_reset_n,       --        reset.reset_n
			switch_input_export => CONNECTED_TO_switch_input_export  -- switch_input.export
		);

