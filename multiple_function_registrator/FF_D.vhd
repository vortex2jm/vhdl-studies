----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/10/2022 01:53:24 PM
-- Design Name: 
-- Module Name: FF_D - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FF_D is
    Port ( D : in STD_LOGIC;
           e : in STD_LOGIC;
           Q : out STD_LOGIC;
           clk : in STD_LOGIC);
end FF_D;

architecture Behavioral of FF_D is

begin
process(clk,e)
begin
   if (clk'event and clk='1') then
      if (e='1') then
         Q <= D;
      end if;
   end if;
end process;

end Behavioral;
