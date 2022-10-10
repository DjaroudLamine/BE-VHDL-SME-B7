Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;


Entity timer_1s is
port	(
		clk : in std_logic;
		arazb : in std_logic;
		en	: in std_logic;
		reset : in std_logic;
		
		clk_out : out std_logic
		);
end timer_1s;

Architecture ar of timer_1s is

-- freq in: 50 MHz //test 50Mhz //test 2
-- freq out: 1 Hz //25 mhz //test 2 12.5
-- valeur cpt = (freq in / freq out)/2 -1

signal compteur: integer:=0;
signal var_temp : std_logic := '0';

Begin  
  
Process(clk,arazb,reset,en)
	begin
		if arazb='0' then compteur<=0;
		elsif(clk'event and clk='1') then
			if reset='1' then compteur<=0; var_temp <='0';
			elsif en='1' then
				if (compteur = 24999999) then --/4 = 1 --24 999 999 -49 999 999
					--1s=24999999  / 249=10us
					var_temp <= NOT var_temp;
					compteur <= 0;
				else compteur <=compteur+1;
				end if;
			end if;
		end if;
	end process;
	
clk_out <= var_temp;	
End ar;