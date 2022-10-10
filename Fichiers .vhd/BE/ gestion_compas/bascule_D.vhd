Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;


Entity bascule_D is

Generic (n : natural :=8);
port	(
		clk : in std_logic;
		arazb : in std_logic;
		
		en	: in std_logic;
		D : in std_logic_vector(n-1 downto 0);
		
		Q : out std_logic_vector(n-1 downto 0)
		);
end bascule_D;

Architecture ar of bascule_D is

Begin

Process (clk, arazb)
Begin
	if (arazb='0') 
		then Q<=(others=>'0');
	elsif(clk'event and clk='1') 
		then
		if en ='1' then Q<=D ;
		end if;
	end if;
end process;

End ar;