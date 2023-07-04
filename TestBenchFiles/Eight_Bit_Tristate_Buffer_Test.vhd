
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Eight_Bit_Tristate_Buffer_Test is
end entity Eight_Bit_Tristate_Buffer_Test;

architecture Behavioral of Eight_Bit_Tristate_Buffer_Test is
    -- Component declaration for the Eight_Bit_Tristate_Buffer module
    component Eight_Bit_Tristate_Buffer
        port (
            input       : in  std_logic_vector(7 downto 0);
	    enable      : in std_logic;
            output	: out std_logic_vector(7 downto 0)
        );
    end component Eight_Bit_Tristate_Buffer;

    -- Signal declarations
    signal input_1_test		: std_logic_vector(7 downto 0);
    signal enable_1_test	: std_logic;
    
    signal input_2_test		: std_logic_vector(7 downto 0);
    signal enable_2_test	: std_logic;

    signal output_test		: std_logic_vector(7 downto 0);
   
begin
    -- Instantiate the Eight_Bit_Tristate_Buffer modules
    UUT1: Eight_Bit_Tristate_Buffer
        port map (
            input	=> input_1_test,
            enable	=> enable_1_test,
            output    	=> output_test
        );

    UUT2: Eight_Bit_Tristate_Buffer
        port map (
            input	=> input_2_test,
            enable	=> enable_2_test,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Eight Bit Tristate Buffer Component";

	-- Set UUT2 to not enabled so we can test UUT1 in isolation
	-- note enable is active low, so 1 means not enabled
	enable_2_test	<= '1';


	-- Test case 1 (for UUT1 only)
        input_1_test	<= "00101011";
	-- enable is active low, so 0 means enable
        enable_1_test	<= '0';
        wait for 10 ns;
	
	report "Running Test case 1";
	assert output_test = "00101011"		report "Test 1: output_test should equal 00101011" severity error;

	-- Test case 2 (for UUT2 only)
        input_1_test	<= "00101011";
	-- enable is active low, so 1 means do not enable
        enable_1_test	<= '1';
        wait for 10 ns;
	
	report "Running Test case 2";
	assert output_test = "ZZZZZZZZ" 	report "Test 2: output_test should equal ZZZZZZZZ" severity error;

	
	-- Test two tri state buffers at the same time

	-- Test case 3 (For UUT1 and UUT2)

	-- Set UUT1 to enable
	input_1_test	<= "11110000";
        enable_1_test	<= '0';

	-- Set UUT2 to not enabled
	input_2_test	<= "00001111";
        enable_2_test	<= '1';
        wait for 10 ns;

	-- Only UUT1 output should be visible
	report "Running Test case 3";
	assert output_test = "11110000"		report "Test 3: output_test should equal 11110000" severity error;

	-- Test case 4 (For UUT1 and UUT2)

	-- Set UUT1 to not enabled
	input_1_test	<= "11110000";
        enable_1_test	<= '1';

	-- Set UUT2 to enabled
	input_2_test	<= "00001111";
        enable_2_test	<= '0';
        wait for 10 ns;

	-- Only UUT2 output should be visible
	report "Running Test case 4";
	assert output_test = "00001111"		report "Test 4: output_test should equal 00001111" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
