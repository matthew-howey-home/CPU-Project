
-- Test of CPU Instruction 00010001 - LDA # 53, Load the accumulator with absolute value 53.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test_LDA_Abs is
end entity CPU_Test_LDA_Abs;


architecture Behavioral of CPU_Test_LDA_Abs is
    -- Component declaration for the CPU module
    component CPU
        port (
		Clock			: in std_logic;
		Reset			: in std_logic;
		Memory_In		: in std_logic_vector(7 downto 0);

		Memory_Out_Low		: out std_logic_vector(7 downto 0);
		Memory_Out_High		: out std_logic_vector(7 downto 0);
		Memory_Read_Enable	: out std_logic;

		A_Reg_External_Output	: out std_logic_vector(7 downto 0)		
        );
    end component CPU;

	-- Signal declarations
	signal Clock_Test			: std_logic;
	signal Reset_Test			: std_logic;
	signal Memory_In_Test			: std_logic_vector(7 downto 0);
	signal Memory_Out_Low_Test		: std_logic_vector(7 downto 0);
	signal Memory_Out_High_Test		: std_logic_vector(7 downto 0);
	signal Memory_Read_Enable_Test		: std_logic;
	signal A_Reg_External_Output_Test	: std_logic_vector(7 downto 0);


begin
   -- Instantiate the three_bit_decoder module
    UUT: CPU
        port map (
            	Clock			=> Clock_Test,
		Reset			=> Reset_Test,
		Memory_In		=> Memory_In_Test,
		
		Memory_Out_Low		=> Memory_Out_Low_Test,
		Memory_Out_High		=> Memory_Out_High_Test,
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

		report "Step 1: Load MAR low from PC low";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;
		
		report "Step 2: Load MAR High from PC High";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step 3:  Load MAR into Memory Out and Set Memory Read Enable";		
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for CPU reading Memory location 0000000000000000";
		assert Memory_Out_Low_Test = "00000000"	report "Test 1: Memory_Out_Low_Test should equal 00000000" severity error;
		assert Memory_Out_High_Test = "00000000" report "Test 2: Memory_Out_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;
	
		report "Step 4:  Load Instruction from MDR";		
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step 5:  Increment PC";		
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Instruction is 0001xxxx Branch to Load Absolute Value to Register - FSM 00000111";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;
		
		report "Step One of Load Absolute Value to Register - Load MAR (low)";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step Two of Load Absolute Value to Register - Load MAR (high)";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step Three of Load Absolute Value to Register - Fetch Value from Memory";
		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for CPU reading Memory location 0000000000000001";
		assert Memory_Out_Low_Test = "00000001"	report "Test 1: Memory_Out_Low_Test should equal 00000001" severity error;
		assert Memory_Out_High_Test = "00000000" report "Test 2: Memory_Out_High_Test should equal 00000000" severity error;
		assert Memory_Read_Enable_Test = '1' report "Test 3: Memory_Read_Enable_Test should equal 1" severity error;

		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step Four of Load Absolute Value to Register - Load A Reg";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		Clock_Test	<= '1';
		wait for 10 ns;

		report "Running tests for Loading A Register with value 00110101 (#53)";
		assert A_Reg_External_Output_Test = "00110101"	report "Test: A_Reg_External_Output_Test should equal 00110101" severity error;

		wait;
	end process stimulus_proc;

	-- Simulate memory response
    	process
    	begin
        	wait for 1 ns;  -- Wait for a small time to simulate memory access time
        
        	if Memory_Read_Enable_Test = '1' and Memory_Out_Low_Test = "00000000" and Memory_Out_High_Test = "00000000" then
            		Memory_In_Test <= "00010001"; -- LDA #
		elsif Memory_Read_Enable_Test = '1' and Memory_Out_Low_Test = "00000001" and Memory_Out_High_Test = "00000000" then
			Memory_In_Test <= "00110101"; -- #53
        	else
            		Memory_In_Test <= "ZZZZZZZZ";  -- Default data value when the condition is not met
        	end if;
		--sim_time <= sim_time + 1 ns;

    		-- Stop process after 300 ns
    		if now = 300 ns then
        		report "Simulation completed successfully after 300 ns" severity note;
        		wait;
    		end if;
    end process;

end architecture Behavioral;