--Mux 4 x 1
library ieee;
use ieee.std_logic_1164.all;  --importando bibliotecas

entity mux4x1 is    --criando uma entidade para o mux
    port(

        x0, x1, x2, x3: in std_logic;           --entradas do mux (4)

        c1c0: in std_logic_vector(1 downto 0);     --seletores do mux (usamos um vetor lógico 
                                                    --para representar as duas entradas)
        s0: out std_logic     --saída do mux (1)
    );
end mux4x1;


architecture conditional_arch of mux4x1 is  --criando uma arquitetura para o mux
    begin 
        s0 <= x0 when (c1c0 = "00") else     
              x1 when (c1c0 = "01") else    --definindo qual dos sinais de entrada vai ser o
              x2 when (c1c0 = "10") else    --sinal de saída de acordoo com os seletores c1c0
              x3;   
end conditional_arch;