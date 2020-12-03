LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity registrador_r is
generic(N: natural := 8);
port (clk, reset, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end registrador_r;

ARCHITECTURE estrutura OF registrador_r IS

constant Zeros : std_logic_vector(q'range) := (others => '0'); -- Cria uma constante de mesmo tamanho de q e preenche com zeros.

BEGIN
	PROCESS(clk, reset)
	BEGIN
		IF(reset = '1') THEN
			q <= zeros;
		ELSIF(clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;