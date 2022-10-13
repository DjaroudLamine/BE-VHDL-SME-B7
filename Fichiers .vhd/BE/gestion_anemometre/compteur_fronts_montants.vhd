Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity compteur_fronts_montants is
port	(
			clk : in std_logic;
			arazb: in std_logic;
			
			en: in std_logic;
			in_signal: in std_logic;
			reset: in std_logic;
			
			val_cpt : out std_logic_vector(7 downto 0);
			etat_pres			: out std_logic_vector(2 downto 0)	
		);
End compteur_fronts_montants;

Architecture ar of compteur_fronts_montants is

Type etat is (etat0, etat1, etat2);

Signal etat_present, etat_suivant: etat;
Signal cpt: std_logic_vector(7 downto 0);


Begin

-- Evolution des états
evolution : process(etat_present,en,in_signal)
	begin
		case etat_present is
			when etat0 => 	if 			en='1' 						then etat_suivant<=etat1;
							else							 		 	 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 			in_signal='1'				then etat_suivant<=etat2;
							elsif 		en='0' 						then etat_suivant<=etat0;
							else									 	 etat_suivant<=etat1;
							end if;
							
			when etat2 => 	if 			in_signal='0'  and en='1'	then etat_suivant<=etat1;
							elsif 		en='0'						then etat_suivant<=etat0;
							else									 	 etat_suivant<=etat2;
							end if;
									
		end case;
	end process;
	
--OK Mémorisation état présent 
memo : process(clk,arazb) 
	begin
		if arazb='0' then etat_present <= etat0;
		elsif clk'event and clk='1' then 
			if reset='1' then etat_present<=etat0;
			else etat_present<=etat_suivant;
			end if;
		end if;
	end process;

--	Génération des actions
--compteur : process(clk,arazb)
--	begin
--		if arazb='0' then cpt<=(others=>'0');
--		elsif clk'event and clk='1' then
--			if reset='1' then cpt<=(others=>'0');
--			elsif 	etat_present=etat1 and in_signal='1'and en='1' then cpt <= cpt+1;
--			elsif  etat_present=etat2 or etat_present=etat1 then cpt<=cpt ;
--			else cpt<=cpt;
--			end if;
--		end if;
--	end process;

etat_pres 		<=	"001" when etat_present = etat1	else
					"010" when etat_present = etat2	else
					"000";
					



			
val_cpt <= cpt;
End ar;