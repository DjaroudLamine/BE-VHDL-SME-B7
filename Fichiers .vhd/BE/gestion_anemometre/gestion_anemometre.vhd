Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity gestion_anemometre is
port	(
			clk_50M : in std_logic;
			raz_n: in std_logic;
			
			in_freq_anenometre:  in std_logic;
			continu:  in std_logic;
			start_stop:  in std_logic;
			
			data_valid: out std_logic;
			data_anemometre: out std_logic_vector(7 downto 0);
			
			visu_val_cpt : out std_logic_vector(7 downto 0);
			etat_mae_MAE : out std_logic_vector(2 downto 0);
			etat_mae_cpt : out std_logic_vector(2 downto 0)
		);
End gestion_anemometre;

Architecture ar of gestion_anemometre is

Signal iout_timer_1s, ien_timer_1s, ireset_timer_1s, ien_cpt, i_data_valid : std_logic;
Signal ival_cpt_fronts, i_data_anemometre: std_logic_vector(7 downto 0);

Begin

MAE : anemometre_MAE
port map	(
		clk => clk_50M,
		arazb => raz_n,
		
		continu				=> continu,
		start_stop			=> start_stop,
		
	
		timer_1s			=> iout_timer_1s,
		en_timer			=> ien_timer_1s,
		reset_timer 		=> ireset_timer_1s,
		
		val_cpt_fronts		=>ival_cpt_fronts,
		en_cpt_fronts		=> ien_cpt,
		
		data_valid			=> i_data_valid,
		data_anemometre		=> i_data_anemometre,

		etat_pres			=> etat_mae_MAE
		);


cpt_fronts : compteur_fronts_montants 
port	map(
			clk => clk_50M,
			arazb => raz_n,
			
			en => ien_cpt,
			in_signal => in_freq_anenometre,
			val_cpt => ival_cpt_fronts,
			etat_pres	=> etat_mae_cpt
			
		);


timer : timer_1s 
port	map(
		clk => clk_50M,
		arazb => raz_n,
		en	=> ien_timer_1s,
		reset => ireset_timer_1s,
		
		clk_out => iout_timer_1s
		);


bascule :bascule_D
Generic map (8)
port map	(
		clk => clk_50M,
		arazb => raz_n,
		
		en	=> i_data_valid,
		D=>i_data_anemometre,
	
		Q=>data_anemometre
		);

data_valid <= i_data_valid;

visu_val_cpt <= ival_cpt_fronts;

End ar;