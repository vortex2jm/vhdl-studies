library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is

    port(
        clk, reset, pause, cw, enable: in std_logic;
        an: out std_logic_vector(7 downto 0);
        sseg: out std_logic_vector(7 downto 0)
    );

end display;

architecture display_arch of display is

    type state is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal current_state, next_state: state;

    begin 

    -- state register
    process(clk, reset)
    begin
        if(reset = '1') then
            next_state <= s0;
        elsif(clk'event and clk='1') then
            if(enable='1') then
                current_state <= next_state;
            end if;    
        end if;
    end process;

    -- next/previous state & output logic
    process(current_state, pause, cw)
    begin
        --next_state <= current_state;
        case current_state is
            
            when s0 =>
            an <= "11111110";
            sseg <= "10011100"; --a,b,f,g            
            if(pause='1') then
                next_state <= s0;
            else
                if(cw='1') then
                    next_state <= s7;
                else 
                    next_state <= s1;   
                end if;
            end if;
            
    
            when s1 =>
            an <= "11111110";
            sseg <= "10100011"; --c,d,e,g
            if(pause='1') then
                next_state <= s1;
            else
                if(cw='1') then
                    next_state <= s0;
                else
                    next_state <= s2;
                end if;
            end if;
            

            when s2 =>
            an <= "11111101";
            sseg <= "10100011";
            if(pause='1') then
                next_state <= s2;
            else
                if(cw='1') then
                    next_state <= s1;
                else
                    next_state <= s3;
                end if;
            end if;
           

            when s3 =>
            an <= "11111011";
            sseg <= "10100011";
            if(pause='1') then
                next_state <= s3;
            else
                if(cw='1') then
                    next_state <= s2;
                else
                    next_state <= s4;
                end if;
            end if;
          

            when s4 =>
            an <= "11110111";
            sseg <= "10100011";
            if(pause='1') then
                next_state <= s4;
            else                
                if(cw='1') then
                    next_state <= s3;
                else
                    next_state <= s5;                
                end if;
            end if;
           

            when s5 =>
            an <= "11110111";
            sseg <= "10011100";
            if(pause='1') then
                next_state <= s5;
            else                
                if(cw='1') then
                    next_state <= s4;
                else
                    next_state <= s6;                
                end if;
            end if;
         

            when s6 =>
            an <= "11111011";
            sseg <= "10011100";
            if(pause='1') then
                next_state <= s6;
            else                
                if(cw='1') then
                    next_state <= s5;
                else
                    next_state <= s7;                
                end if;
            end if;
            

            when s7 =>
            an <= "11111101";
            sseg <= "10011100";
            if(pause='1') then
                next_state <= s7;
            else                
                if(cw='1') then
                    next_state <= s6;
                else
                    next_state <= s0;                
                end if;
            end if;

        end case;
    end process;

end display_arch;