----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:09:59 11/29/2017 
-- Design Name: 
-- Module Name:    reg8bits - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg8bits is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reg_in : in  STD_LOGIC_VECTOR (7 downto 0);
           reg_carga : in  STD_LOGIC;
           reg_out : out  STD_LOGIC_VECTOR (7 downto 0));
end reg8bits;

architecture Behavioral of reg8bits is
	signal aux : STD_LOGIC_VECTOR (7 downto 0);
	constant aux_delay: TIME := 2 ns; 
begin
	process (clk, rst)
	begin
		if(rst = '1') then
			aux <= "00000000";
		elsif (clk = '1' and clk'EVENT) then
			if (reg_carga = '1') then
				aux <= reg_in;
			end if;
		end if;	
	end process;	
	reg_out <= aux;

end Behavioral;
