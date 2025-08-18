-- Test of CPU Instruction 1110000 - ADD Imm x47, Add x47 to the value in the accumulator

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test_ADD_Imm is
end entity CPU_Test_ADD_Imm;


architecture Behavioral of CPU_Test_ADD_Imm is
    -- Component declaration for the CPU module
    component CPU
        port (
		Clock			: in std_logic;
		Slow_Clock		: in std_logic;
		Reset			: in std_logic;
		Memory_Data_In		: in std_logic_vector(7 downto 0);

		Memory_Address_Low		: out std_logic_vector(7 downto 0);
		Memory_Address_High		: out std_logic_vector(7 downto 0);
		Memory_Read_Enable	: out std_logic;

		A_Reg_External_Output	: out std_logic_vector(7 downto 0)		
        );
    end component;

	-- Signal declarations
	signal Clock_Test			: std_logic;
	signal Reset_Test			: std_logic;
	signal Memory_Data_In_Test			: std_logic_vector(7 downto 0);
	signal Memory_Address_Low_Test		: std_logic_vector(7 downto 0);
	signal Memory_Address_High_Test		: std_logic_vector(7 downto 0);
	signal Memory_Read_Enable_Test		: std_logic;
	signal A_Reg_External_Output_Test	: std_logic_vector(7 downto 0);

begin

	UUT: CPU
        port map (
            	Clock			=> Clock_Test,
		Slow_Clock		=> '1', -- always set to 1 for test purposes
		Reset			=> Reset_Test,
		Memory_Data_In		=> Memory_Data_In_Test,
		
		Memory_Address_Low	=> Memory_Address_Low_Test,
		Memory_Address_High	=> Memory_Address_High_Test,
		Memory_Read_Enable 	=> Memory_Read_Enable_Test,

		A_Reg_External_Output => A_Reg_External_Output_Test
        );

-- Stimulus process to apply test vectors
    stimulus_proc: process
	begin
	-- if clock is low and reset test is asserted, FSM is set to initial state
		Clock_Test	<= '0';
		Reset_Test	<= '1';

		report "Running Clock Cycle while Reset is asserted";
		
		-- FSM and PC will be held in initial state while Reset signal is still asserted
        	wait for 10 ns;

		report "Step 0: Initial State (No Action)";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';

		report "Switching off Reset";
		-- switch off reset to release FSM and allow cycles to start
		Reset_Test	<= '0';
		wait for 10 ns;
		-- continue through CPU cycles

		report "Step 1: Fetch Instruction";
		Clock_Test	<= '1';
		wait for 10 ns;
		
		report "Running tests for CPU reading Memory location 0000000000000000";
		assert Memory_Address_Low_Test = "00000000"	report "Test 1: Memory_Address_Low_Test should equal 00000000" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;

		report "Instruction is 00010001 LDA # to set first operand of operation";
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for CPU reading Memory location &01 0000000000000001";
		assert Memory_Address_Low_Test = "00000001"	report "Test 1: Memory_Address_Low_Test should equal 00000001" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		-- One more clock cycle to make value of A Register and PC increment visible  
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;
	
		report "Running tests for Loading A Register with value 00110101 (#35)";
		assert A_Reg_External_Output_Test = "00110101"	report "Test: A_Reg_External_Output_Test should equal 00110101" severity error;

		report "Running tests for CPU reading Memory location &02 0000000000000010"; 
		assert Memory_Address_Low_Test = "00000010"	report "Test 1: Memory_Address_Low_Test should equal 00000010" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;

		report "Instruction is 11100000 AND # ";
		Clock_Test	<= '1';
		wait for 10 ns;

		report "One cycle to load accumulator into the ALU temporary register (not directly tested)";
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for CPU reading Memory location &03 0000000000000011"; 
		assert Memory_Address_Low_Test = "00000011"	report "Test 1: Memory_Address_Low_Test should equal 00000011" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		report "A further cycle to allow result to be loaded into the ALU internal result register";
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "A further cycle to allow result to be loaded into into accumulator";
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for Result of 35 ADD 47  = 7C in the accumulator";
		assert A_Reg_External_Output_Test = "01111100"	report "Test: A_Reg_External_Output_Test should equal 01111100" severity error;

		wait;
	end process stimulus_proc;

	-- Simulate memory response
    	process
    	begin
        	wait for 1 ns;  -- Wait for a small time to simulate memory access time
        
		-- LDA # 53 (load accumulator with first operand of AND operation)
        	if Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000000" and Memory_Address_High_Test = "00000000" then
            		Memory_Data_In_Test <= "00010001"; -- LDA #
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000001" and Memory_Address_High_Test = "00000000" then
			Memory_Data_In_Test <= "00110101"; -- #x35
		-- now give AND instruction with value of second operand
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000010" and Memory_Address_High_Test = "00000000" then
			Memory_Data_In_Test <= "11100000"; -- ADD #
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000011" and Memory_Address_High_Test = "00000000" then
			Memory_Data_In_Test <= "01000111"; -- #x47
        	else
            		Memory_Data_In_Test <= "ZZZZZZZZ";  -- Default data value when the condition is not met
        	end if;

    		-- Stop process after 300 ns
    		if now = 300 ns then
        		report "Simulation completed successfully after 300 ns" severity note;
        		wait;
    		end if;
    	end process;


 
end architecture Behavioral;