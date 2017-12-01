library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
ENTITY ram_tb IS
END ram_tb;
 
ARCHITECTURE behavior OF ram_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram_soyuz
    PORT(
         clka : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         addra : IN  std_logic_vector(7 downto 0);
         dina : IN  std_logic_vector(7 downto 0);
         douta : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal addra : std_logic_vector(7 downto 0) := (others => '0');
   signal dina : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal douta : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clka_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_soyuz PORT MAP (
          clka => clka,
          wea => wea,
          addra => addra,
          dina => dina,
          douta => douta
        );

   -- Clock process definitions
   clka_process :process
   begin
		clka <= '0';
		wait for clka_period/2;
		clka <= '1';
		wait for clka_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clka_period*10;

      -- insert stimulus here 

      wait;
   end process;
	
	-- Stimulus process
   read_mem: process
   begin
	
		wait for clka_period;
		
		addra <= std_logic_vector(to_unsigned(to_integer(unsigned( addra )) + 1, 8));
		
   end process;

END;
