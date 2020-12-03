library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Divisor01 is
generic(N: natural := 8);
port (NumeradorTop,DenominadorTop : in std_logic_vector(N-1 downto 0);
		Div , Resto : out std_logic_vector(N-1 downto 0);
		clkTop , InicioTop , ResetTop : in std_logic;
		ErroTop , prontoTop: out std_logic;
		SaidasomadorTop : out std_logic_vector(N downto 0) -- DEBUG.
		);
end entity;

architecture comportamento of Divisor01 is

component bo is
generic(N: natural := 8);
port (
SaidasomadorDEBUG : out std_logic_vector(N downto 0); -- DEBUG.
clkbo : in std_logic; -- Clock.
      Denominador, Numerador : in std_logic_vector(N-1 downto 0); -- Operandos.
		m1,m2 : in std_logic; -- Sinais de controle dos muxs e Cin.
		CDen,CNum,Cresto,Cdiv,ResetDiv : in std_logic; -- Sinais de carga dos registradores e reset.
		Demzero , NumeradorMAIOR : out std_logic;
      Sdivisao, Sresto : out std_logic_vector(N-1 downto 0)); -- Saida.
end component;

component bc is
port (clkbc, reset, inicio: in std_logic;
		Demzero , NumeradorMAIOR : in std_logic;
		m1,m2 : out std_logic;  -- Sinais mux.
		CDen,CNum,Cresto,Cdiv,ResetDiv : out std_logic; -- Sinais regs.
		pronto,Erro: out std_logic);
end component;

signal sinalm1, sinalm2 : std_logic;
signal sinalCDen,sinalCNum,sinalCresto,sinalCdiv,sinalResetDiv : std_logic;
signal sinalDemzero , sinalNumeradorMAIOR : std_logic;

begin

Bo1 : bo generic map (N) port map (SaidasomadorDEBUG => SaidasomadorTop,clkbo => clkTop, Denominador => DenominadorTop , Numerador => NumeradorTop , m1 => sinalm1 , m2 => sinalm2 , CDen => sinalCDen,CNum => sinalCNum ,Cresto => sinalCresto, Cdiv => sinalCdiv, ResetDiv => sinalResetDiv ,Demzero => sinalDemzero , NumeradorMAIOR => sinalNumeradorMAIOR, Sdivisao => Div, Sresto => Resto);
Bc1 : bc port map (clkbc => clkTop, reset => ResetTop, inicio => InicioTop, Demzero => sinalDemzero , NumeradorMAIOR => sinalNumeradorMAIOR, m1 => sinalm1 , m2 => sinalm2, CDen => sinalCDen, CNum => sinalCNum ,Cresto => sinalCresto, Cdiv => sinalCdiv, ResetDiv => sinalResetDiv , pronto => ProntoTop, Erro => ErroTop);

end comportamento;