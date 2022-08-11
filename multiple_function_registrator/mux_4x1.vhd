
library ieee;
use ieee.std_logic_1164.all;
entity mux_4x1 is
   port(
      i: in std_logic_vector(3 downto 0);
      c: in std_logic_vector(1 downto 0);
      s: out std_logic
   );
end mux_4x1;

architecture cond_arch of mux_4x1 is
begin
   s <= i(3) when (c="11") else
        i(2) when (c="10") else
        i(1) when (c="01") else
        i(0) ;
        
end cond_arch;
