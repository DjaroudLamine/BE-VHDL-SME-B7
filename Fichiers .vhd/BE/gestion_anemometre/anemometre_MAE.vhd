Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity anemometre_MAE is
port	(
		clk					: in std_logic;
		arazb				: in std_logic;
		
		continu				: in std_logic;
		start_stop			: in std_logic;
	
		timer_1s			: in std_logic;
		en_timer			: out std_logic;
		reset_timer 		: out std_logic;
		reset_cpt     		: out std_logic;
		
		val_cpt_fronts		: in std_logic_vector(7 downto 0);
		en_cpt_fronts		: out std_logic;
		
		data_valid			: out std_logic;
		data_anemometre		: out std_logic_vector(7 downto 0);

		etat_pres			: out std_logic_vector(2 downto 0)
		);
End anemometre_MAE;

Architecture ar of anemometre_MAE is

Type etat is (etat0, etat1, etat2, etat3, etat4);

Signal etat_present, etat_suivant: etat;



Begin

-- Evolution des états
evolution : process(etat_present,continu,start_stop,timer_1s)
	begin
		case etat_present is
			when etat0 => 	if 		continu='0'						then etat_suivant<=etat1;
							elsif 	continu='1'						then etat_suivant<=etat2;
							else									 	 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 		start_stop='1' 					then etat_suivant<=etat2;
							else										 etat_suivant<=etat1;
							end if;					
							
			when etat2 => 	if 		timer_1s='1' 					then etat_suivant<=etat3;
							else										 etat_suivant<=etat2;
							end if;
							
			when etat3 => 	if 		timer_1s='1' 					then etat_suivant<=etat4;
							else										 etat_suivant<=etat3;
							end if;				
							
			when etat4 => 	if 		continu='0' and start_stop='1' 	then etat_suivant<=etat2;
							elsif 	continu='1' 					then etat_suivant<=etat2;
							else									 	 etat_suivant<=etat4;
							end if;				
		end case;
	end process;
	
--OK Mémorisation état présent 
memo : process(clk,arazb)
	begin
		if arazb='0' then etat_present <= etat0;
		elsif clk'event and clk='1' then etat_present<=etat_suivant;
		end if;
	end process;
	
-- Génération des actions
data_valid		<= '1' when etat_present = etat3 else '0';	
data_anemometre	<= val_cpt_fronts+val_cpt_fronts when etat_present = etat3 else (others=>'0');

etat_pres 		<=	"001" when etat_present = etat1	else
					"010" when etat_present = etat2	else
					"011" when etat_present = etat3	else
					"100" when etat_present = etat4	else
					"000";
					
en_timer	<= '1' when etat_present = etat2 or etat_present = etat3 else '0';
reset_timer <= '1' when etat_present = etat4 or etat_present=etat0 else
			   '1' when etat_present=etat2 and timer_1s='1' else
			   '0';
			  
reset_cpt <=   '1' when etat_present = etat4 or etat_present=etat0 else
			   '0';			   

en_cpt_fronts <= '1' when etat_present = etat2 else '0';
				
End ar;