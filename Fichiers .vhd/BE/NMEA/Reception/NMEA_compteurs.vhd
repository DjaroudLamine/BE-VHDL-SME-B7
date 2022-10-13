Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage_BE.all;

Entity NMEA_compteurs is
port	(
		clk 	: in std_logic;
		arazb 	: in std_logic;
		reset 	: in std_logic;
		en 		: in std_logic;
		
		num_octet		: out std_logic_vector (2 downto 0);
		num_bit			: out std_logic_vector (3 downto 0)
		);
End NMEA_compteurs;

Architecture ar of NMEA_compteurs is

Signal nbr_octet : std_logic_vector(2 downto 0);
Signal nbr_bit : std_logic_vector(3 downto 0);

Begin

Process (clk, arazb)
	Begin
		if arazb='0' then nbr_octet <= (others =>'0'); nbr_bit<= (others =>'0');
		elsif(clk'event and clk='1') then
			if reset='1' then nbr_octet <= (others =>'0'); nbr_bit<= (others =>'0');	
			elsif en='1' then
				if nbr_octet=4 then nbr_octet <= (others =>'0'); nbr_bit<= (others =>'0');
				elsif nbr_bit=9 then nbr_octet <= nbr_octet+1; nbr_bit<= (others =>'0');
				else nbr_bit<= nbr_bit+1;
				end if;

			end if;
		end if;
	End Process;
	

num_octet 	<=nbr_octet;
num_bit		<=nbr_bit;

End ar;