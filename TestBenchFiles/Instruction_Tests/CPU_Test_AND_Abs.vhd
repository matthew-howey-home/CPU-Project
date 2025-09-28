
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

	end process stimulus_proc;

-- Simulate memory response
    	process
    	begin
        	wait for 1 ns;  -- Wait for a small time to simulate memory access time
        
		-- LDA # 53 (load accumulator with first operand of AND operation)
        	if Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000000" and Memory_Address_High_Test = "00000000" then
            		Memory_Data_In_Test <= "00010001"; -- LDA #
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000001" and Memory_Address_High_Test = "00000000" then
			Memory_Data_In_Test <= "00110101"; -- #53
		-- now give AND instruction with value of second operand
		elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000010" and Memory_Address_High_Test = "00000000" then
			Memory_Data_In_Test <= "10001000"; -- AND
		-- TODO put read memory address in next two locations
		-- then simulate responses from those to memory locations. (use LDA Abs as example!)
		-- elsif Memory_Read_Enable_Test = '1' and Memory_Address_Low_Test = "00000011" and Memory_Address_High_Test = "00000000" then
		-- 	Memory_Data_In_Test <= "01000111"; -- & 47
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


