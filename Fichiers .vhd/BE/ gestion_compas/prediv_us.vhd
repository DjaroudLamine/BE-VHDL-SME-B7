Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

-- 50 mhz (T=20ns) en entrée pour 100us en sortie

Entity prediv_us is
port	(
		clk_in		: in std_logic;
		en 			: in std_logic;
		
		clk_out		: out std_logic
		);
End prediv_us;

Architecture ar of prediv_us is
-- 50 MHz 	= 20 ns
-- 1  MHz	= 1 us
-- 10 KHz	= 100 us

-- 50 000 000
--     10 000
--          1

signal compteur: integer:=0;
signal var_temp : std_logic := '0';

Begin  
  
Process(clk_in)
	begin
		if(clk_in'event and clk_in='1') then	
			if (en='1') then
				if (compteur = 2499 ) then --24 999 999 1s -- 2499= 100us --24=1us --249=10us
				var_temp <= NOT var_temp;
				compteur <= 0;
				else compteur <=compteur+1;
				end if;
			end if;
		end if;
	end process;
	
clk_out <= var_temp;	

End ar;