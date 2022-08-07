library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_park is

    port(
        clk: in std_logic;
        sw: in std_logic_vector(1 downto 0);
        led: out std_logic_vector(1 downto 0)
    );

end top_park;

architecture top_park_arch of top_park is

    constant N : integer := 99999999;
    signal divide_clk : integer range 0 to N;
    signal enable: std_logic;
    
    begin
    --divisor de clock
    process(clk, divide_clk)
    begin
        if(rising_edge(clk)) then
            divide_clk <= divide_clk + 1;
            if(divide_clk = N) then
                divide_clk <= 0;
            end if;
        end if;
     end process;

    enable <= '1' when divide_clk = N else '0';
    
    --
    park_unity: entity work.park_counter
    port map(
        clk => clk,
        enable => enable,
        ab => sw,
        car_enter => led(0),
        car_exit => led(1)        
    );

end top_park_arch;