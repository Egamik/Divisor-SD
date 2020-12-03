library ieee;
use ieee.std_logic_1164.all;

entity somadorComCin is 
generic (N: natural := 8);
 port ( A,B : in std_logic_vector(N-1 downto 0);
			CIN : in std_logic;
			S : out std_logic_vector(N-1 downto 0);
			Cout : out std_logic);
end somadorComCin;

architecture comportamento of somadorComCin is

-- A+B+Cin;

component somador1bit is
port (a,b,cin : in std_logic;
			s , cout : out std_logic);
end component;

signal Sinal : std_logic_vector(N-1 downto 0);

begin
somador0 : somador1bit port map (A(0) , B(0) , CIN , S(0) , Sinal(0) ); -- SINAL Cout(0).

 GEN : for i in 1 to N-1 generate
  somadori : somador1bit port map (A(i) , B(i) , Sinal(i-1) , S(i) , Sinal(i));
  end generate GEN;
  
  Cout <= Sinal(N-1);
end comportamento; 
