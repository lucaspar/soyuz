LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Neander
    PORT(
         clk 		: IN  std_logic;
         reset 	: IN  std_logic;
         troca 	: IN  std_logic;
         pulsing 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk 		: std_logic := '0';
   signal reset 	: std_logic := '0';
   signal troca 	: std_logic := '0';

 	--Outputs
   signal pulsing : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Neander PORT MAP (
          clk 		=> clk,
          reset 	=> reset,
          troca 	=> troca,
          pulsing => pulsing
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
