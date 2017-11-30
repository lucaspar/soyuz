library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is

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

end control_unit;

architecture Behavioral of control_unit is

	type state_machine is (
		BUSCA_INSTRUCAO, 	BUSCA_DADOS, 		BUSCA_ENDERECO,
		LER_INSTRUCAO, 	CARREGA_RI, 		LER_MEMORIA,
		RUN_STA2, 			RUN_STA1, 			RUN_ULA, 			RUN_ULA2,
		TRATA_JUMP, 		TRATA_JUMP_FAIL,
		IDLE, 				HALT
	);
		
	signal current_state : state_machine;
	signal next_state 	: state_machine;
	signal stop_s 			: STD_LOGIC;

begin

	-- sincroniza execucao
	synchrony: process(next_state, rst, clk)
		begin
			if (rst = '1') then
				current_state <= IDLE;
			elsif rising_edge(clk) then
				current_state <= next_state;
			end if;
	end process synchrony;

	-- executa operacoes
	process (clk, rst)
	begin
	
		-- reset all
		if (rst = '1') then
			stop_s 		<= '0';
			loadAC 		<= '0';
			loadPC 		<= '0';
			loadREM 		<= '0';
			loadRDM 		<= '0';
			loadRI 		<= '0';			
			loadN 		<= '0';
			loadZ 		<= '0';			
			write_ram 	<= '0';
			next_state 	<= IDLE;
			
		-- transicao de estados
		elsif rising_edge(clk) then
			case current_state is
			
				when IDLE =>
					if (stop_s /= '1') then
						next_state <= BUSCA_INSTRUCAO;
					else
						next_state <= IDLE;
					end if;
					
				-- REM <- PC
				when BUSCA_INSTRUCAO =>
					mdx_sel 		<= '0';		-- MEM -> RDM
					loadAC 		<= '0';
					loadPC 		<= '0';
					PC_inc 		<= '0';
					loadRDM 		<= '0';
					loadRI 		<= '0';
					write_ram 	<= '0';
					loadN 		<= '0';
					loadZ 		<= '0';
					mpx_sel 		<= '0'; 		-- select 0 for PC -> REM
					loadREM 		<= '1'; 		-- load REM
					next_state 	<= LER_INSTRUCAO;
					
				-- MEM -> RDM, PC++
				when LER_INSTRUCAO =>
					loadREM <= '0';
					loadRDM <= '1';
					PC_inc <= '1'; 
					next_state <= CARREGA_RI;
					
				-- RDM -> RI
				when CARREGA_RI =>
					loadRDM <= '0';
					PC_inc <= '0';
					loadRI <= '1';
					
					if (runHLT = '1') then 				-- HLT
						next_state <= HALT;
					elsif (runNOP = '1') then 			-- NOP
						next_state <= BUSCA_INSTRUCAO;
					elsif (runNOT = '1') then 			-- NOT
						next_state <= RUN_ULA2;
					-- jump error
					elsif ((runJN = '1') and (N = '0')) or ((runJZ = '1') and (Z = '0')) then
						next_state <= TRATA_JUMP_FAIL;
					else
						next_state <= BUSCA_DADOS;
					end if;
					
				-- REM <- PC
				when BUSCA_DADOS =>
					loadRI <= '0';
					mpx_sel <= '0';
					loadREM <= '1';
					next_state <= LER_MEMORIA;
					
				-- RDM <- MEM, PC++
				when LER_MEMORIA =>
					loadREM <= '0';
					loadRDM <= '1';
					PC_inc <= '1';
					if (runADD = '1') then 		-- ADD
					next_state <= BUSCA_ENDERECO;
					elsif (runOR = '1') then 	-- OR
					next_state <= BUSCA_ENDERECO;
					elsif (runAND = '1') then 	-- AND
					next_state <= BUSCA_ENDERECO;
					elsif (runLDA = '1') then 	-- LDA
					next_state <= BUSCA_ENDERECO;
					elsif (runSTA = '1') then 	-- STA
					next_state <= BUSCA_ENDERECO;
					-- real jump
					elsif ((runJMP = '1') or ((runJN = '1') and (N = '1')) or ((runJZ = '1') and (Z = '1'))) then
						next_state <= TRATA_JUMP;
					else
						next_state <= IDLE;
					end if;
					
				-- RDM -> REM
				when BUSCA_ENDERECO =>
					loadRDM <= '0';
					PC_inc <= '0';
					mpx_sel <= '1';				-- 1: RDM -> REM
					loadREM <= '1';
					
					if (runADD = '1') then 	 	-- ADD
						next_state <= RUN_ULA;
					elsif (runOR = '1') then  	-- OR
						next_state <= RUN_ULA;
					elsif (runAND = '1') then 	-- AND
						next_state <= RUN_ULA;
					elsif (runLDA = '1') then 	-- LDA
						next_state <= RUN_ULA;
					elsif (runSTA = '1') then 	-- STA
						next_state <= RUN_STA1;
					end if;
					
				-- RDM <- MEM
				when RUN_ULA =>
					loadREM <= '0';
					loadRDM <= '1';
					
					if (runADD = '1') then 	 	-- ADD
						sel_ula <= "000";
					elsif (runAND = '1') then 	-- AND
						sel_ula <= "001";
					elsif (runOR = '1') then  	-- OR
						sel_ula <= "010";				
					elsif (runNOT = '1') then 	-- NOT
						sel_ula <= "011";
					elsif (runLDA = '1') then 	-- LDA
						sel_ula <= "100";
					end if;
					next_state <= RUN_ULA2;
					
				-- AC <- ULA
				when RUN_ULA2 =>
					loadRDM <= '0';
					loadRI <= '0';
					loadAC <= '1';
					loadN <= '1';
					loadZ <= '1';
					next_state <= BUSCA_INSTRUCAO;
					
				-- RDM <- AC
				when RUN_STA1 =>
					loadREM <= '0';
					mdx_sel <= '1'; 				-- select 1 for AC->RDM
					loadRDM <= '1';
					next_state <= RUN_STA2;
					
				-- MEM <- RDM(write)
				when RUN_STA2 =>
					mdx_sel <= '0';
					loadRDM <= '0';
					write_ram <= '1';
					next_state <= BUSCA_INSTRUCAO;
					
				-- PC <- RDM
				when TRATA_JUMP =>
					loadRDM <= '0';
					PC_inc <= '0';
					loadPC <= '1';
					next_state <= BUSCA_INSTRUCAO;
					
				-- PC++
				when TRATA_JUMP_FAIL =>
					loadRI <= '0';
					PC_inc <= '1';
					next_state <= BUSCA_INSTRUCAO;
					
				-- STOP
				when HALT =>
					loadRI <= '0';
					stop_s <= '1';
					next_state <= IDLE;
					
				when others =>
					next_state <= IDLE;

			end case;
		end if;
	end process;
	
	stop <= stop_s;

end Behavioral;

