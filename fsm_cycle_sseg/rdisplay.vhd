library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is

    port(
        clk, pause, cw, enable: in std_logic;
        an: out std_logic_vector(7 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );

end display;

architecture display_arch of display is

    type state is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal current_state, next_state: state;

    begin 

    -- state register ================================================//
    process(clk, enable)
    begin

        if(rising_edge(clk)) then
            if(enable='1') then
                current_state <= next_state;
            end if;    
        end if;
    end process;


    --next state logic ===============================================//
    process(current_state, pause, cw, clk)
    begin
        
        if(pause='1') then
            next_state <= current_state;
        else 

            if (cw='1') then

                case current_state is    
                    when s0 =>
                    next_state <= s1;
                    when s1 =>
                    next_state <= s2;
                    when s2 =>
                    next_state <= s3;
                    when s3 =>
                    next_state <= s4;
                    when s4 =>
                    next_state <= s5;
                    when s5 =>
                    next_state <= s6;
                    when s6 =>
                    next_state <= s7;
                    when s7 =>
                    next_state <= s0;
                end case;
            
            else
                case current_state is
                    when s0 =>
                    next_state <= s7;
                    when s1 =>
                    next_state <= s0;
                    when s2 =>
                    next_state <= s1;
                    when s3 =>
                    next_state <= s2;
                    when s4 =>
                    next_state <= s3;
                    when s5 =>
                    next_state <= s4;
                    when s6 =>
                    next_state <= s5;
                    when s7 =>
                    next_state <= s6;
                end case;
            
            end if;

        end if;
    end process;


    -- output logic ============================================//
    process(current_state)
    begin
        case current_state is
            
            when s0 =>
            an <= "11111110";
            sseg <= "10011100"; --a,b,f,g            
            
            when s1 =>
            an <= "11111110";
            sseg <= "10100011"; --c,d,e,g
            
            when s2 =>
            an <= "11111101";
            sseg <= "10100011";
           

            when s3 =>
            an <= "11111011";
            sseg <= "10100011";

            when s4 =>
            an <= "11110111";
            sseg <= "10100011";

            when s5 =>
            an <= "11110111";
            sseg <= "10011100";
         
            when s6 =>
            an <= "11111011";
            sseg <= "10011100";

            when s7 =>
            an <= "11111101";
            sseg <= "10011100";

        end case;
    end process;

end display_arch;