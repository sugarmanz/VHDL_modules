----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:35:34 03/24/2015 
-- Design Name: 
-- Module Name:    scrolling - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity scrolling is
    Port ( clk : in  STD_LOGIC;
           stop : in  STD_LOGIC;
			  reverse : in STD_LOGIC;
           LEDout : out  STD_LOGIC_VECTOR(6 downto 0);
           anos : out  STD_LOGIC_VECTOR(3 downto 0));
end scrolling;

architecture Behavioral of scrolling is

--signal declaration
signal str : string (22 downto 1);
signal str_ptr1 : integer := 4;
signal str_ptr2 : integer := 3;
signal str_ptr3 : integer := 2;
signal str_ptr4 : integer := 1;
signal len : integer;
signal count : std_logic_vector(31 downto 0) := (others => '0');
signal prescale : std_logic_vector(15 downto 0) := (others => '1');
signal B1,B2,B3,B4 : std_logic_vector(6 downto 0);
signal B1c,B2c,B3c,B4c : character;

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
--signal initialization
str <= "I love you babe. - JZ ";
len <= 22;

mult: process(clk,stop)
begin
count <= count + 1;
if (clk'event and clk = '1' and stop = '0') then
	if count = "00000001111101011110000100000000" then
		count <= "00000000000000000000000000000000";
		if str_ptr1 = str_ptr2 or str_ptr1 = str_ptr3 or str_ptr1 = str_ptr4 or str_ptr2 = str_ptr3 or str_ptr2 = str_ptr4 or str_ptr3 = str_ptr4 then
			str_ptr1 <= 1;
			str_ptr2 <= 2;
			str_ptr3 <= 3;
			str_ptr4 <= 4;
		end if;
		if reverse = '1' then 
			str_ptr1 <= str_ptr1 + 1;
			str_ptr2 <= str_ptr2 + 1;
			str_ptr3 <= str_ptr3 + 1;
			str_ptr4 <= str_ptr4 + 1;
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
		else
			str_ptr1 <= str_ptr1 - 1;
			str_ptr2 <= str_ptr2 - 1;
			str_ptr3 <= str_ptr3 - 1;
			str_ptr4 <= str_ptr4 - 1;
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
	end if;
end if;
end process;

B1c <= str(str_ptr1);
B2c <= str(str_ptr2);
B3c <= str(str_ptr3);
B4c <= str(str_ptr4);
c2l1 : character_to_LED port map(input => B1c, output => B1);
c2l2 : character_to_LED port map(input => B2c, output => B2);
c2l3 : character_to_LED port map(input => B3c, output => B3);
c2l4 : character_to_LED port map(input => B4c, output => B4);
--BC1 : BCD_to_7_mod port map (input => str_ptr1 ,output =>B1);
--BC2 : BCD_to_7_mod port map (input => str_ptr2 ,output =>B2);
--BC3 : BCD_to_7_mod port map (input => str_ptr3 ,output =>B3);
--BC4 : BCD_to_7_mod port map (input => str_ptr4 ,output =>B4);
LCD : LCD_DRIVER port map (B1 => B1,B2 => B2,B3 => B3,B4 => B4,clk => clk, anos => anos, output => LEDout);

end Behavioral;
