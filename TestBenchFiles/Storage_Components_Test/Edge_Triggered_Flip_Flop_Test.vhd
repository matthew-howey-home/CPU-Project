

-- TestBench for Edge Triggered Flip Flop

library ieee;
use ieee.std_logic_1164.all;

entity Edge_Triggered_Flip_Flop_Test is
end entity Edge_Triggered_Flip_Flop_Test;

architecture behavior of Edge_Triggered_Flip_Flop_Test is
    -- Component declaration for the Edge_Triggered_Flip_Flop
    component Edge_Triggered_Flip_Flop is
        port (
        	D		: in std_logic;        	-- Data input
        	E		: in std_logic;        	-- Enable input
		clk		: in std_logic;		-- Clock input
        	Q		: out std_logic       	-- Output Q
    	);
    end component Edge_Triggered_Flip_Flop;

    -- Signal declarations
    signal D_Test		: std_logic;
    signal E_Test		: std_logic;
    signal clk_Test		: std_logic;
    signal Q_Test		: std_logic;

begin
    -- Instantiate the Edge_Triggered_Flip_Flop
    UUT: Edge_Triggered_Flip_Flop port map (
        D		=> D_Test,
        E		=> E_Test,
	clk		=> clk_Test,
        Q		=> Q_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	D_Test		<= '1';
	E_Test		<= '1';
	clk_Test	<= '0';

	wait for 10 ns;

	-- Output should now be change to 1 on rising edge
	clk_Test	<= '1';

	wait for 10 ns;

	clk_Test	<= '0';
	
	-- now set Data to 0 but Enable is Off, it should maintain output of 1
	D_Test		<= '0';
	E_Test		<= '0';

	wait for 10 ns;
	
	clk_Test	<= '1';


	-- report "Test Setting Latch";
        -- assert Q_Test			= '1'	report "Error: Q_Test should be '1'." severity error;
        -- assert Q_Complement_Test	= '0'	report "Error: Q_Complement_Test should be '0'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;