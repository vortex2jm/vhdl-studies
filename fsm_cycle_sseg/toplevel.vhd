library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_display is

    port(
        clk: in std_logic;
        sw: in std_logic_vector(1 downto 0);
        an: out std_logic_vector(7 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );

end top_display;

architecture top_display_arch of top_display is

    constant N : integer := 99999999;
    signal divide_clk : integer range 0 to N;
    signal enable: std_logic;

    begin

    display_unity: entity work.display
    port map(
        clk => clk,
        an => an,
        sseg => sseg,
        enable => enable,
        pause => sw(0),
        cw => sw(1),
        reset => '0'
    );

    process(clk)
    begin
        if(clk'event and clk='1') then
            divide_clk <= divide_clk + 1;
            if(divide_clk = N) then
                divide_clk <= 0;
            end if;
        end if;    
    end process;
            
    enable <= '1' when divide_clk = N else '0';

end top_display_arch;