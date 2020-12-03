library ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;

entity igualazero is
generic(N: natural:= 8);
port (entrada : in std_logic_vector(N-1 downto 0);
saida : out std_logic);
end igualazero;

architecture comportamento of igualazero is

constant Zeros : std_logic_vector(entrada'range) := (others => '0');

begin
	saida <= '1' when (entrada = Zeros) else '0';
end comportamento;