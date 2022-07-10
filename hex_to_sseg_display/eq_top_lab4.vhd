library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity hex_to_sseg_test is

   port(
	clk : in std_logic;
   	sw : in std_logic_vector(15 downto 0);
   	an : out std_logic_vector(7 downto 0);
   	sseg : out std_logic_vector(7 downto 0)
   );

end hex_to_sseg_test;


architecture arch of hex_to_sseg_test is

signal led3, led2, led1, led0 : std_logic_vector (7 downto 0);

begin

   sseg_unit0 : entity work.hex_to_sseg(arch)
      port map(
      
	hex => sw(3 downto 0); 
	dp => '1';
	sseg => led0 	

      );


   sseg_unit1 : entity work.hex_to_sseg(arch)
      port map(
      
	hex => sw(7 downto 4); 
	dp => '1';
	sseg => led1 	

      );


   sseg_unit2 : entity work.hex_to_sseg(arch)
      port map(
      
	hex => sw(11 downto 8); 
	dp => '1';
	sseg => led2 	

      );

	
   sseg_unit4 : entity work.hex_to_sseg(arch)
      port map(
      
	hex => sw(15 downto 12); 
	dp => '1';
	sseg => led3 	

      );

	
   mux_unity : entity work.led_mux8(arch)
   	port map(

	 clk => clk;
         reset => '0';
	 in0 => led0;
       	 in1 => led1;
	 in2 => led2;
	 in3 => led3;
	 in4 => led0;
	 in5 => led1;
	 in6 => led2;
	 in7 => led3;
	 an => an;
	 sseg => sseg;	
	
	);

end arch; 