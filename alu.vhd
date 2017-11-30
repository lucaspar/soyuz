LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
use IEEE.std_logic_arith.all;
USE ieee.numeric_std.all;

entity alu is
	Port ( 	
		X 			: in  STD_LOGIC_VECTOR (7 downto 0);
		Y 			: in  STD_LOGIC_VECTOR (7 downto 0);
		operation: in  STD_LOGIC_VECTOR (2 downto 0);
		N			: out STD_LOGIC;
		Z			: out STD_LOGIC;
		output  	: out STD_LOGIC_VECTOR (7 downto 0)
	);
end alu;

architecture Behavioral of alu is
	
	signal result 	: STD_LOGIC_VECTOR(7 downto 0);
	signal a, b 	: STD_LOGIC_VECTOR(7 downto 0);
	
begin

	a <= X;
	b <= Y;

	process(operation, a, b)
	begin
		
		case operation is
			when "000" => 	result <= a + b; 		-- ADD
			when "001" => 	result <= a AND b; 	-- AND
			when "010" => 	result <= a OR b; 	-- OR
			when "011" => 	result <= not(a);		-- NOT
			when "100" => 	result <= b;			-- LDA
			when others => result <= b;
		end case;
		
		-- negative flag
		N <= result(7);		-- first bit
		
		-- zero flag
		if(result = "0") then
			Z <= '1';
		else
			Z <= '0';
		end if;
		
	end process;
	
	output <= result;

end Behavioral;

