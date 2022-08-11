library IEEE;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

entity top_reg is

  port(
    clk: in std_logic;
    sw: in std_logic_vector(15 downto 0);
    led: out std_logic_vector(3 downto 0);
  );

end top_reg;

architecture top_reg_arch of top_reg is

  signal cod_prio_out: std_logic_vector(1 downto 0);
  signal enable: std_logic;
  signal mux_out, ffd_out, inc_4bits_out: std_logic_vector(3 downto 0);

  begin
    
    --divisor de clock
    div_clk_unity: entity work.div_clk
    port map(
      clk => clk,
      en => enable
    );

    --codificador de prioridade
    cod_prio_unity: entity work.cod_prio
    port map(
      r => sw(15 downto 13),
      pcode => cod_prio_out
    );
    
    --Somador de 4 bits
    inc_4bits_unity: entity work.inc_4bits
    port map(
      inc_in => ffd_out,
      inc_out => inc_4bits_out
    );


    --primeiro bloco--------------------------------------------
    mux_4x1_unity1: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(0),
      i(0) => ffd_out(0),
      i(1) => ffd_out(1),
      i(2) => inc_4bits_out(0),
      i(3) => sw(0)
    );

    ffd_unity1: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(0),
      Q => ffd_out(0)
    );

    --segundo bloco-----------------------------------------------
    mux_4x1_unity2: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(1),
      i(0) => ffd_out(1),
      i(1) => ffd_out(2),
      i(2) => inc_4bits_out(1),
      i(3) => sw(1)

    );

    ffd_unity1: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(1),
      Q => ffd_out(1)
    );

    --terceiro bloco------------------------------------------------
    mux_4x1_unity3: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(2),
      i(0) => ffd_out(2),
      i(1) => ffd_out(3),
      i(2) => inc_4bits_out(2),
      i(3) => sw(2)
    );

    ffd_unity1: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(2),
      Q => ffd_out(2)
    );
    
    --quarto bloco---------------------------------------------------
    mux_4x1_unity4s: entity work.mux_4x1
    port map(
      c => cod_prio_out,
      s => mux_out(3),
      i(0) => ffd_out(3),
      i(1) => sw(5),  --SHR_in
      i(2) => inc_4bits_out(3),
      i(3) => sw(3)
    );

    ffd_unity1: entity work.FF_D
    port map(
      clk => clk,
      e => enable,
      D => mux_out(3),
      Q => ffd_out(3)
    );

    led <= ffd_out; --leds recebem a saída dos flip flops

end top_reg_arch;

--Só falta ajeitar o arquivo de constraints...