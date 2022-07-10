library ieee;
use ieee.std_logic_1164.all;  -- importando bibliotecas

entity mux_2x1 is -- criando uma entidade para o mux
    port(

        x0: in std_logic_vector(3 downto 0);  -- Entrada e saída com 4 bits
        s: out std_logic_vector(3 downto 0);  -- pois somaremos 4 bits e um dos numeros
        sub: in std_logic                     -- que entrarão no somador, será a saída do mux
    );
end mux_2x1;

architecture chave_seletora of mux_2x1 is
begin
        
    s <= x0 when (sub = '0') else   -- arquitetura básica de um mux 2x1
        not x0;

end chave_seletora; 
