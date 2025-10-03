
-- Test of CPU Instruction 10001000 - AND Abs 42, AND 42 with the value in the accumulator

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test_AND_Abs is
end entity CPU_Test_AND_Abs;


architecture Behavioral of CPU_Test_AND_Abs is
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

		report "Fetch Instruction LDA#";
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

		report "Step 1 of LDA: Fetch Immediate value and load into A";
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

		report "Fetch Instruction AND Abs";
		report "Running tests for CPU reading Memory location &02 0000000000000010"; 
		assert Memory_Address_Low_Test = "00000010"	report "Test 1: Memory_Address_Low_Test should equal 00000010" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Step 1 of AND Abs: Load Acc into Temp ALU Reg";
		report "Nothing to test on step 1"; 

		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Step 2 of AND Abs: Load MAR High from mem location &03";
		report "Running tests for CPU reading Memory location &03 0000000000000011"; 
		assert Memory_Address_Low_Test = "00000011"	report "Test 1: Memory_Address_Low_Test should equal 00000011" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Step 3 of AND Abs: Load MAR Low from mem location &04";
		report "Running tests for CPU reading Memory location &04 0000000000000100"; 
		assert Memory_Address_Low_Test = "00000100"	report "Test 1: Memory_Address_Low_Test should equal 00000100" severity error;
		assert Memory_Address_High_Test = "00000000" report "Test 2: Memory_Address_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Step 4 of AND Abs: ALU Operation";
		report "Nothing to test on step 4"; 

		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;

		wait;

	end process stimulus_proc;

	-- Simulate memory response
    	process
    	begin
        	wait for 1 ns;  -- Wait for a small time to simulate memory access time
        
		-- LDA # 53 (load accumulator with first operand of AND operation)
        	if Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000000" then
            		Memory_Data_In_Test <= "00010001"; -- LDA #
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000001" then
			Memory_Data_In_Test <= "00110101"; -- #35
		-- now give AND instruction with value of second operand
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000010" then
			Memory_Data_In_Test <= "10001000"; -- AND &
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000"  and Memory_Address_Low_Test = "00000001" then
			Memory_Data_In_Test <= "00000001"; -- High byte of Hex Value &0100
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000010" then
			Memory_Data_In_Test <= "00000000"; -- Low byte of Hex Value &0100
		-- then simulate responses from memory location &0100. (use LDA Abs as example!)
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000001" and Memory_Address_Low_Test = "00000000" then
			Memory_Data_In_Test <= "00110110"; -- value is hex 36
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


