----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:56:14 11/26/2017 
-- Design Name: 
-- Module Name:    PC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( 
				clk : in  STD_LOGIC;
				wea : in  STD_LOGIC;
				cargaPC : in  STD_LOGIC;
				incrementa : in  STD_LOGIC;
				PCdina : in STD_LOGIC_VECTOR(7 downto 0);
				PCdouta : out  STD_LOGIC_VECTOR(7 downto 0)
			 ); 
end PC;

architecture Behavioral of PC is

	signal data_aux: STD_LOGIC_VECTOR(7 downto 0);

begin
	
	process(clk, wea)
	begin
		if (wea = '1') then
			data_aux <= "00000000";
		elsif (clk = '1' and clk'event) then
			if (cargaPC	= '1') then
				data_aux <= PCdina;
			elsif (incrementa = '1') then
				data_aux <= STD_LOGIC_VECTOR(unsigned(data_aux) + 1);
			end if;
		end if;
	end process;	
	PCdouta <= data_aux;
	
end Behavioral;

