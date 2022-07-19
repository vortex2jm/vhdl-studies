library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity debounce_test is
   port(
      clk  : in  std_logic;
      btn  : in  std_logic_vector(1 downto 0);
      an   : out std_logic_vector(7 downto 0);  -- Modifica��es Anselmo e Fabi
      sseg : out std_logic_vector(7 downto 0)
   );
end debounce_test;

architecture arch of debounce_test is
   signal q1_reg, q1_next   : unsigned(7 downto 0);
   signal q0_reg, q0_next   : unsigned(7 downto 0);
   signal b_count, d_count  : std_logic_vector(7 downto 0);
   signal btn_reg, db_reg   : std_logic;
   signal db_level, db_tick : std_logic;
   signal btn_tick, clr     : std_logic;
begin
   --*****************************************************************
   -- Modifica��es Anselmo e Fabi
   --*****************************************************************
       an(7 downto 4)<="1111";
        
        
   --*****************************************************************
   -- component instantiation
   --*****************************************************************
   -- instantiate hex display time-multiplexing circuit
   disp_unit : entity work.disp_hex_mux
      port map(
         clk   => clk,
         reset => '0',
         hex3  => d_count(7 downto 4), -- Modifica��es Anselmo e Fabi --  Est� diferente do desenho do livro. Modificamos para ficar igual --
         hex2  => d_count(3 downto 0), -- Modifica��es Anselmo e Fabi --  Est� diferente do desenho do livro. Modificamos para ficar igual --
         hex1  => b_count(7 downto 4), -- Modifica��es Anselmo e Fabi --  Est� diferente do desenho do livro. Modificamos para ficar igual --
         hex0  => b_count(3 downto 0), -- Modifica��es Anselmo e Fabi --  Est� diferente do desenho do livro. Modificamos para ficar igual --
         dp_in => "1011",
         an    => an(3 downto 0),          -- Modifica��es Anselmo e Fabi --
         sseg  => sseg
      );
   -- instantiate debouncing circuit
   db_unit : entity work.db_fsm(arch)
      port map(
         clk   => clk,
         reset => '0',
         sw    => btn(1),
         db    => db_level
      );

   --*****************************************************************
   -- edge detection circuits
   --*****************************************************************
   process(clk)
   begin
      if (clk'event and clk = '1') then
         btn_reg <= btn(1);
         db_reg  <= db_level;
      end if;
   end process;
   btn_tick <= (not btn_reg) and btn(1);
   db_tick  <= (not db_reg) and db_level;

   --*****************************************************************
   -- two counters
   --*****************************************************************
   clr <= btn(0);
   process(clk)
   begin
      if (clk'event and clk='1') then
         q1_reg <= q1_next;
         q0_reg <= q0_next;
      end if;
   end process;
   -- next-state logic for the counter
   q1_next <= (others=>'0') when clr='1' else
              q1_reg + 1    when btn_tick='1' else
              q1_reg;
   q0_next <= (others=>'0') when clr='1' else
              q0_reg + 1    when db_tick='1' else
              q0_reg;
   --output
   b_count <= std_logic_vector(q1_reg);
   d_count <= std_logic_vector(q0_reg);
end arch;
