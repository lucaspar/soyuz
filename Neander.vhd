library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Neander is
	Port (
		clk 			: in STD_LOGIC;
		reset 		: in STD_LOGIC;
		pulsing		: out STD_LOGIC
	);
end Neander;

architecture Behavioral of Neander is

	signal clk_1Hz 		: std_logic := '0';
	
	-- registradores
	signal RI_out			: STD_LOGIC_VECTOR (7 downto 0);
	
	-- operacoes
	signal runNOP 		: STD_LOGIC;
	signal runSTA 		: STD_LOGIC;
	signal runLDA		: STD_LOGIC;
	signal runADD 		: STD_LOGIC;
	signal runOR		: STD_LOGIC;
	signal runAND 		: STD_LOGIC;
	signal runNOT 		: STD_LOGIC;
	signal runJMP 		: STD_LOGIC;
	signal runJN	   : STD_LOGIC;
	signal runJZ 		: STD_LOGIC;
	signal runHLT 		: STD_LOGIC;

	component ClockDivisor is
		Port(
				clk_50MHz	: in  STD_LOGIC;
				reset 		: in  STD_LOGIC;
				clk_1Hz 		: out STD_LOGIC
			 );
	end component;
	
	component RAM is
		PORT (
			clka 	: IN STD_LOGIC;
			wea 	: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			dina 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;
	
	component InstructionDecoder is
		Port (
			opcode	: in STD_LOGIC_VECTOR (7 downto 0);
			sNOP		: out STD_LOGIC;
			sSTA		: out STD_LOGIC;
			sLDA		: out STD_LOGIC;
			sADD		: out STD_LOGIC;
			sOR		: out STD_LOGIC;
			sAND		: out STD_LOGIC;
			sNOT		: out STD_LOGIC;
			sJMP		: out STD_LOGIC;
			sJN		: out STD_LOGIC;
			sJZ		: out STD_LOGIC;
			sHLT		: out STD_LOGIC
		);
	end component;

begin
	
	divisor: ClockDivisor
	port map(
		clk_50MHz 	=> clk,
		reset 		=> reset,
		clk_1Hz 		=> clk_1Hz
	);
				
	iDecoder: InstructionDecoder
	port map (
		opcode	=> RI_out,
		sNOP		=> runNOP,
		sSTA		=> runSTA,
		sLDA		=> runLDA,
		sADD		=> runADD,
		sOR		=> runOR,
		sAND		=> runAND,
		sNOT		=> runNOT,
		sJMP		=> runJMP,
		sJN		=> runJN,
		sJZ		=> runJZ,
		sHLT		=> runHLT
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

