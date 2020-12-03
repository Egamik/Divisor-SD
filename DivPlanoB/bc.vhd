library IEEE;
use IEEE.std_logic_1164.all;

entity bc is
port (clkbc, reset, inicio: in std_logic;
		Demzero , NumeradorMAIOR : in std_logic;
		m1,m2 : out std_logic;  -- Sinais mux.
		CDen,CNum,Cresto,Cdiv,ResetDiv : out std_logic; -- Sinais regs.
		pronto,Erro: out std_logic);
end entity;

architecture comportamento of bc is

type state is (s0, s1, s2, s3, s4, s5, sE);
signal current_state : state;

begin
	process(clkbc, reset) -- Condiçoes para transição de estados.
		begin
		if (reset = '1') then 
			current_state <= s0;
		elsif (clkbc'event and clkbc = '1') then
			case current_state is
				when s0 =>
					if (inicio = '1') then
						current_state <= s1;
					else
						current_state <= s0;
					end if;	
				when s1 =>
					current_state <= s2;
				when s2 =>
					if (Demzero = '1') then 
						current_state <= sE;
					else 
						current_state <= s3;
					end if;	
				when s3 =>
					if NumeradorMAIOR = '0' then -- => Numero é maior pois positivo-positivo = positivo.
						current_state <= s4;
					else
						current_state <= s5;
					end if;	
				when s4 =>
					current_state <= s3;
				when s5 =>
					current_state <= s0;
				when sE =>
					current_state <= s0;
				end case;	
		end if;
	end process;
	
	process(current_state) -- Sinais de controle gerados em cada estado:
	begin
		case current_state is
			when s0 =>
				  --m1        <= '0';
				  --m2        <= '0';
				  CDen      <= '0';
				  CNum      <= '0';
				  Cresto    <= '0';
				  Cdiv      <= '0';
				  ResetDiv  <= '0';
              pronto    <= '1'; -- Levanta flag de termino da operação.
				  Erro      <= '0';
			when s1 =>
				  m1        <= '0'; -- Libera caminho para B.
				  --m2        <= '0';
				  CDen      <= '1'; -- carrega A.
				  CNum      <= '1'; -- carrega B.
				  Cresto    <= '0';
				  Cdiv      <= '0';
				  ResetDiv  <= '1'; -- Reseta RegDiv.
              pronto    <= '0'; 
				  Erro      <= '0';				  
			when s2 =>                 -- Somente checa se Den = 0.
				  --m1        <= '0';
				  --m2        <= '0';
				  CDen      <= '0';
				  CNum      <= '0';
				  Cresto    <= '0';
				  Cdiv      <= '0';
				  ResetDiv  <= '0';
              pronto    <= '0'; 
				  Erro      <= '0';				  
			when s3 =>
				  --m1        <= '0';
				  m2        <= '1'; -- libera caminho para comparar Den e Num e CinSomador = 1.
				  CDen      <= '0';
				  CNum      <= '0';
				  Cresto    <= '0';
				  Cdiv      <= '0';
				  ResetDiv  <= '0';
              pronto    <= '0'; 
				  Erro      <= '0';				  
			when s4 =>
				  m1        <= '1'; -- Para atualizar o Num com o result da subtração.
				  m2        <= '0'; -- Para fazer Div=Div++.
				  CDen      <= '0';
				  CNum      <= '1'; -- Atualiza valor.
				  Cresto    <= '0';
				  Cdiv      <= '1'; -- Atualiza valor.
				  ResetDiv  <= '0';
              pronto    <= '0'; 
				  Erro      <= '0';
			when s5 =>
				  --m1        <= '0';
				  --m2        <= '0';
				  CDen      <= '0';
				  CNum      <= '0';
				  Cresto    <= '1'; -- Resultado do resto é carregado no regResto.
				  Cdiv      <= '0';
				  ResetDiv  <= '0';
              pronto    <= '0'; 
				  Erro      <= '0';
			when sE =>
				  m1        <= '0';
				  m2        <= '0';
				  CDen      <= '0';
				  CNum      <= '0';
				  Cresto    <= '0';
				  Cdiv      <= '0';
				  ResetDiv  <= '0';
              pronto    <= '0'; 
				  Erro      <= '1'; -- Levanta flag de erro.
			end case;
	end process;		
end comportamento;