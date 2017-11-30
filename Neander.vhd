library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Neander is
	Port (
		clk 		: in STD_LOGIC;
		reset 	: in STD_LOGIC;
		pulsing	: out STD_LOGIC;
		debug_out: out STD_LOGIC
	);
end Neander;

architecture Behavioral of Neander is

	-----------------------------------
	-- 				SINAIS
	-----------------------------------
	-- clock
	signal clk_1Hz 	: std_logic := '0';
	
	-- sinais de operacoes
	signal runNOP 		: STD_LOGIC;
	signal runSTA 		: STD_LOGIC;
	signal runLDA		: STD_LOGIC;
	signal runADD 		: STD_LOGIC;
	signal runOR		: STD_LOGIC;
	signal runAND 		: STD_LOGIC;
	signal runNOT 		: STD_LOGIC;
	signal runJMP 		: STD_LOGIC;
	signal runJN	   : STD_LOGIC;
	signal runJZ 		: STD_LOGIC;
	signal runHLT 		: STD_LOGIC;
	
	-- saidas dos registradores
	signal PC_out 		: STD_LOGIC_VECTOR(7 downto 0);
	signal RI_out		: STD_LOGIC_VECTOR(7 downto 0);
	signal rem_out 	: STD_LOGIC_VECTOR(7 downto 0);
	signal rdm_out 	: STD_LOGIC_VECTOR(7 downto 0);
	signal mem_out 	: STD_LOGIC_VECTOR(7 downto 0);
	signal ac_out  	: STD_LOGIC_VECTOR(7 downto 0);
	
	-- saidas dos mux
	signal mpx_out 	: STD_LOGIC_VECTOR(7 downto 0);
	signal semrdm_out : STD_LOGIC_VECTOR(7 downto 0);
	
	-- sinais de escrita
	signal loadAC 		: STD_LOGIC;
	signal loadRI  	: STD_LOGIC;
	signal loadPC		: STD_LOGIC;
	signal loadRDM		: STD_LOGIC;
	signal loadREM 	: STD_LOGIC;
	signal loadN		: STD_LOGIC;
	signal loadZ 		: STD_LOGIC;
	
	-- ula
	signal NZ_outputN		: STD_LOGIC;
	signal NZ_outputZ		: STD_LOGIC;
	signal ula_N			: STD_LOGIC;
	signal ula_Z			: STD_LOGIC;
	signal ula_out 		: STD_LOGIC_VECTOR(7 downto 0);
	signal ula_selector	: STD_LOGIC_VECTOR(2 downto 0);
	
	-- outros sinais
	signal mpx_sel 	: STD_LOGIC;
	signal mdx_sel 	: STD_LOGIC;
	signal semrdm_sel : STD_LOGIC;
	signal incPC		: STD_LOGIC;
	signal write_ram 	: STD_LOGIC;
	
	-- PC
	signal PC_increment	: STD_LOGIC;
	signal PC_output		: STD_LOGIC_VECTOR (7 downto 0);
	
	-----------------------------------
	-- 			COMPONENTES
	-----------------------------------

	component ClockDivisor is
		Port(
			clk_50MHz	: in  STD_LOGIC;
			reset 		: in  STD_LOGIC;
			clk_1Hz 		: out STD_LOGIC
		);
	end component;
	
	component RAM is
		Port (
			clka 	: IN STD_LOGIC;
			wea 	: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			dina 	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;
	
	component InstructionDecoder is
		Port (
			opcode	: in STD_LOGIC_VECTOR (7 downto 0);
			sNOP		: out STD_LOGIC;
			sSTA		: out STD_LOGIC;
			sLDA		: out STD_LOGIC;
			sADD		: out STD_LOGIC;
			sOR		: out STD_LOGIC;
			sAND		: out STD_LOGIC;
			sNOT		: out STD_LOGIC;
			sJMP		: out STD_LOGIC;
			sJN		: out STD_LOGIC;
			sJZ		: out STD_LOGIC;
			sHLT		: out STD_LOGIC
		);
	end component;
	
	-- registradores
	component reg8bits is
		Port (
			  reg_in 	: in STD_LOGIC_VECTOR (7 downto 0);
			  clk 		: in STD_LOGIC;
			  rst 		: in STD_LOGIC;
			  reg_carga : in STD_LOGIC;
			  reg_out 	: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component; 
	
	component mux is
		Port (
				regist1	: in  STD_LOGIC_VECTOR (7 downto 0);
				regist2	: in  STD_LOGIC_VECTOR (7 downto 0);
				selec 	: in  STD_LOGIC;
				saida 	: out  STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	
	component PC_reg is
		Port ( 
				clk 			: in  STD_LOGIC;
				rst 			: in  STD_LOGIC;
				cargaPC 		: in  STD_LOGIC;
				incrementa 	: in  STD_LOGIC;
				PCin 			: in STD_LOGIC_VECTOR(7 downto 0);
				PCout 		: out  STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	
	component control_unit is
		Port (
				-- input
				clk	: in STD_LOGIC;
				rst	: in STD_LOGIC;
				
				-- instruction decoding
				runNOP, runSTA, runLDA, runADD, runOR, runAND,
				runNOT, runJMP, runJN, runJZ, runHLT : in STD_LOGIC;
				
				-- ula
				N				: in STD_LOGIC;
				Z				: in STD_LOGIC;
				sel_ula		: out STD_LOGIC_VECTOR(2 downto 0);	-- opcode de operacao na ula
				
				-- sinais de escrita
				loadAC		: out STD_LOGIC;
				loadPC		: out STD_LOGIC;
				loadREM		: out STD_LOGIC;
				loadRDM		: out STD_LOGIC;
				loadRI 		: out STD_LOGIC;
				loadN			: out STD_LOGIC;
				loadZ			: out STD_LOGIC;
				
				-- mux
				mpx_sel		: out STD_LOGIC;	-- mux_rem -> 0: PC  / 1: RDM
				mdx_sel 		: out STD_LOGIC;	-- mux_rdm -> 0: MEM / 1: AC
				
				-- outros
				PC_inc 		: out STD_LOGIC;
				write_ram 	: out STD_LOGIC;
				stop			: out STD_LOGIC	-- halt
		);
	end component;
	
-------------------------------------------------------------
begin

	-----------------------------------
	-- 			PROCESSOS
	-----------------------------------
	
	
	-- divisor de clock
	divisor: ClockDivisor
	port map(
		clk_50MHz 	=> clk,
		reset 		=> reset,
		clk_1Hz 		=> clk_1Hz
	);

	-- decodificador de instrucoes
	iDecoder: InstructionDecoder
	port map (
		opcode	=> RI_out,
		sNOP		=> runNOP,
		sSTA		=> runSTA,
		sLDA		=> runLDA,
		sADD		=> runADD,
		sOR		=> runOR,
		sAND		=> runAND,
		sNOT		=> runNOT,
		sJMP		=> runJMP,
		sJN		=> runJN,
		sJZ		=> runJZ,
		sHLT		=> runHLT
	);
	
	-- registradores
	AC : reg8bits
	PORT MAP (
				clk			=>clk,
				rst			=>reset,
				reg_carga	=>loadAC,
				reg_in		=>ula_out,
				reg_out		=>ac_out
				); 	
				
	RI : reg8bits
	PORT MAP (
				clk			=>clk,
				rst			=>reset,
				reg_carga	=>loadRI,
				reg_in		=>rdm_out,
				reg_out		=>RI_out
				); 	
	
	R_E_M : reg8bits
	PORT MAP (
				clk			=>clk,
				rst			=>reset,
				reg_carga	=>loadREM,
				reg_in		=>mpx_out,
				reg_out		=>rem_out
				); 

	R_D_M : reg8bits
	PORT MAP (
				clk			=>clk,
				rst			=>reset,
				reg_carga	=>loadRDM,
				reg_in		=>semrdm_out,
				reg_out  	=>rdm_out
				);  
  
	PC : PC_reg
	PORT MAP ( 
				clk			=> clk,
				rst 			=> reset,
				cargaPC 		=> loadPC,
				incrementa 	=> incPC,
				PCin 			=> RDM_out,
				PCout 		=> PC_out
				);
				
	MPX : mux
	PORT MAP (
				regist1 		=>PC_out,
				regist2		=>rdm_out,
				selec			=>mpx_sel,
				saida			=>mpx_out
				);
				
	SEMRDM: mux
	PORT MAP (
				regist1		=> mem_out,
				regist2		=> ac_out,
				selec			=> semrdm_sel,
				saida			=> semrdm_out
				);
				
	CU: control_unit
	port map (
		clk 	=> clk, 				rst	=> reset,
		N 		=> NZ_outputN, 	Z 		=> NZ_outputZ,
		
		-- instruction decoding
		runNOP => runNOP, 	runSTA => runSTA,		runLDA => runLDA,
		runADD => runADD, 	runOR	 => runOR,  	runAND => runAND,
		runNOT => runNOT,		runJMP => runJMP, 	runHLT => runHLT,
		runJN  => runJN,		runJZ	 => runJZ,

		-- sinais de escrita
		loadREM => loadREM,
		loadAC  => loadAC,	loadPC => loadPC,
		loadRDM => loadRDM, 	loadRI => loadRI,
		loadN	  => loadN, 	loadZ  => loadZ,
		
		-- outros
		sel_ula => ula_selector, 	write_ram 	=> write_ram,
		mpx_sel => mpx_sel, 			PC_inc 		=> PC_increment,
		mdx_sel => mdx_sel, 			stop 			=> debug_out
	);
				
	-- processo teste
	pulse: process(clk_1Hz)
	variable pulse_aux : std_logic := '0';
	begin
		if rising_edge(clk_1Hz) then
			pulse_aux := not pulse_aux;
		end if;			
		pulsing <= pulse_aux;
	end process pulse;

end Behavioral;

