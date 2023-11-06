

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test is
end entity CPU_Test;


architecture Behavioral of CPU_Test is
    -- Component declaration for the CPU module
    component CPU
        port (
		Clock			: in std_logic;
		Reset			: in std_logic
        );
    end component CPU;

	-- Signal declarations
	signal Clock_Test		: std_logic;
	signal Reset_Test		: std_logic;
begin

   -- Instantiate the three_bit_decoder module
    UUT: CPU
        port map (
            	Clock		=> Clock_Test,
		Reset		=> Reset_Test
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
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';

		report "Switching off Reset";
		report "Step 1: Load MAR low from PC low";
		-- switch off reset to release FSM and allow cycles to start
		Reset_Test	<= '0';
		wait for 10 ns;
		-- continue through CPU cycles
		
		report "Step 2: Load MAR High from PC High";
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;

		report "Step 3:  Load MAR into Memory Out and Set Memory Read Enable";		
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';

		wait;
	end process stimulus_proc;

end architecture Behavioral;