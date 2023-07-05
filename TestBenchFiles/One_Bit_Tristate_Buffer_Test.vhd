
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity One_Bit_Tristate_Buffer_Test is
end entity One_Bit_Tristate_Buffer_Test;

architecture Behavioral of One_Bit_Tristate_Buffer_Test is
    -- Component declaration for the One_Bit_Tristate_Buffer module
    component One_Bit_Tristate_Buffer
        port (
            input       : in  std_logic;
	    enable      : in std_logic;
            output       : out std_logic
        );
    end component One_Bit_Tristate_Buffer;

    -- Signal declarations
    signal input_test_buffer1   : std_logic;
    signal enable_test_buffer1 : std_logic;
    
    signal input_test_buffer2   : std_logic;
    signal enable_test_buffer2 : std_logic;

    signal output_test   : std_logic;
   
begin
    -- Instantiate the Tristate_Buffer module
    UUT1: One_Bit_Tristate_Buffer
        port map (
            input	=> input_test_buffer1,
            enable	=> enable_test_buffer1,
            output	=> output_test
        );

    UUT2: One_Bit_Tristate_Buffer
        port map (
            input	=> input_test_buffer2,
            enable	=> enable_test_buffer2,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for One Bit Tristate Buffer Component";

	-- Set UUT2 to not enabled so we can test UUT1 in isolation
	-- note enable is active low, so 1 means not enabled
	enable_test_buffer2 <= '1';

	-- Test two tri state buffers at the same time

	-- Test case 1 (For UUT1 and UUT2)

	-- Set UUT1 to enable
	input_test_buffer1	<= '1';
        enable_test_buffer1	<= '0';

	-- Set UUT2 to not enabled
	input_test_buffer2	<= '0';
        enable_test_buffer2	<= '1';
        wait for 10 ns;

	-- Only UUT1 output should be visible
	report "Running Test case 1";
	assert output_test = '1'	report "Test 1: output_test should equal 1" severity error;

	-- Test case 2 (For UUT1 and UUT2)

	-- Set UUT1 to not enabled
	input_test_buffer1	<= '1';
        enable_test_buffer1	<= '1';

	-- Set UUT2 to enabled
	input_test_buffer2	<= '0';
        enable_test_buffer2	<= '0';
        wait for 10 ns;

	-- Only UUT2 output should be visible
	report "Running Test case 2";
	assert output_test = '0'	report "Test 2: output_test should equal 0" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;