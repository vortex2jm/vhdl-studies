--codificador de prioridade 3 x 2
library ieee;
use ieee.std_logic_1164.all;    --importando bibliotecas

entity encoder4x2 is    --criando uma entidade para o codificador
    port(

        shr_1, shr_1c, shl_1: in std_logic;   --entradas do codificador (3)

        c1c0: out std_logic_vector(1 downto 0) --definimos um vetor lógico para a saída do codificador(2)
    );                                         --(lembrando que o sinal de saída do codificador será     
end encoder4x2;                                --o sinal de entrada dos seletores do mux 4x1)


architecture conditional_arch of encoder4x2 is  --criando uma arquitetura para o codificador
    begin
        c1c0 <= "11" when (shr_1 = '1') else
                "10" when (shr_1c = '1') else   --definindo as saídas de acordo com as entradas
                "01" when (shl_1 = '1') else    --lembrando que cada entrada representa uma função diferente
                "00";                           --do deslocador
end conditional_arch;