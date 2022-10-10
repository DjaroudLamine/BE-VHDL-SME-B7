Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity cpt is
port	(
		clk 	: in std_logic;
		arazb 	: in std_logic;
		reset 	: in std_logic;
		en 		: in std_logic;
		
		S		: out std_logic_vector (8 downto 0)
		);
End cpt;

Architecture ar of cpt is

Signal nombre : std_logic_vector(8 downto 0);

Begin

Process (clk, arazb)
	Begin
		if arazb='0' then nombre <= (others =>'0');
		elsif(clk'event and clk='1') then
			if reset='1' then nombre <= (others =>'0');
			elsif en='1' then
				if nombre=370 then nombre <= (others =>'0'); -- 8bits: 255
				else nombre <= nombre+1;
				end if;

			end if;
		end if;
	End Process;
	
S<=nombre;

End ar;