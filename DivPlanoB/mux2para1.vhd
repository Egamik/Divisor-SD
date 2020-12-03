library ieee;
use ieee.std_logic_1164.all;

entity mux2para1 is
generic(N: natural := 8);
  port ( a, b : in std_logic_vector(N-1 downto 0);
         sel: in std_logic;
         y : out std_logic_vector(N-1 downto 0));
  end mux2para1;

architecture comportamento of mux2para1 is
begin
     with sel select
         y <= a when '0',
              b when others;
end comportamento;