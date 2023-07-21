

-- TestBench for Edge Triggered Flip Flop

library ieee;
use ieee.std_logic_1164.all;

entity Edge_Triggered_Flip_Flop_Test is
end entity Edge_Triggered_Flip_Flop_Test;

architecture behavior of Edge_Triggered_Flip_Flop_Test is
    -- Component declaration for the Edge_Triggered_Flip_Flop
    component Edge_Triggered_Flip_Flop is
        port (
        	Data_Input	: in std_logic;
        	Input_Enable	: in std_logic;
		Clock		: in std_logic;
        	Output		: out std_logic
    	);
    end component Edge_Triggered_Flip_Flop;

    -- Signal declarations
    signal Data_Input_Test	: std_logic;
    signal Input_Enable_Test	: std_logic;
    signal Clock_Test		: std_logic;
    signal Output_Test		: std_logic;

begin
    -- Instantiate the Edge_Triggered_Flip_Flop
    UUT: Edge_Triggered_Flip_Flop port map (
        Data_Input	=> Data_Input_Test,
        Input_Enable	=> Input_Enable_Test,
	Clock		=> Clock_Test,
        Output		=> Output_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	Data_Input_Test		<= '1';
	Input_Enable_Test	<= '1';
	Clock_Test		<= '0';

	wait for 10 ns;

	-- Output should now be change to 1 on rising edge
	Clock_Test	<= '1';

	wait for 10 ns;

	Clock_Test	<= '0';
	
	-- now set Data to 0 but Enable is Off, it should maintain output of 1
	Data_Input_Test		<= '0';
	Input_Enable_Test	<= '0';

	wait for 10 ns;
	
	Clock_Test		<= '1';


	-- report "Test Setting Latch";
        -- assert Q_Test			= '1'	report "Error: Q_Test should be '1'." severity error;
        -- assert Q_Complement_Test	= '0'	report "Error: Q_Complement_Test should be '0'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;