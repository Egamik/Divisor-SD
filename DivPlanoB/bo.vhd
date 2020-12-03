LIBRARY ieee;
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bo is
generic(N: natural := 8);
port (
SaidasomadorDEBUG : out std_logic_vector(N downto 0); -- DEBUG.
clkbo : in std_logic; -- Clock.
      Denominador, Numerador : in std_logic_vector(N-1 downto 0); -- Operandos.
		m1,m2 : in std_logic; -- Sinais de controle dos muxs e Cin.
		CDen,CNum,Cresto,Cdiv,ResetDiv : in std_logic; -- Sinais de carga dos registradores e reset.
		Demzero , NumeradorMAIOR : out std_logic;
      Sdivisao, Sresto : out std_logic_vector(N-1 downto 0)); -- Saida.
end bo;

architecture comportamento of bo is

component somadorComCin is -- Somador.
generic (N: natural := 8);
 port ( A,B : in std_logic_vector(N-1 downto 0);
			CIN : in std_logic;
			S : out std_logic_vector(N-1 downto 0);
			Cout : out std_logic);
end component;

component registrador is -- Reg sem reset.
generic(N: natural := 8);
port (clk, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end component;

component registrador_r is -- Reg com reset.
generic(N: natural := 8);
port (clk, reset, carga : in std_logic;
	  d : in std_logic_vector(N-1 downto 0);
	  q : out std_logic_vector(N-1 downto 0));
end component;

component mux2para1 is -- mux.
generic(N: natural := 8);
  port ( a, b : in std_logic_vector(N-1 downto 0);
         sel: in std_logic;
         y : out std_logic_vector(N-1 downto 0));
end component;

component igualazero is -- igualazero 8 bits.
generic(N: natural:= 8);
port (entrada : in std_logic_vector(N-1 downto 0);
saida : out std_logic);
end component;

signal saidaMuxNum , SaidaSubtrator : std_logic_vector(N-1 downto 0); -- Saidas N-1 Bits.
signal saidaMuxSomaDireita , saidaMuxSomaEsquerda , SaidaSomador : std_logic_vector(N downto 0); -- Saidas N bits.
signal SaidaRegNum , SaidaRegDen , SaidaRegDiv: std_logic_vector(N-1 downto 0); 
signal sinalCout : std_logic;
constant Zeros : std_logic_vector(Denominador'range) := (others => '0'); 
--signal MenosUm : std_logic_vector(Denominador'range) := (others => '1');

begin


Subtrator : somadorComCin generic map (N) port map (A => SaidaRegNum, B => not(SaidaRegDen), Cin => '1', S => SaidaSubtrator, Cout => sinalCout);
SomadorSubtrator : somadorComCin generic map (N+1) port map (A => SaidaMuxSomaDireita, B => SaidaMuxSomaEsquerda, Cin => m2, S => SaidaSomador, Cout => sinalCout);
RegNum : registrador generic map (N) port map (clk => clkbo, carga => CNum, d => SaidaMuxNum ,q => SaidaRegNum);
RegDen : registrador generic map (N) port map (clk => clkbo, carga => CDen, d => Denominador ,q => SaidaRegDen);
RegResto : registrador generic map (N) port map (clk => clkbo, carga => CResto, d => SaidaRegNum ,q => SResto);
RegDiv : registrador_r generic map (N) port map (clk => clkbo,reset => resetDiv , carga => Cdiv, d => SaidaSomador(N-1 downto 0) ,q => SaidaRegDiv);
MuxNum : mux2para1 generic map (N) port map (a => numerador , b => SaidaSubtrator , sel => m1 , y => SaidaMuxNum);

MuxSomaDireita : mux2para1 generic map (N+1) port map (a => '0' & SaidaRegDiv  , b => '0' & SaidaRegNum, sel => m2 , y => SaidaMuxSomaDireita);
MuxSomaEsquerda : mux2para1 generic map (N+1) port map (a => zeros & '1' , b => not('0' & SaidaRegDen), sel => m2 , y => SaidaMuxSomaEsquerda);
DenIgualazero : igualazero generic map (N) port map (entrada => SaidaRegDen , saida => Demzero);

NumeradorMAIOR <= SaidaSomador(N);
SaidasomadorDEBUG <= SaidaSomador;
Sdivisao <= SaidaRegDiv; 
end comportamento;