----------------------------------------------------------------------------------
-- File: scrolling.vhd
-- Author: Jeremiah Zucker
-- Date: 3/24/15
-- Description: Created for NEXYS 3 FPGA. Takes a string and displays the string
-- 				 as scrolling text across the four seven segment displays. Uses 
--					 my LCD display driver that takes an input for the values of each 
--					 of the seven segment displays and drives them at 100 Hz. One button
--					 can control the scrolling speed, while 2 switches control whether
--					 the text stops or goes in reverse. The output LEDout, is the 
--					 seven segment display configuration wanted at the spot determined 
--					 by the output 'anos'. That output determines which of the displays 
--					 lit for that particular LEDout configuraion.
----------------------------------------------------------------------------------
--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity scrolling is
    Port ( clk : in  STD_LOGIC; --CLOCK
           stop : in  STD_LOGIC; --SWITCH
			  reverse : in STD_LOGIC; --SWITCH
			  speed : in STD_LOGIC; --BUTTON
           LEDout : out  STD_LOGIC_VECTOR(6 downto 0); --Seven Segment Display Cathodes
           anos : out  STD_LOGIC_VECTOR(3 downto 0)); --Seven Segment Display Anodes
end scrolling;

architecture Behavioral of scrolling is

--constant declaration
--'speed1' - 'speed6': how fast the the text scrolls
--counter has to count to 'speed#' before shifting
constant speed1 : std_logic_vector(31 downto 0) := "00000000011111010111100001000000"; --Fastest
constant speed2 : std_logic_vector(31 downto 0) := "00000000111110101111000010000000";
constant speed3 : std_logic_vector(31 downto 0) := "00000001111101011110000100000000";
constant speed4 : std_logic_vector(31 downto 0) := "00000011111010111100001000000000";
constant speed5 : std_logic_vector(31 downto 0) := "00000111110101111000010000000000";
constant speed6 : std_logic_vector(31 downto 0) := "00001111101011110000100000000000"; --Slowest
constant len : integer := 26; --Length of string
constant str : string (len downto 1) := "You are really cool. - JZ "; --String to print

--signal declaration
signal str_ptr1 : integer := 4; --String Pointer for 1st Display
signal str_ptr2 : integer := 3; --String Pointer for 2nd Display
signal str_ptr3 : integer := 2; --String Pointer for 3rd Display
signal str_ptr4 : integer := 1; --String Pointer for 4th Display
signal s : std_logic_vector(31 downto 0) := speed1; --Actual speed
signal count : std_logic_vector(31 downto 0) := (others => '0'); --Speed counter
signal B1c,B2c,B3c,B4c : character; --Characters to print
signal B1,B2,B3,B4 : std_logic_vector(6 downto 0); --Seven segment display configurations

--component declaration
component LCD_DRIVER is
	Port (  B1 : in  STD_LOGIC_VECTOR(6 downto 0);
           B2 : in  STD_LOGIC_VECTOR(6 downto 0);
           B3 : in  STD_LOGIC_VECTOR(6 downto 0);
           B4 : in  STD_LOGIC_VECTOR(6 downto 0);
           clk : in  STD_LOGIC;
           anos : out  STD_LOGIC_VECTOR(3 downto 0);
           output : out  STD_LOGIC_VECTOR(6 downto 0));
end component;

component character_to_LED is
	Port ( input : in  character;
           output : out  STD_LOGIC_VECTOR(6 downto 0));
end component;

component BCD_to_7_mod is
	Port (input : in integer;
			output : out STD_LOGIC_VECTOR(6 downto 0));
end component;

begin
--main process
mult: process(clk,stop,speed)
begin
--Change speeds
if speed'event and speed = '1' then
	case s is
		when speed1 => s <= speed2;
		when speed2 => s <= speed3;
		when speed3 => s <= speed4;
		when speed4 => s <= speed5;
		when speed5 => s <= speed6;
		when others => s <= speed1;
	end case;
end if;
--Increment count
count <= count + 1;
--Shift
if (clk'event and clk = '1' and stop = '0') then
	if count >= s then
		count <= (others => '0'); --Reset count
		--Reverse
		if reverse = '1' then 
			str_ptr1 <= str_ptr1 + 1;
			str_ptr2 <= str_ptr2 + 1;
			str_ptr3 <= str_ptr3 + 1;
			str_ptr4 <= str_ptr4 + 1;
			--Check boundries
			if (str_ptr4 = len) then
				str_ptr4 <= 1;
			end if;
			if (str_ptr3 = len) then
				str_ptr3 <= 1;
			end if;
			if (str_ptr2 = len) then
				str_ptr2 <= 1;
			end if;
			if (str_ptr1 = len) then
				str_ptr1 <= 1;
			end if;
		else --Regular
			str_ptr1 <= str_ptr1 - 1;
			str_ptr2 <= str_ptr2 - 1;
			str_ptr3 <= str_ptr3 - 1;
			str_ptr4 <= str_ptr4 - 1;
			--Check boundries
			if (str_ptr4 = 1) then
				str_ptr4 <= len;
			end if;
			if (str_ptr3 = 1) then
				str_ptr3 <= len;
			end if;
			if (str_ptr2 = 1) then
				str_ptr2 <= len;
			end if;
			if (str_ptr1 = 1) then
				str_ptr1 <= len;
			end if;
		end if;
		--Check for accuracy
		if (str_ptr1 >= 4) and ((str_ptr2 /= str_ptr1 - 1) or (str_ptr3 /= str_ptr1 - 2) or (str_ptr4 /= str_ptr1 - 3)) then
			str_ptr1 <= str_ptr1;
			str_ptr2 <= str_ptr1 - 1;
			str_ptr3 <= str_ptr1 - 2;
			str_ptr4 <= str_ptr1 - 3;
		end if;
	end if;
end if;
end process;

--Assign characters by pointers
B1c <= str(str_ptr1);
B2c <= str(str_ptr2);
B3c <= str(str_ptr3);
B4c <= str(str_ptr4);
--Convert from character to display configuration
c2l1 : character_to_LED port map(input => B1c, output => B1);
c2l2 : character_to_LED port map(input => B2c, output => B2);
c2l3 : character_to_LED port map(input => B3c, output => B3);
c2l4 : character_to_LED port map(input => B4c, output => B4);
--TEST INDEX ROTATION
--BC1 : BCD_to_7_mod port map (input => str_ptr1 ,output =>B1);
--BC2 : BCD_to_7_mod port map (input => str_ptr2 ,output =>B2);
--BC3 : BCD_to_7_mod port map (input => str_ptr3 ,output =>B3);
--BC4 : BCD_to_7_mod port map (input => str_ptr4 ,output =>B4);
--Display values
LCD : LCD_DRIVER port map (B1 => B1,B2 => B2,B3 => B3,B4 => B4,clk => clk, anos => anos, output => LEDout);
end Behavioral;