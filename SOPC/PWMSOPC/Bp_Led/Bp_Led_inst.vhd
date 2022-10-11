	component Bp_Led is
		port (
			bp_external_connection_export  : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			clk_clk                        : in  std_logic                    := 'X';             -- clk
			led_external_connection_export : out std_logic_vector(7 downto 0);                    -- export
			out_pwm_writeresponsevalid_n   : out std_logic                                        -- writeresponsevalid_n
		);
	end component Bp_Led;

	u0 : component Bp_Led
		port map (
			bp_external_connection_export  => CONNECTED_TO_bp_external_connection_export,  --  bp_external_connection.export
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                     clk.clk
			led_external_connection_export => CONNECTED_TO_led_external_connection_export, -- led_external_connection.export
			out_pwm_writeresponsevalid_n   => CONNECTED_TO_out_pwm_writeresponsevalid_n    --                 out_pwm.writeresponsevalid_n
		);

