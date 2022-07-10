--toplevel -> remapeando portas para o FPGA
library ieee;
use ieee.std_logic_1164.all;    --importando bibliotecas


entity toplevel2 is --criando a entidade
    port(

        sw: in std_logic_vector(7 downto 0);    --selecionadno os 8 primeiros switches do FPGA(da direita pra esquerda)

        led: out std_logic_vector(2 downto 0)   --selecionando os 3 primeiros leds do FPGA (da direita pra esquerda)
    );
end toplevel2;


architecture displacer of toplevel2 is  --criando a arquitetura para o deslocador de 3 bits

    signal c1c0: std_logic_vector(1 downto 0);  --criando um sinal lógico a partir de um vetor lógico de 2 posições
    
    begin
    
        priority_encoder_unity: entity work.encoder4x2
        port map(
            shr_1 => sw(5),  --cada entrada do codificador será controlada por um switch diferente
            shr_1c => sw(6),
            shl_1 => sw(7),
            c1c0 => c1c0    --o sinal lógico declarado acima recebe os valores da saída do codificador
        );

        --abaixo serão implementadas 3 unidades do mux. Cada saída de um mux será um bit do deslocador
        --lembrando que as entradas do mux podem possuir 5 sinais distintos controlados por switches
        --os seletores receberão o sinal lógico declarado acima, que possui valor oriundo da saída do codificador
        --as saídas do mux serão direcionadas para leds discretos do FPGA

    mux_s0_unity: entity work.mux4x1    
        port map(
            x0 => sw(1),    --definindo os switches como as entradas do mux
            x1 => sw(0),    
            x2 => sw(2),    
            x3 => sw(2),
            s0 => led(0),   --definindo a saída para o led
            c1c0 => c1c0    --seletores recebendo o sinal lógico da saída do codificador
        );

    mux_s1_unity: entity work.mux4x1
        port map(
            x0 => sw(2),
            x1 => sw(1),
            x2 => sw(3),
            x3 => sw(3),
            s0 => led(1),
            c1c0 => c1c0
        );

    mux_s2_unity: entity work.mux4x1
        port map(
            x0 => sw(3),
            x1 => sw(2),
            x2 => sw(1),
            x3 => sw(4),
            s0 => led(2),
            c1c0 => c1c0
        );

end displacer;