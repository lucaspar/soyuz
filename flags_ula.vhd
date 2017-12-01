library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flags_ula is
	port (
			clk 	: in  STD_LOGIC;
			reset	: in  STD_LOGIC;

			loadN : in  STD_LOGIC;
			N_in  : in 	STD_LOGIC;
			N_out	: out STD_LOGIC;
			
			loadZ	: in 	STD_LOGIC;
			Z_in  : in  STD_LOGIC;
			Z_out : out STD_LOGIC
	);
end flags_ula;

architecture Behavioral of flags_ula is

	signal sN: STD_LOGIC;
	signal sZ: STD_LOGIC;

begin

	process (clk, reset)
	begin
		if (reset = '1') then
			sN <= '0';
			sZ <= '0';
		elsif rising_edge(clk) then
			if (loadN = '1') then sN <= N_in; end if;
			if (loadZ = '1') then sZ <= Z_in; end if;
		end if;
	end process;
	
	N_out <= sN;
	Z_out <= sZ;

end Behavioral;