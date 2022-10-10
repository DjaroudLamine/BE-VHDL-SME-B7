Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity cap_mae is
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
End cap_mae;

Architecture ar of cap_mae is

Type etat is (etat0, etat1, etat2, etat3, etat4, etat5);

Signal etat_present, etat_suivant: etat;



Begin

-- Evolution des états
evolution : process(etat_present,mode,in_pwm,start_stop,timer_1s)
	begin
		case etat_present is
			when etat0 => 	if 		mode='0'					then etat_suivant<=etat1;
							elsif 	mode='1'					then etat_suivant<=etat2;
							else									 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 		start_stop='1' 				then etat_suivant<=etat3;
							else									 etat_suivant<=etat1;
							end if;
							
			when etat2 => 	if 		in_pwm='1' 					then etat_suivant<=etat4;
							else									 etat_suivant<=etat2;
							end if;
							
			when etat3 => 	if 		in_pwm='1' 					then etat_suivant<=etat4;
							else									 etat_suivant<=etat3;
							end if;
							
			when etat4 => 	if 		in_pwm='0' 					then etat_suivant<=etat5;
							else									 etat_suivant<=etat4;
							end if;
							
			when etat5 => 	if 		mode='0' and start_stop='1'	then etat_suivant<=etat3;
							elsif 	mode='1' and timer_1s='1'	then etat_suivant<=etat2;
							else									 etat_suivant<=etat5;
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
en_cpt			<= '1' when etat_present = etat4 else '0';	
reset_cpt		<= '1' when etat_present = etat3 or etat_present = etat2 else '0';

data_valid		<= '1' when etat_present = etat5 else '0';	
data_compas		<= (val_cpt-10) when etat_present = etat5 else (others=>'0'); --offset

etat_pres 		<=	"001" when etat_present = etat1	else
					"010" when etat_present = etat2	else
					"011" when etat_present = etat3	else
					"100" when etat_present = etat4	else
					"101" when etat_present = etat5	else
					"000";
					
en_timer	<= '1' when etat_present = etat5 else '0';
reset_timer <= '1' when etat_present = etat2 else '0';
				
End ar;