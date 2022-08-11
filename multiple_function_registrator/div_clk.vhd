----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/10/2022 01:57:08 PM
-- Design Name: 
-- Module Name: div_clk - Behavioral
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

entity div_clk is
    Port ( clk : in STD_LOGIC;
           en : out STD_LOGIC);
end div_clk;

architecture Behavioral of div_clk is
constant N : integer := 49999999; 
signal divide_clk : integer range 0 to N;
begin

 PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            divide_clk <= divide_clk+1;
            IF divide_clk = N THEN
                divide_clk <= 0;
            END IF;
        END IF;
 END PROCESS;
 
 en <= '1' when divide_clk = N else '0';

end Behavioral;
