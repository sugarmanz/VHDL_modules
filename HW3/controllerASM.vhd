----------------------------------------------------------------------------------
-- Author: Jeremiah Zucker
-- Entity: controllerASM
-- Description: Models ASM from homework
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controllerASM is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           x : out  STD_LOGIC;
           y : out  STD_LOGIC;
           z : out  STD_LOGIC);
end controllerASM;

architecture df of controllerASM is
type state_type is (s0,s1,s2,s3,s4);
signal next_state, present_state : state_type := s0;
begin
--NOTE: The assignment calls for a dataflow description of
--this controller. This caused confusion because describing 
--states dependant upon a rising edge of a clock requires 
--behavioral description. Therefore, there shall be processes
--within this architecture.
states: process(rst,clk)
begin
if (rst = '1') then
	x <= '0';
	y <= '0';
	z <= '0';
	next_state <= s0;
else
	if (clk'event and clk = '1') then
		case present_state is
			when s0 =>
				if (a = '1') then
					next_state <= s1;
					x <= '0';
					y <= '0';
					z <= '0';
				else
					next_state <= s0;
					x <= '0';
					y <= '0';
					z <= '0';
				end if;
			when s1 =>
				if (a = '0') then
					x <= '1';
					y <= '1';
					z <= '1';
					next_state <= s2;
				else
					x <= '0';
					y <= '1';
					z <= '0';
					next_state <= s2;
				end if;
			when s2 =>
				if (a = '0') then
					x <= '0';
					y <= '1';
					z <= '1';
					next_state <= s4;
				else
					x <= '1';
					y <= '0';
					z <= '0';
					next_state <= s3;
				end if;
			when s3 =>
				if (b = '0') then
					x <= '0';
					y <= '1';
					z <= '1';
					next_state <= s2;
				else
					x <= '0';
					y <= '1';
					z <= '0';
					next_state <= s4;
				end if;
			when s4 =>
				if (a = '0') then
					if (b = '0') then
						x <= '1';
						y <= '0';
						z <= '0';
						next_state <= s0;
					else
						x <= '1';
						y <= '0';
						z <= '1';
						next_state <= s3;
					end if;
				else
					x <= '0';
					y <= '0';
					z <= '0';
					next_state <= s1;
				end if;
		end case;
	end if;
end if;
end process;
present_state <= next_state;
end df;