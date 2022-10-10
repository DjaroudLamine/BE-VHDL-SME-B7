	component HELLO is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component HELLO;

	u0 : component HELLO
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

