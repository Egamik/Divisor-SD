library IEEE;
use IEEE.std_logic_1164.all;

entity bc is
port (clk, rst, init: in std_logic;
		Az, Bz, contz, Azero: in std_logic;
		mPH, mcont, mFF : out std_logic; -- Sinais dos mux
		cA, cB, ccont, cmult: out std_logic; -- sinais dos registradores
		srAA, srPH, cPH, srPL, cPL: out std_logic;
		pronto: out std_logic
		);
end entity;

architecture behav of bc is

type state is (s0, s1, s2, s3, s4, s5, s6);
signal current_state : state;

begin
	process(clk, rst)
		begin
		if (rst = '1') then 
			current_state <= s0;
		elsif (clk'event and clk = '1') then
			case current_state is
				when s0 =>
					if (init = '1') then
						current_state <= s1;
					else
						current_state <= s0;
					end if;	
				when s1 =>
					current_state <= s2;
				when s2 =>
					if (Az = '1' or Bz = '1') then 
						current_state <= s6;
					else 
						current_state <= s3;
					end if;	
				when s3 =>
					if contz = '1' then
						current_state <= s6;
					elsif (contz = '0' and azero = '1') then
						current_state <= s4;
					else
						current_state <= s5;
					end if;	
				when s4 =>
					current_state <= s5;
				when s5 =>
					current_state <= s3;
				when s6 =>
					current_state <= s0;
				end case;	
		end if;
	end process;
	
	process(current_state)
	begin
		case current_state is   
			when s0 =>
				pronto <= '1';
				mPH <= '0';
				mcont <= '0';
				mFF <= '0';
				cA <= '0';
				cB <= '0';
				ccont <= '0';
				cmult <= '0';
				srAA <= '0';
				srPH <= '0';
				cPH <= '0';
				srPL <= '0';
				cPL <= '0';
				
			when s1 =>
				pronto <= '0';
				mPH <= '1'; -- faz o mux ter 000..
				mcont <= '1'; --  faz mus ter 100
				mFF <= '0';
				cA <= '1'; -- entA
				cB <= '1'; -- entB
				ccont <= '1'; -- cont
				cmult <= '0';
				srAA <= '0';
				srPH <= '0';
				cPH <= '1'; -- PH
				srPL <= '0';
				cPL <= '1'; -- Ph
				
			when s2 =>
				pronto <= '0';
				mPH <= '0';
				mcont <= '0';
				mFF <= '0';
				cA <= '0';
				cB <= '0';
				ccont <= '0';
				cmult <= '0';
				srAA <= '0';
				srPH <= '0';
				cPH <= '0';
				srPL <= '0';
				cPL <= '0';
				
			when s3 =>
				pronto <= '0';
				mPH <= '0';
				mcont <= '0';
				mFF <= '0';
				cA <= '0';
				cB <= '0';
				ccont <= '0';
				cmult <= '0';
				srAA <= '0';
				srPH <= '0';
				cPH <= '0';
				srPL <= '0';
				cPL <= '0';
				
			when s4 =>
				pronto <= '0';
				mPH <= '0';
				mcont <= '0';
				mFF <= '0';
				cA <= '0';
				cB <= '0';
				ccont <= '0';
				cmult <= '0';
				srAA <= '0';
				srPH <= '0';
				cPH <= '1';
				srPL <= '0';
				cPL <= '0';
				
			when s5 =>
				pronto <= '0';
				mPH <= '0';
				mcont <= '1';
				mFF <= '1';
				cA <= '0';
				cB <= '0';
				ccont <= '1';
				cmult <= '0';
				srAA <= '1';
				srPH <= '1';
				cPH <= '0';
				srPL <= '1';
				cPL <= '0';
				
			when s6 =>
				pronto <= '0';
				mPH <= '0';
				mcont <= '0';
				mFF <= '0';
				cA <= '0';
				cB <= '0';
				ccont <= '0';
				cmult <= '1';
				srAA <= '0';
				srPH <= '0';
				cPH <= '0';
				srPL <= '0';
				cPL <= '0';
				
			end case;
	end process;		
end behav;