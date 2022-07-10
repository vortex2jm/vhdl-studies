library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity top_display is 

    port(
        
        clk: in std_logic;
        an: out std_logic_vector(7 downto 0); --display
        sseg: out std_logic_vector(7 downto 0)  --seven segments
    );
end top_display;

-- Architecture
architecture top_display_arch of top_display is

constant N : integer := 99999; --1000Hz
signal enable : std_logic; --enable to clock counter
signal divide_clk : integer range 0 to N;   -- 0 to 99999

begin

    display_unit: entity work.display
        port map(
            clk => clk,
            reset => '0',
            enable => enable,
            an => an,
            sseg => sseg
        );

    process(clk)
    begin
        if(rising_edge(clk))then
            divide_clk <= divide_clk + 1;
            if divide_clk = N then
                divide_clk <= 0;
            end if;
        end if;
    end process;    

    enable <= '1' when divide_clk = N else '0';

end top_display_arch;