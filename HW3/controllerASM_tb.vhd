--------------------------------------------------------------------------------
-- Author: Jeremiah Zucker
-- Entity: controllerASM_tb
-- Description: Simple test bench modeling the
-- waveforms given in the homework. Upon comparision to
-- the answer for problem one, this waveform is correct.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controllerASM_tb IS
END controllerASM_tb;
 
ARCHITECTURE behavior OF controllerASM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT controllerASM
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         a : IN  std_logic;
         b : IN  std_logic;
         x : OUT  std_logic;
         y : OUT  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;

   --Inputs
   signal rst : std_logic := '1';
   signal clk : std_logic := '1';
   signal a : std_logic := '1';
   signal b : std_logic := '1';

 	--Outputs
   signal x : std_logic;
   signal y : std_logic;
   signal z : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controllerASM PORT MAP (
          rst => rst,
          clk => clk,
          a => a,
          b => b,
          x => x,
          y => y,
          z => z
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 
	a_process: process
	begin
		wait for clk_period/4;
		a <= '0';
		wait for clk_period/2;
		a <= '1';
		wait for (3*clk_period)/4;
	end process;
	
	b_process: process
	begin
		wait for 50 ns;
		b <= '0';
		wait for 100 ns;
		b <= '1';
		wait for 75 ns;
		b <= '0';
		wait for 50 ns;
		b <= '1';
		wait for 75 ns;
		b <= '0';
		wait for 100 ns;
		b <= '1';
		wait for 65 ns;
		b <= '0';
		wait for 85 ns;
	end process;
	
	rst_process: process
	begin
		wait for 50 ns;
		rst <= '0';
		wait for 550 ns;
		rst <= '1';
	end process;

END;