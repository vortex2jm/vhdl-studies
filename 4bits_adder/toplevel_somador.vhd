library ieee;
use ieee.std_logic_1164.all;  -- importando bibliotecas

entity top_somador is -- criando entidade para o somador/subtrator
    port(

        sw: in std_logic_vector(8 downto 0);  -- 8 switches para os 2 numeros de 4 bits e um para selecionar a operação
        led: out std_logic_vector(4 downto 0) -- 4 leds para mostrar o resultado da soma e um para mostrar o overflow
    );

end top_somador;

architecture soma of top_somador is -- nesta arquitetura utilizamos um somador de 4 bits e um mux para selecionar a operação

    signal outMux: std_logic_vector(3 downto 0);  -- sinal de saida do mux para ligar em uma das entradas do somador
    signal saida: std_logic_vector(3 downto 0); -- sinal de saida do somador para realizar operacaco para identificar overflow
                                                -- e jogar seus valores nos leds
    begin

    mux2x1_unity: entity work.mux_2x1
        port map(

            x0 => sw(3 downto 0),
            sub => sw(8),
            s => outMux
        );
    
    somador4_unity: entity work.somador_4bits
        port map(

            x0 => outMux,
            x1 => sw(7 downto 4),
            s => saida,
            ci => sw(8)
        );
        
    led(3 downto 0) <= saida;
     
    led(4) <= ((outMux(3) and sw(7)) and (not saida(3))) or ((not outMux(3) and not sw(7)) and (saida(3)));
    -- acima está a expressão para identificar overflow
end soma
