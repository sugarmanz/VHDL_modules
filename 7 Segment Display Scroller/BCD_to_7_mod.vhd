----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:45:45 03/24/2015 
-- Design Name: 
-- Module Name:    BCD_to_7_mod - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_to_7_mod is
    Port ( input : in  integer;
           output : out  STD_LOGIC_VECTOR(6 downto 0));
end BCD_to_7_mod;

architecture Behavioral of BCD_to_7_mod is

begin

process (input)
begin
case input is
	when 0 => output <= not "1111110";
	when 1 => output <= not "0110000";
	when 2 => output <= not "1101101";
	when 3 => output <= not "1111001";
	when 4 => output <= not "0110011";
	when 5 => output <= not "1011011";
	when 6 => output <= not "1011111";
	when 7 => output <= not "1110000";
	when 8 => output <= not "1111111";
	when 9 => output <= not "1111011";
	when 10 => output <= "0001000";
	when 11 => output <= "0000000";
	when 12 => output <= "0110001";
	when 13 => output <= "0000001";
	when 14 => output <= "0110000";
	when 15 => output <= "0111000";
	when others => output <= not "0000000";
end case;
end process;
end Behavioral;

