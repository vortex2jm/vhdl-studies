--Listing 3.1
library ieee;
use ieee.std_logic_1164.all;
entity cod_prio is
   port(
      r     : in  std_logic_vector(2 downto 0);
      pcode : out std_logic_vector(1 downto 0)
   );
end cod_prio;

architecture cond_arch of cod_prio is
begin
   pcode <= "11" when (r(2) = '1') else 
            "10" when (r(1) = '1') else 
            "01" when (r(0) = '1') else 
            "00";
end cond_arch;