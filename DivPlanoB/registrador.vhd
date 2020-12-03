LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity registrador is
generic(N: natural := 8);
port (clk, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end registrador;

architecture estrutura OF registrador is
begin
	process(clk)
	begin
		if (clk'event and clk = '1' and carga = '1') then
			q <= d;
		end if;
	end process;
end estrutura;