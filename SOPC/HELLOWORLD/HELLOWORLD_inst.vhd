	component HELLOWORLD is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component HELLOWORLD;

	u0 : component HELLOWORLD
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

