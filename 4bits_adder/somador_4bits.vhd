library ieee;
use ieee.std_logic_1164.all;  -- importando bibliotecas 

entity somador_4bits is -- criando entidade para o somador de 4 bits
    port(

        x0, x1: in std_logic_vector(3 downto 0);  -- neste somador teremos duas entradas de 4 bits
        s: out std_logic_vector(3 downto 0);  -- o resultado da somad, consequentemente terá 4 bits também
        ci: in std_logic; -- carry in
        co: out std_logic -- carry out
    );
end somador_4bits;

architecture somador_4_arch of somador_4bits is -- nessa arquitetura, instanciamos 4 vezes o soomador completo
    
    signal co1, co2, co3: std_logic;  -- signal criado para armazenar o sinal do carry out dos 4 primeiros
                                      -- somadores completos
begin

    primeiro_somador_unity: entity work.somador_completo
            port map(

                ci => ci,
                co => co1,
                a => x0(0),
                b => x1(0),
                s => s(0) 
            );

        segundo_somador_unity: entity work.somador_completo
            port map(

                ci => co1,
                co => co2,
                a => x0(1),
                b => x1(1),
                s => s(1)
            );
        
        terceiro_somador_unity: entity work.somador_completo
            port map(

                ci => co2,
                co => co3,
                a => x0(2),
                b => x1(2),
                s => s(2)
            );
        
        quarto_somador_unity: entity work.somador_completo
            port map(

                ci => co3,
                co => co,
                a => x0(3),
                b => x1(3),
                s => s(3)
            );

end somador_4_arch;
