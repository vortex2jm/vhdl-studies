library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity park_counter is

    port(
        enable, clk: in std_logic;
        ab: in std_logic_vector;
        car_enter, car_exit: out std_logic
    );

end park_counter;

architecture park_counter_arch of park_counter is

    type state is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
    signal current_state, next_state: state;

    begin
        --state register
        process(clk)
        begin
            if(rising_edge(clk)) then
                if(enable = '1') then
                    current_state <= next_state;
                end if;
            end if;
        end process;
        
        --next state logic
        process(current_state, ab)
        begin
            case current_state is
                --
                when s0 =>
                if(ab="00" or ab="11") then
                    next_state <= current_state;
                elsif(ab="01") then
                    next_state <= s2;
                elsif(ab="10") then
                    next_state <= s1;
                end if;
                --
                when s1 =>
                if(ab="10" or ab="01") then
                    next_state <= current_state;
                elsif (ab="00") then
                    next_state <= s0;
                elsif (ab="11") then
                    next_state <= s3;
                end if;
                --
                when s2 =>
                if(ab="10" or ab="01") then
                    next_state <= current_state;
                elsif (ab="00") then
                    next_state <= s0;
                elsif (ab="11") then
                    next_state <= s4;
                end if;
                --
                when s3 =>
                if(ab="11" or ab="00") then
                    next_state <= current_state;
                elsif (ab="10") then
                    next_state <= s1;
                elsif (ab="01") then
                    next_state <= s5;
                end if;
                    
                --
                when s4 =>
                if(ab="11" or ab="00") then
                    next_state <= current_state;
                elsif (ab="10") then
                    next_state <= s6;
                elsif (ab="01") then
                    next_state <= s2;
                end if;

                when s5 =>
                if(ab="10" or ab="01") then
                    next_state <= current_state;
                elsif (ab="00") then
                    next_state <= s7;
                elsif (ab="11") then
                    next_state <= s3;
                end if;

                when s6 =>
                if(ab="10" or ab="01") then
                    next_state <= current_state;
                elsif (ab="00") then
                    next_state <= s8;
                elsif (ab="11") then
                    next_state <= s4;
                end if;

                when s7 =>
                next_state <= s0;

                when s8 =>
                next_state <= s0;
                    
            end case;
        end process;
        
        -- output logic
        
        process(current_state)
        begin
            case current_state is

                when s0 =>
                car_enter <= '0';
                car_exit <= '0';

                when s1 =>
                car_enter <= '0';
                car_exit <= '0';

                when s2 =>
                car_enter <= '0';
                car_exit <= '0';

                when s3 =>
                car_enter <= '0';
                car_exit <= '0';

                when s4 =>
                car_enter <= '0';
                car_exit <= '0';

                when s5 =>
                car_enter <= '0';
                car_exit <= '0';

                when s6 =>
                car_enter <= '0';
                car_exit <= '0';

                when s7 =>
                car_enter <= '1';
                car_exit <= '0';

                when s8 =>
                car_enter <= '0';
                car_exit <= '1';
                    
            end case;
        end process;

end park_counter_arch;