	component Bp_Led is
		port (
			clk_clk                        : in  std_logic                    := 'X';             -- clk
			bp_external_connection_export  : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			led_external_connection_export : out std_logic_vector(7 downto 0)                     -- export
		);
	end component Bp_Led;

	u0 : component Bp_Led
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                     clk.clk
			bp_external_connection_export  => CONNECTED_TO_bp_external_connection_export,  --  bp_external_connection.export
			led_external_connection_export => CONNECTED_TO_led_external_connection_export  -- led_external_connection.export
		);

