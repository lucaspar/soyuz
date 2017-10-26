library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockDivisor is
    Port ( clk_50MHz		: in  STD_LOGIC;
			  reset 			: in  STD_LOGIC;
           clk_1Hz 		: out STD_LOGIC);
end ClockDivisor;

architecture Behavioral of ClockDivisor is

signal clk_1Hz_aux 		: std_logic := '0';

begin

	-- generate oscillators
	darude: process(reset, clk_50MHz)
	variable counter_50M : integer range 0 to 25_000_000;
	begin 
		if reset = '1' then 
			counter_50M := 0; 
		elsif rising_edge(clk_50MHz) then 
		   counter_50M := counter_50M + 1;  
			if counter_50M = 25_000_000 then 
				clk_1Hz_aux <= NOT clk_1Hz_aux; 
				counter_50M := 0; 
			end if;
		end if; 
	end process darude;
	
	-- setando o sinal
	clk_1Hz <= clk_1Hz_aux;

end Behavioral;
