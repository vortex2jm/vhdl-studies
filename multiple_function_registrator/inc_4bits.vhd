----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/10/2022 01:59:45 PM
-- Design Name: 
-- Module Name: inc_4bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inc_4bits is
    Port ( inc_in : in STD_LOGIC_VECTOR (3 downto 0);
           inc_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
end inc_4bits;

architecture Behavioral of inc_4bits is
begin
    inc_out  <= std_logic_vector(unsigned(inc_in)+1);
end Behavioral;
