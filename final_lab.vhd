--------------------------------
--University of Mississippi 
--El E 386
--Final Lab
--Engineer: Ben Mighall
--
--This program is a simple guessing game with a "random" number generator. Served as final lab project for class.
--
-- Note: This program may require you to slightly alter the constraints 
-- file to suppress warnings about clock in order to run it. 
-- Easiest way to do it: if you're using Vivado, just copy and paste the suppression code they 
-- give you into the constraints file after you do synthesis/implementation.
--------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity final_lab is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           BTN : in STD_LOGIC_VECTOR (4 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           SSEG_AN: out STD_LOGIC_VECTOR (7 downto 0);
           SSEG_CA: out STD_LOGIC_VECTOR (7 downto 0));  
end final_lab;

architecture Behavioral of final_lab is

signal random_num: STD_LOGIC_VECTOR(2 downto 0);
signal random_temp: STD_LOGIC_VECTOR(2 downto 0) := (2 => '1', others => '0');
signal temp: STD_LOGIC;

type state_type is (s0,s1);
signal current_state, next_state: state_type;

begin

P1: process(BTN(2))
begin
    if BTN(2)'event and BTN(2) = '1' then --"random" number generator; generates string of numbers 12413652537640
        temp <= (random_temp(2) XOR random_temp(1));
        random_temp(2 downto 1) <= random_temp(1 downto 0);
        random_temp(0) <= temp;
    end if;
    random_num <= random_temp;
end process;        

P2: process(current_state, next_state, BTN(1))
begin
    if(BTN(1)'event and BTN(1)='1')then
        current_state <= next_state;    
    end if;
end process;

P3: process(current_state, next_state)
begin
    case current_state is
        when s0 =>
            SSEG_AN <= "01111111";
            next_state <= s1;
            case SW(2 downto 0) is --input
               when "000" => SSEG_CA <= "11000000";--0
               when "001" => SSEG_CA <= "11111001";--1
               when "010" => SSEG_CA <= "10100100";--2        
               when "011" => SSEG_CA <= "10110000";--3
               when "100" => SSEG_CA <= "10011001";--4
               when "101" => SSEG_CA <= "10010010";--5
               when "110" => SSEG_CA <= "10000010";--6
               when "111" => SSEG_CA <= "11111000";--7
               when others => SSEG_CA <= "11111111";--
           end case; 
    
        when s1 =>
            SSEG_AN <= "10111111";
            next_state <= s0;        
            case random_num(2 downto 0) is --random number
                when "000" => SSEG_CA <= "11000000";--0
                when "001" => SSEG_CA <= "11111001";--1
                when "010" => SSEG_CA <= "10100100";--2        
                when "011" => SSEG_CA <= "10110000";--3
                when "100" => SSEG_CA <= "10011001";--4
                when "101" => SSEG_CA <= "10010010";--5
                when "110" => SSEG_CA <= "10000010";--6
                when "111" => SSEG_CA <= "11111000";--7
                when others => SSEG_CA <= "11111111";
            end case;
    end case;
end process;

end Behavioral;
