Library ieee;
Use ieee.std_logic_1164.all;

Package mypackage_BE is

Component bascule_D_1bit is
port	(
		clk : in std_logic;
		arazb : in std_logic;
		
		en	: in std_logic;
		D : in std_logic;
		
		Q : out std_logic
		);
end Component;

Component bascule_D is
Generic (n : natural :=8);
port	(
		clk : in std_logic;
		arazb : in std_logic;
		
		en	: in std_logic;
		D : in std_logic_vector(n-1 downto 0);
		
		Q : out std_logic_vector(n-1 downto 0)
		);
end Component;

Component deco_7seg is
port	(
		E 		: in std_logic_vector (3 downto 0);		
		S 		: out std_logic_vector (6 downto 0)
		);
End Component;
		
Component cpt is
port	(
		clk 	: in std_logic;
		arazb 	: in std_logic;
		reset 	: in std_logic;
		en 		: in std_logic;
		
		S		: out std_logic_vector (8 downto 0)
		);
End Component;

Component prediv_us is
port	(
		clk_in		: in std_logic;
		en 			: in std_logic;
		
		clk_out		: out std_logic
		);
End Component;

Component timer_1s is
port	(
		clk : in std_logic;
		arazb : in std_logic;
		en	: in std_logic;
		reset : in std_logic;
		
		clk_out : out std_logic
		);
end Component;

Component cap_mae is
port	(
		clk			: in std_logic;
		arazb		: in std_logic;
		
		in_pwm		: in std_logic;
		mode		: in std_logic;
		start_stop	: in std_logic;
		
		val_cpt		: in std_logic_vector (8 downto 0);
		timer_1s	: in std_logic;
		
		en_cpt		: out std_logic;
		reset_cpt	: out std_logic;
		en_timer	: out std_logic;
		reset_timer : out std_logic;
		
		data_valid	: out std_logic;
		data_compas	: out std_logic_vector(8 downto 0);
		
		etat_pres	: out std_logic_vector(2 downto 0)
		);
End Component;

Component gestion_compas is
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
End Component;

Component anemometre_MAE is
port	(
		clk					: in std_logic;
		arazb				: in std_logic;
		
		continu				: in std_logic;
		start_stop			: in std_logic;
		
	
		timer_1s			: in std_logic;
		en_timer			: out std_logic;
		reset_timer 		: out std_logic;
		
		val_cpt_fronts		: in std_logic_vector(7 downto 0);
		en_cpt_fronts		: out std_logic;
		
		data_valid			: out std_logic;
		data_anemometre		: out std_logic_vector(7 downto 0);

		etat_pres			: out std_logic_vector(2 downto 0)
		);
End Component;

Component compteur_fronts_montants is
port	(
			clk : in std_logic;
			arazb: in std_logic;
			
			en: in std_logic;
			in_signal: in std_logic;
			val_cpt : out std_logic_vector(7 downto 0);
			etat_pres			: out std_logic_vector(2 downto 0)
			
		);
End Component;

Component NMEA_reception_mae is
port	(
		clk			: in std_logic;
		arazb		: in std_logic;
		
		mode		: in std_logic;
		start_stop	: in std_logic;
		
		trame: in std_logic;
		
		val_cpt : in std_logic_vector(8 downto 0);
		
		en_bascule		: out std_logic;
		en_cpt			: out std_logic;
		reset_cpt			: out std_logic;
		en_prediv: out std_logic;
		
		data_valid	: out std_logic;

		etat_pres	: out std_logic_vector(2 downto 0)
		);
End Component;

Component NMEA_reception_affichage is
port	(
			en		: in std_logic;
			E 		: in std_logic_vector (7 downto 0);		
			S 		: out std_logic_vector (6 downto 0)
			
		);
End Component;

End mypackage_BE;
