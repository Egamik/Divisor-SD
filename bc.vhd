library IEEE;
use IEEE.std_logic_1164.all;

entity bc is
port (clk, rst, init: in std_logic;
		saidacomp, contz: in std_logic;
		m: out std_logic; -- Sinais dos mux
		EN0, EN1: out std_logic; -- sinais dos registradores
		shl, shr: out std_logic; -- sinais de shifts
		pronto: out std_logic
		);
end entity;

architecture behav of bc is

type state is (s0, s1, s2, s3, s4);
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
					if contz = '1' then 
						current_state <= S0;
					elsif (saidacomp = '0' and contz = '0') then 
						current_state <= s4;
					else 
						current_state <= s3;
					end if;	
					
				when s3 =>
					current_state <= s2;
					
				when s4 =>
					current_state <= s2;
				end case;	
		end if;
	end process;
	
	process(current_state)
	begin
		case current_state is   
			when s0 =>
				pronto <= '1';
				m   <= '0';
				EN0 <= '0';
				EN1 <= '0';
				shl <= '0';
				shr <= '0';
				
			when s1 =>
				pronto <= '0';
				m   <= '0';
				EN0 <= '1';
				EN1 <= '1';
				shl <= '0';
				shr <= '0';
				
			when s2 =>
				pronto <= '0';
				m   <= '1';
				EN0 <= '0';
				EN1 <= '0';
				shl <= '0';
				shr <= '0';
				
			when s3 =>
				pronto <= '0';
				m   <= '1';
				EN0 <= '0';
				EN1 <= '1';
				shl <= '1';
				shr <= '0';
				
			when s4 =>
				pronto <= '0';
				m   <= '1';
				EN0 <= '0';
				EN1 <= '0';
				shl <= '1';
				shr <= '1';
				
			end case;
	end process;		
end behav;