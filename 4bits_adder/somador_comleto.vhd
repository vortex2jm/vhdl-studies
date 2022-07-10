library ieee;
use ieee.std_logic_1164.all;  -- importando bibliotecas

entity somador_completo is  -- criando entidade para o somador completo
    port(

        a, b, ci: in std_logic;
        co, s: out std_logic        
    );
end somador_completo;

architecture soma of somador_completo is
    
begin 

    co <= ((b and ci) or (a and ci) or (a and b));  -- definindo entradas e saída do somador
    s <= a xor b xor ci;                            -- através de equações lógicas

end soma;