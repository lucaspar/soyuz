LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; 
 
ENTITY neander_tb IS
END neander_tb;
 
ARCHITECTURE behavior OF neander_tb IS 
 
	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT Neander
	PORT(
			clk 		: IN  std_logic;
			reset 	: IN  std_logic;
			pulsing 	: OUT  std_logic;
			debug_out: OUT  std_logic
	  );
	END COMPONENT;

	COMPONENT ram_soyuz
	PORT(
			clka 	: IN  std_logic;
			wea 	: IN  std_logic_vector(0 downto 0);
			addra : IN  std_logic_vector(7 downto 0);
			dina 	: IN  std_logic_vector(7 downto 0);
			douta : OUT  std_logic_vector(7 downto 0)
	  );
	END COMPONENT;
    

	--Inputs
	signal clk 		: std_logic := '0';
	signal reset 	: std_logic := '0';

	signal clka 	: std_logic := '0';
	signal wea 		: std_logic_vector(0 downto 0) := (others => '0');
	signal addra 	: std_logic_vector(7 downto 0) := (others => '0');
	signal dina 	: std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal pulsing 	: std_logic;
	signal debug_out 	: std_logic;
	signal douta 		: std_logic_vector(7 downto 0);

	-- Clock period definitions
	constant clk_period : time := 10 ns;
 
BEGIN

	-- Clock process
   clk_process :process
   begin
		clk 	<= '0';
		clka 	<= '0';
		wait for clk_period/2;
		clk 	<= '1';
		clka 	<= '1';
		wait for clk_period/2;
   end process;
 
	-- Neander
   computer: Neander PORT MAP (
          clk => clk,
          reset => reset,
          pulsing => pulsing,
          debug_out => debug_out
        );
 
   -- Neander stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
		
      -- insert stimulus here 

      wait;
   end process;

END;
