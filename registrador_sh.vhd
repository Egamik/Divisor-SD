LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- Da shift pra direita
ENTITY registrador_sh IS
generic(N: natural:= 4);
PORT (clk, carga, in_shift, shift: IN std_logic;
	  d : IN std_logic_vector(N-1 DOWNTO 0);
	  q : OUT std_logic_vector(N-1 DOWNTO 0);
	  out_shift : out std_logic);
END registrador_sh;

ARCHITECTURE behav OF registrador_sh IS
signal fio: std_logic_vector(n-1 downto 0);
BEGIN
	process(clk)
	begin
		if (clk'event and clk = '1') then
			if (carga = '1' and shift = '0') then
				Q <= d;
			elsif (carga = '0' and shift = '1') then
				out_shift <= fio(fio'high);
				fio <= fio(fio'high-1 downto fio'low) & in_shift;
				Q <= fio;
			end if;
		end if;
	end process;
END behav;
