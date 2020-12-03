library ieee;
use ieee.std_logic_1164.all;

-- A+B;

entity somador1bit is 
 port ( a,b,cin : in std_logic; 
			s , cout : out std_logic);
end somador1bit;

architecture comportamento of somador1bit is

signal Sinal : std_logic_vector(1 downto 0);

begin

s <= (a xor b) xor cin;  -- (a xor b) xor cin != a xor b xor cin.
cout <= (a and b) or (b and cin) or (a and cin);

end comportamento;