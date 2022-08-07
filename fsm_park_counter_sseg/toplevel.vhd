library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_park is

    port(
        clk: in std_logic;
        an: out std_logic_vector(3 downto 0);
        sseg: out std_logic_vector(7 downto 0);
        btn: in std_logic_vector(1 downto 0);
        led: out std_logic_vector(3 downto 0)
    );

end top_park;

architecture top_park_arch of top_park is

    constant N : integer := 99999999;
    signal divide_clk : integer range 0 to N;
    signal enable: std_logic;
    signal db_out: std_logic_vector(1 downto 0);
    signal increment, decrement: std_logic;
    signal counter_out: std_logic_vector(3 downto 0);
    
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
        ab => db_out,
        car_enter => increment,
        car_exit => decrement        
    );

    db0_unity: entity work.db_fsm
    port map(
        clk => clk,
        reset => '0',
        sw => btn(0),
        db => db_out(0)
    );
    
    db1_unity: entity work.db_fsm
    port map(
        clk => clk,
        reset => '0',
        sw => btn(1),
        db => db_out(1)
    );

    counter_unity: entity work.free_run_bin_counter
    port map(
        clk => clk,
        reset => '0',
        inc => increment,
        dec => decrement,
        q => counter_out
    );

    -- led <= counter_out;

    display_unity: entity work.disp_hex_mux
    port map(
        clk => clk,
        reset => '0',
        hex3 => "0000",
        hex2 => "0000",
        hex1 => "0000",
        hex0 => counter_out,
        dp_in => "1111",
        an => an,
        sseg => sseg
    );

end top_park_arch;