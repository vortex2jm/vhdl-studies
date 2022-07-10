library ieee;
use ieee.std_logic_1164.all;
entity eq_top is
	port(
		sw : in std_logic_vector(15 downto 0);
		led : out std_logic_vector(15 downto 0);
	);
end eq_top;

architecture jk of eq_top is
begin
	encoder_unity: entity work.prio_encoder(if_arch)
	port map(
		r => sw(15 downto 12),
		pcode => led(15 downto 13)
	);
	
	decoder_unity: entity work.decoder_2_4(if_arch)
	port map(
		a => sw(1 downto 0).
		en => sw(2),
		y => led(3 downto 0)
	);
	
end jk;
