library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Neander is
	Port (
		clk 			: in STD_LOGIC;
		reset 		: in STD_LOGIC;
		troca 		: in STD_LOGIC;
		pulsing		: out STD_LOGIC
	);
end Neander;

architecture Behavioral of Neander is

	signal clk_1Hz 	: std_logic := '0';

	component ClockDivisor is
		Port(
				clk_50MHz	: in  STD_LOGIC;
				reset 		: in  STD_LOGIC;
				clk_1Hz 		: out STD_LOGIC
			 );
	end component;

begin
	
	divisor: ClockDivisor port map(
												clk_50MHz 	=> clk,
												reset 		=> reset,
												clk_1Hz 		=> clk_1Hz
											);
											
	pulse: process(clk_1Hz)
	
		variable pulse_aux : std_logic := '0';
		
		begin
	
			if rising_edge(clk_1Hz) then
				pulse_aux := not pulse_aux;
			end if;
			
			pulsing <= pulse_aux;
			
	end process pulse;

end Behavioral;

