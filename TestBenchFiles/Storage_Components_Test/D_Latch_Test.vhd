
-- TestBench for SR Latch

library ieee;
use ieee.std_logic_1164.all;

entity D_Latch_Test is
end entity D_Latch_Test;

architecture behavior of D_Latch_Test is
    -- Component declaration for the D Latch
    component D_Latch is
        port (
            D			: in std_logic;        -- Data
            E			: in std_logic;        -- Enable input
            Q			: out std_logic;       -- Output Q
            Q_Complement	: out std_logic        -- Output Q complement
        );
    end component D_Latch;

    -- Signal declarations
    signal D_Test		: std_logic;
    signal E_Test		: std_logic;
    signal Q_Test		: std_logic;
    signal Q_Complement_Test	: std_logic;

begin
    -- Instantiate the SR Latch
    UUT: D_Latch port map (
        D		=> D_Test,
        E		=> E_Test,
        Q		=> Q_Test,
        Q_Complement	=> Q_Complement_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	-- Initialise Quiescent state (Enable switched off)
 	E_Test	<= '0';

        wait for 10 ns;
        -- ****** 1: Test Setting Latch, so Q output is 1, Q_Complement is 0

	-- Set Data to '1'
	D_Test	<= '1';
        wait for 10 ns;

	-- Enable
	E_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Enable switched off)
	E_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	D_Test 	<= 'Z';


	report "Test Setting Latch";
        assert Q_Test			= '1'	report "Error: Q_Test should be '1'." severity error;
        assert Q_Complement_Test	= '0'	report "Error: Q_Complement_Test should be '0'." severity error;

        -- ****** 2: Test Resetting Latch, so Q output is 0, Q_Complement is 1

	-- Set Data to '1'
	D_Test	<= '0';
        wait for 10 ns;

	-- Enable
	E_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Enable switched off)
	E_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	D_Test 	<= 'Z';


	report "Test Setting Latch";
        assert Q_Test			= '0'	report "Error: Q_Test should be '0'." severity error;
        assert Q_Complement_Test	= '1'	report "Error: Q_Complement_Test should be '1'." severity error;



        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;
