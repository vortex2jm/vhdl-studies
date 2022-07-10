library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity
entity display is
  port(
    clk, reset, enable: in std_logic;
    an, sseg: out std_logic_vector(7 downto 0)
  );
end display;

-- Architecture
architecture display_arch of display is 

  type state is (s0, s1, s2, s3, s4, s5, s6 ,s7);
  signal current_state, next_state: state;

  begin

  -- State register
  process(clk, reset)
  begin
    if (reset='1') then 
      next_state <= s0;
    elsif(rising_edge(clk)) then
      if(enable = '1') then 
        current_state <= next_state;
      end if;
    end if ;
  end process;
    

  -- next state/output logic
  process(current_state)
  begin
  next_state <= current_state;
    case current_state is 
      when s0 => 
        an <= "11111110";
        sseg <= "11000000";
        next_state <= s1;
      when s1 => 
        an <= "11111101";
        sseg <= "11111001";
        next_state <= s2;
      when s2 => 
        an <= "11111011";
        sseg <= "10100100";
        next_state <= s3;
      when s3 => 
        an <= "11110111";
        sseg <= "10110000";
        next_state <= s4;
      when s4 => 
        an <= "11101111";
        sseg <= "10011001";
        next_state <= s5;
      when s5 => 
        an <= "11011111";
        sseg <= "10010010";
        next_state <= s6;
      when s6 => 
        an <= "10111111";
        sseg <= "10000010";
        next_state <= s7;
      when s7 => 
        an <= "01111111";
        sseg <= "11111000";
        next_state <= s0;
    end case;
  end process;

end display_arch;