library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionDecoder is
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
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is
	
	begin
	process(opcode) is
		
		begin
	
		sNOP <= '0';
		sSTA <= '0';
		sLDA <= '0';
		sADD <= '0';
		sOR  <= '0';
		sAND <= '0';
		sNOT <= '0';
		sJMP <= '0';
		sJN  <= '0';
		sJZ  <= '0';
		sHLT <= '0';
	
		case opcode(7 downto 4) is
			when "0000" => sNOP <= '1';
			when "0001" => sSTA <= '1';
			when "0010" => sLDA <= '1';
			when "0011" => sADD <= '1';
			when "0100" => sOR  <= '1';
			when "0101" => sAND <= '1';
			when "0110" => sNOT <= '1';
			when "1000" => sJMP <= '1';
			when "1001" => sJN  <= '1';
			when "1010" => sJZ  <= '1';
			when "1111" => sHLT <= '1';
			when others => sNOP <= '1';
		end case;
		
	end process;

end Behavioral;

