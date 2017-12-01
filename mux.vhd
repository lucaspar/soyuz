----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:29:26 11/29/2017 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
    Port ( regist1 : in  STD_LOGIC_VECTOR (7 downto 0);
           regist2 : in  STD_LOGIC_VECTOR (7 downto 0);
           selec : in  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end mux;

architecture Behavioral of mux is

begin

	saida <= regist1 when selec = '0' else
		regist2 when selec = '1' ;


end Behavioral;

