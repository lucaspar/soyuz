library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

