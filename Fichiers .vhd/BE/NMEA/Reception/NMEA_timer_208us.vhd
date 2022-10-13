Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity NMEA_timer_208us is
port	(
		clk_in		: in std_logic;
		en 			: in std_logic;
		reset		: in std_logic;
		
		clk_out		: out std_logic
		);
End NMEA_timer_208us;

Architecture ar of NMEA_timer_208us is


signal compteur: integer:=0;
signal var_temp : std_logic := '0';

Begin  
  
Process(clk_in)
	begin
		if(clk_in'event and clk_in='1') then
			if reset='1' then compteur <= 0; var_temp <='0';	
			elsif en='1' then
				if (compteur = 5199 ) then --24 999 999 1s -- 2499= 100us --24=1us --249=10us
				var_temp <= NOT var_temp;
				compteur <= 0;
				else compteur <=compteur+1;
				end if;
			end if;
		end if;
	end process;
	
clk_out <= var_temp;	

End ar;