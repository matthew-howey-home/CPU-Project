-- TestBench for SR Latch

library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch_Test is
end entity SR_Latch_Test;

architecture behavior of SR_Latch_Test is
    -- Component declaration for the SR Latch
    component SR_Latch is
        port (
            S			: in std_logic;        -- Set input (active low)
            R			: in std_logic;        -- Reset input (active low)
            Q			: out std_logic;       -- Output Q
            Q_Complement	: out std_logic        -- Output Q complement
        );
    end component SR_Latch;

    -- Signal declarations
    signal S_Test		: std_logic;
    signal R_Test		: std_logic;
    signal Q_Test		: std_logic;
    signal Q_Complement_Test	: std_logic;

begin
    -- Instantiate the SR Latch
    UUT: SR_Latch port map (
        S		=> S_Test,
        R		=> R_Test,
        Q		=> Q_Test,
        Q_Complement	=> Q_Complement_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	-- Initialise Quiescent state (1 is quiescent as they are active low)
 	S_Test	<= '1';
        R_Test	<= '1';

        wait for 10 ns;
        -- ****** 1: Test Setting Latch, so Q output is 1, Q_Complement is 0

	-- Set to 'on' (S = '0' means set as it is active low)
	S_Test	<= '0';
        R_Test	<= '1';
        wait for 10 ns;

	-- Return to quiescent state (1 is quiescent as they are active low)
	S_Test	<= '1';
        R_Test	<= '1';
        wait for 10 ns;

	report "Test Setting Latch";
        assert Q_Test			= '1'	report "Error: Q_Test should be '1'." severity error;
        assert Q_Complement_Test	= '0'	report "Error: Q_Complement_Test should be '0'." severity error;


	-- ****** 2: Test Resetting Latch, so Q output is 0, Q_Complement is 1.
        
	-- Reset to 'off' (R = '0' means Reset as it is active low)
	S_Test	<= '1';
        R_Test	<= '0';
        wait for 10 ns;

	-- Return to quiescent state (1 is quiescent as they are active low)
	S_Test	<= '1';
        R_Test	<= '1';
        wait for 10 ns;

	report "Test Resetting Latch";
        assert Q_Test			= '0'	report "Error: Q_Test should be '0'." severity error;
        assert Q_Complement_Test	= '1'	report "Error: Q_Complement_Test should be '1'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;

