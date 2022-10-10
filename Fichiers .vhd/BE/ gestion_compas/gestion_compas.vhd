Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity gestion_compas is
port	(
		clk_50M			: in std_logic;
		raz_n			: in std_logic;
		in_pwm_compas	: in std_logic;
		continu			: in std_logic;
		start_stop		: in std_logic;
		
		etat_mae		: out std_logic_vector(2 downto 0);
		
		data_valid		: out std_logic;
		out_1s			: out std_logic;
		data_compas		: out std_logic_vector(8 downto 0)
		);
End gestion_compas;

Architecture ar of gestion_compas is

Signal idata_valid,ien_cpt, itimer_1s, ireset_cpt, iclk_us, ien_timer, ireset_timer : std_logic;
Signal ival_cpt, idata_compas : std_logic_vector(8 downto 0);

Begin

compteur : cpt
port map(
		clk 	=> iclk_us,
		arazb 	=> raz_n,
		reset 	=> ireset_cpt,
		en 		=> ien_cpt,
		
		S		=> ival_cpt
		);


prediviseur : prediv_us
port map(
		clk_in		=> clk_50M,
		en 			=> '1',
		
		clk_out		=> iclk_us
		);


timer : timer_1s
port map(
		clk 	=> clk_50M,
		arazb 	=> raz_n,
		en		=> ien_timer,
		reset 	=> ireset_timer,
		
		clk_out => itimer_1s
		);


MAE : cap_mae
port map(
		clk			=> clk_50M,
		arazb		=> raz_n,
		
		in_pwm		=> in_pwm_compas,
		mode		=> continu,
		start_stop	=> NOT start_stop,
		
		val_cpt		=> ival_cpt,
		timer_1s	=> itimer_1s,
		
		en_cpt		=> ien_cpt,
		reset_cpt	=> ireset_cpt,
		en_timer	=> ien_timer, 
		reset_timer => ireset_timer,
		
		data_valid	=> idata_valid,
		data_compas	=> idata_compas,
		
		etat_pres	=> etat_mae
		);

bascule : bascule_D 
Generic map (9)
port map(
		clk =>clk_50M,
		arazb => raz_n,
		
		en	=>idata_valid,
		D => idata_compas,
		
		Q => data_compas
		);

out_1s <= itimer_1s;
data_valid <= idata_valid;

End ar;

