

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
	
        	wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';
		wait for 10 ns;
		Clock_Test	<= '1';
		wait for 10 ns;
		Clock_Test	<= '0';

		wait;
	end process stimulus_proc;

end architecture Behavioral;