-- TestBench for SR Latch

library ieee;
use ieee.std_logic_1164.all;

entity TB_SR_Latch is
end entity TB_SR_Latch;

architecture behavior of TB_SR_Latch is
    -- Component declaration for the SR Latch
    component SR_Latch is
        port (
            S : in std_logic;         -- Set input (active low)
            R : in std_logic;         -- Reset input (active low)
            Q : out std_logic;        -- Output Q
            QN : out std_logic        -- Output Q complement
        );
    end component SR_Latch;

    -- Signal declarations
    signal S_tb : std_logic;
    signal R_tb : std_logic;
    signal Q_tb : std_logic;
    signal QN_tb : std_logic;

begin
    -- Instantiate the SR Latch
    UUT: SR_Latch port map (
        S => S_tb,
        R => R_tb,
        Q => Q_tb,
        QN => QN_tb
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- ****** 1: Test Setting Latch, so Q output is 1, QN is 0

	-- Quiescent state (1 is quiescent as they are active low)
 	S_tb <= '1';
        R_tb <= '1';
        wait for 10 ns;
        
	-- Set to 'on' (S = '0' means set as it is active low
	S_tb <= '0';
        R_tb <= '1';
        wait for 10 ns;

	-- Quiescent state (1 is quiescent as they are active low)
	S_tb <= '1';
        R_tb <= '1';
        wait for 10 ns;

	report "Testing Setting Latch";
        assert Q_tb = '1' report "Error: Q_tb should be '1'." severity error;
        assert QN_tb = '0' report "Error: QN_tb should be '0'." severity error;


	-- ****** 12: Test Resetting Latch, so Q output is 0, QN is 1.

	-- Quiescent state (1 is quiescent as they are active low)
 	S_tb <= '1';
        R_tb <= '1';
        wait for 10 ns;
        
	-- Set to 'on' (S = '0' means set as it is active low
	S_tb <= '1';
        R_tb <= '0';
        wait for 10 ns;

	-- Quiescent state (1 is quiescent as they are active low)
	S_tb <= '1';
        R_tb <= '1';
        wait for 10 ns;

	report "Testing Resetting Latch";
        assert Q_tb = '0' report "Error: Q_tb should be '0'." severity error;
        assert QN_tb = '1' report "Error: QN_tb should be '1'." severity error;



          -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;

