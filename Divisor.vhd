LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Divisor is 
generic(N: natural:= 8);
port(Rst, CLK, inicio: in std_logic;
	  DIVIDENDO, DIVISOR: in std_logic_vector(n-1 downto 0); 
	  pronto: out std_logic;
	  Quociente, Resto: out std_logic_vector(n-1 downto 0));
end Divisor;

architecture bhv of Divisor is 

signal EN0_1, EN1_1, shl_1, shr_1,saiCOMPARADOR_1, outCount_1, m_1 : std_logic;

 
	component bc is
	port (clk, rst, init: in std_logic;
			saidacomp, contz: in std_logic;
			m: out std_logic; -- Sinais dos mux
			EN0, EN1: out std_logic; -- sinais dos registradores
			shl, shr: out std_logic; -- sinais de shifts
			pronto: out std_logic
			);
	end component;
	
	component bo IS
	generic (n: natural:= 8);
	port (clk: in std_logic;
			DIVIDENDO, DIVISOR: in std_logic_vector(n-1 downto 0); -- Entradas
			shDIV, shQUO: in std_logic; 		 					 -- Enable shift
			cargaDIV, cargaQUO, cargaREM, cargaCONT: in std_logic; -- Carga dos 4 reg
			selMUX: in std_logic;										 	 -- Seletor mux
			saiCOMPARADOR: out std_logic;									 -- Saida comparador de magnitude
			outREM, outQUO: out std_logic_vector(n-1 downto 0); 	 -- Resultados
			outCount: out std_logic											 -- Saida comparador de CONT
			);
	end component;


begin 

BC1: bc port map(CLK, Rst, inicio,saiCOMPARADOR_1, outCount_1, m_1, EN0_1, EN1_1, shl_1, shr_1, pronto);
BO1: bo port map(CLK, DIVIDENDO, DIVISOR, shr_1, shl_1, EN0_1, EN0_1, EN1_1, EN1_1, m_1, saiCOMPARADOR_1, Resto, Quociente, outCount_1);

end bhv;