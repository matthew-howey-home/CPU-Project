
-- TestBench for D Latch

library ieee;
use ieee.std_logic_1164.all;

entity D_Latch_Test is
end entity D_Latch_Test;

architecture behavior of D_Latch_Test is
    -- Component declaration for the D Latch
    component D_Latch is
        port (
            Data_Input		: in std_logic;
            Input_Enable	: in std_logic;
            Output		: out std_logic
        );
    end component D_Latch;

    -- Signal declarations
    signal Data_Input_Test	: std_logic;
    signal Input_Enable_Test	: std_logic;
    signal Output_Test		: std_logic;

begin
    -- Instantiate the D Latch
    UUT: D_Latch port map (
        Data_Input		=> Data_Input_Test,
        Input_Enable		=> Input_Enable_Test,
        Output			=> Output_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	-- Initialise Quiescent state (Enable switched off)
 	Input_Enable_Test	<= '0';

        wait for 10 ns;
        -- ****** 1: Test Setting Latch, so Q output is 1, Q_Complement is 0

	-- Set Data to '1'
	Data_Input_Test	<= '1';
        wait for 10 ns;

	-- Enable
	Input_Enable_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Enable switched off)
	Input_Enable_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	Data_Input_Test 	<= 'Z';


	report "Test Setting Latch";
        assert Output_Test			= '1'	report "Error: Output_Test should be '1'." severity error;

        -- ****** 2: Test Resetting Latch, so Q output is 0, Q_Complement is 1

	-- Set Data to '1'
	Data_Input_Test	<= '0';
        wait for 10 ns;

	-- Enable
	Input_Enable_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Enable switched off)
	Input_Enable_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	Data_Input_Test 	<= 'Z';


	report "Test Setting Latch";
        assert Output_Test			= '0'	report "Error: Output_Test should be '0'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;
