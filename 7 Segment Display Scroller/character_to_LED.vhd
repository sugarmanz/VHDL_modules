----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:12:22 03/24/2015 
-- Design Name: 
-- Module Name:    character_to_LED - Behavioral 
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

entity character_to_LED is
    Port ( input : in  character;
           output : out  STD_LOGIC_VECTOR(6 downto 0));
end character_to_LED;

architecture Behavioral of character_to_LED is
signal ch : character;
signal outty : STD_LOGIC_VECTOR(6 downto 0);
begin
ch <= input;
process(ch)
begin
	case ch is
		when 'a' => outty <= "0001000";
		WHEN 'A' => outty <= "0001000";
		when 'b' => outty <= "1100000";
		WHEN 'B' => outty <= "0000000";
		when 'c' => outty <= "1110010";
		WHEN 'C' => outty <= "0110001";
		when 'd' => outty <= "1000010";
		WHEN 'D' => outty <= "0000001";
		when 'e' => outty <= "0110000";
		when 'E' => outty <= "0110000";
		when 'f' => outty <= "0111000";
		when 'F' => outty <= "0111000";
		when 'g' => outty <= "0000100";
		when 'G' => outty <= "0000100";
		when 'h' => outty <= "1101000";
		when 'H' => outty <= "1001000";
		when 'i' => outty <= "1101111";
		when 'I' => outty <= "1001111";
		when 'j' => outty <= "1000111";
		when 'J' => outty <= "1000111";
		when 'k' => outty <= "1001000";
		when 'K' => outty <= "1001000";
		when 'l' => outty <= "1001111";
		when 'L' => outty <= "1110001";
		when 'm' => outty <= "1111111";
		when 'M' => outty <= "1111111";
		when 'n' => outty <= "1101010";
		when 'N' => outty <= "0001001";
		when 'o' => outty <= "1100010";
		when 'O' => outty <= "0000001";
		when 'p' => outty <= "0011000";
		when 'P' => outty <= "0011000";
		when 'q' => outty <= "0001100";
		when 'Q' => outty <= "0001100";
		when 'r' => outty <= "1111010";
		when 'R' => outty <= "0001000";
		when 's' => outty <= "0100100";
		when 'S' => outty <= "0100100";
		when 't' => outty <= "1110000";
		when 'T' => outty <= "1110000";
		when 'u' => outty <= "1100011";
		when 'U' => outty <= "1000001";
		when 'v' => outty <= "1100011";
		when 'V' => outty <= "1111111";
		when 'w' => outty <= "1111111";
		when 'W' => outty <= "1111111";
		when 'x' => outty <= "1001000";
		when 'X' => outty <= "1001000";
		when 'y' => outty <= "1000100";
		when 'Y' => outty <= "1000100";
		when 'z' => outty <= "0010010";
		when 'Z' => outty <= "0010010";
		when '?' => outty <= "0010110";
		when '.' => outty <= "1110111";
		when '-' => outty <= "1111110";
		when others => outty <= "1111111";
	end case;
end process;
output <= outty;
end Behavioral;

