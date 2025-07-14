


-- Test of CPU Instruction 01000011 - STY &FFFF, Load the Memory Address 0xFFFF with value 160 from Y Register 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test_STY_Abs is
end entity CPU_Test_STY_Abs;


architecture Behavioral of CPU_Test_STY_Abs is
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
		Memory_Write_Enable	: out std_logic;
		Memory_Data_Out		: out std_logic_vector(7 downto 0);

		Y_Reg_External_Output	: out std_logic_vector(7 downto 0)		
        );
    end component CPU;

	-- Signal declarations
	signal Clock_Test			: std_logic;
	signal Reset_Test			: std_logic;
	signal Memory_Data_In_Test			: std_logic_vector(7 downto 0);
	signal Memory_Address_Low_Test		: std_logic_vector(7 downto 0);
	signal Memory_Address_High_Test		: std_logic_vector(7 downto 0);
	signal Memory_Read_Enable_Test		: std_logic;
	signal Memory_Write_Enable_Test		: std_logic;
	signal Memory_Data_Out_Test		: std_logic_vector(7 downto 0);
	signal Y_Reg_External_Output_Test	: std_logic_vector(7 downto 0);


begin
   -- Instantiate the three_bit_decoder module
    UUT: CPU
        port map (
            	Clock			=> Clock_Test,
		Slow_Clock		=> '1', -- always set to 1 for test purposes
		Reset			=> Reset_Test,
		Memory_Data_In		=> Memory_Data_In_Test,
		
		Memory_Address_Low		=> Memory_Address_Low_Test,
		Memory_Address_High		=> Memory_Address_High_Test,
		Memory_Read_Enable 	=> Memory_Read_Enable_Test,
		Memory_Write_Enable	=> Memory_Write_Enable_Test,
		Memory_Data_Out		=> Memory_Data_Out_Test,
		Y_Reg_External_Output 	=> Y_Reg_External_Output_Test
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

		-- Initiate Accumulator by running instruction #160
		report "Step 1: Fetch Instruction - LDY #160";
		Clock_Test	<= '1';
		wait for 10 ns;
		assert Memory_Data_In_Test = "00010011" report "Memory_Data_In_Test should equal 00010011 (LDY #)" severity error;
		Clock_Test	<= '0';
		wait for 10 ns;
		
		report "Step One of Load Immediate to Register, Load Y Register with Value, and Increment PC";
		Clock_Test	<= '1';
		wait for 10 ns;
		assert Memory_Data_In_Test = "10100000" report "Memory_Data_In_Test should equal 10100000 (#160)" severity error;
		Clock_Test	<= '0';
		wait for 10 ns;

		-- Now fetch and run STX &2836, which is the instruction under test
		report "Step 1: Fetch Instruction 01000011 - STY &FFFF";
		Clock_Test	<= '1';
		wait for 10 ns;
		assert Y_Reg_External_Output_Test = "10100000" report "Test from previous step: Y_Reg_External_Output_Test should equal 10100000 (#160)" severity error;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "STY Absolute Step One - Load MAR (High) with hex FF";
		Clock_Test	<= '1';
		wait for 10 ns;
		assert Memory_Data_In_Test = "11111111" report "Memory_Data_In_Test should equal 11111111 (hex FF)" severity error;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "STX Absolute Step Two - Load MAR (Low) with hex FF";
		Clock_Test	<= '1';
		wait for 10 ns;
		assert Memory_Data_In_Test = "11111111" report "Memory_Data_In_Test should equal 11111111 (hex FF)" severity error;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "STX Absolute Step Three - Load Y Reg to Memory Address &581A";
		Clock_Test	<= '1';
		wait for 10 ns;
		report "Running tests for Load A Reg #207 to Memory Address &581A";
		assert Memory_Data_Out_Test = "10100000" report "Test: Memory_Data_Out_Test should equal 10100000 (#160)" severity error;
		assert Memory_Write_Enable_Test = '1' report "Test: Memory_Write_Enable_Test should equal 1" severity error;
		assert Memory_Address_High_Test = "11111111" report "Test: Memory_Address_High_Test should equal 11111111 (hex FF)" severity error;
		assert Memory_Address_Low_Test = "11111111" report "Test: Memory_Address_Low_Test should equal 11111111 (hex FF)" severity error;

		wait;
	end process stimulus_proc;


	-- Simulate memory response
    	process
    	begin
        	wait for 1 ns;  -- Wait for a small time to simulate memory access time
        	
		-- Memory Responses for LDY #160
        	if Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000000" and Memory_Address_High_Test = "00000000" then
            		Memory_Data_In_Test <= "00010011"; -- LDY #
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000"  and Memory_Address_Low_Test = "00000001" then
			Memory_Data_In_Test <= "10100000"; -- #160
		-- Memory Responses for STY &FFFF
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000010" then
			Memory_Data_In_Test <= "01000011"; -- STY &
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000011" then
			Memory_Data_In_Test <= "11111111"; -- hex FF
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_High_Test = "00000000" and Memory_Address_Low_Test = "00000100" then
			Memory_Data_In_Test <= "11111111"; -- hex FF
		-- When no memory response required / matched
        	else
            		Memory_Data_In_Test <= "ZZZZZZZZ";  -- Default data value when the condition is not met
        	end if;
		--sim_time <= sim_time + 1 ns;

    		-- Stop process after 300 ns
    		if now = 300 ns then
        		report "Simulation completed successfully after 300 ns" severity note;
        		wait;
    		end if;
    end process;

end architecture Behavioral;