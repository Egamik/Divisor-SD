library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity tb_Divisor is
generic(N: natural:= 8); 
end tb_Divisor;

architecture tb of tb_Divisor is
signal clk1: std_logic;
signal reset1: std_logic;
signal inicio1: std_logic;
signal DIVIDENDO1: std_logic_vector(N-1 downto 0);
signal DIVISOR1: std_logic_vector(N-1 downto 0);
signal pronto1: std_logic;
signal Quociente1: std_logic_vector(N-1 downto 0);
signal Resto1: std_logic_vector(N-1 downto 0);


	component Divisor is 
	generic(N: natural:= 8);
	port(Rst, CLK, inicio: in std_logic;
		DIVIDENDO, DIVISOR: in std_logic_vector(n-1 downto 0); 
		pronto: out std_logic;
		Quociente, Resto: out std_logic_vector(n-1 downto 0));
	end component;
	
begin 

UUT: entity work.Divisor port map(Rst => reset1, CLK => clk1, inicio => inicio1, DIVIDENDO => DIVIDENDO1, DIVISOR => DIVISOR1 , pronto => pronto1, Quociente => Quociente1, Resto => Resto1);

	reset1 <= '1', '0' after 20 ns;
	
	inicio1 <= '0', '1' after 20 ns, '0' after 40 ns;
	
	-- lembrar de arrumar os valores quando for trabalhar com 8 bits
	DIVIDENDO1 <= "00010000";
	DIVISOR1 <= "00000010";
	
	tb1 :process
        constant periodo: time := 20 ns; 
        begin
				clk1 <= '1';
            wait for periodo/2; 
				clk1 <= '0';
				wait for periodo/2;
        end process;
end tb;