library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_reg is
    Port ( clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  cargaPC : in  STD_LOGIC;
			  incrementa : in  STD_LOGIC;
			  PCin : in STD_LOGIC_VECTOR(7 downto 0);
			  PCout : out  STD_LOGIC_VECTOR(7 downto 0)); 
end PC_reg;

architecture Behavioral of PC_reg is

	signal data_aux: STD_LOGIC_VECTOR(7 downto 0);

begin
	
	process(clk, rst)
	begin
		if (rst = '1') then
			data_aux <= "00000000";
		elsif (clk = '1' and clk'event) then
			if (cargaPC	= '1') then
				data_aux <= PCin;
			elsif (incrementa = '1') then
				data_aux <= STD_LOGIC_VECTOR(unsigned(data_aux) + 1);
			end if;
		end if;
	end process;	
	PCout <= data_aux;
	
end Behavioral;
