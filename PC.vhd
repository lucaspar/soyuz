----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:08:54 11/29/2017 
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
