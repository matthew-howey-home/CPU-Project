
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SUB_Component_Test is
end entity SUB_Component_Test;

architecture Behavioral of SUB_Component_Test is
    -- Component declaration for the SUB_Component module
    component SUB_Component
        port (
            input_1	: in  std_logic_vector(7 downto 0);
            input_2	: in  std_logic_vector(7 downto 0);
	    borrow_in	: in std_logic;

            output	: out std_logic_vector(7 downto 0);  -- Output
    	    borrow_out	: out std_logic  -- Borrow output
        );
    end component SUB_Component;

    -- Signal declarations
    signal input_1_test		: std_logic_vector(7 downto 0);
    signal input_2_test		: std_logic_vector(7 downto 0);
    signal output_test		: std_logic_vector(7 downto 0);
    signal borrow_in_test	: std_logic;
    signal borrow_out_test	: std_logic;

begin
    -- Instantiate the AND_Component module
    UUT: SUB_Component
        port map (
            input_1	=> input_1_test,
            input_2	=> input_2_test,
	    borrow_in	=> borrow_in_test,
            output	=> output_test,
            borrow_out	=> borrow_out_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for SUB Component";

        -- Test case 1
        input_1_test	<= "11111111";
        input_2_test	<= "11111111";
	borrow_in_test	<= '0';
        wait for 10 ns;

	report "Running Test case 1";
	assert output_test = "00000000"		report "Test 1: output_test should equal 00000000" severity error;
	assert borrow_out_test = '0'		report "Test 1: borrow_out_test should equal 0" severity error;

	-- Test case 2
        input_1_test	<= "11111111";
        input_2_test	<= "00000000";
	borrow_in_test	<= '1';
        wait for 10 ns;

	report "Running Test case 2";
	assert output_test = "11111110"		report "Test 2: output_test should equal 11111110" severity error;
	assert borrow_out_test = '0'		report "Test 2: borrow_out_test should equal 0" severity error;

	-- Test case 3
        input_1_test	<= "00000000";
        input_2_test	<= "00000001";
	borrow_in_test	<= '0';
        wait for 10 ns;

	report "Running Test case 3";
	assert output_test = "11111111"		report "Test 3: output_test should equal 11111111" severity error;
	assert borrow_out_test = '1'		report "Test 3: borrow_out_test should equal 1" severity error;

	-- Test case 4
        input_1_test	<= "01110001";
        input_2_test	<= "01011000";
	borrow_in_test	<= '1';
        wait for 10 ns;

	report "Running Test case 4";
	assert output_test = "00011000"		report "Test 4: output_test should equal 00011000" severity error;
	assert borrow_out_test = '0'		report "Test 4: borrow_out_test should equal 0" severity error;

	-- Test case 5
        input_1_test	<= "00001100";
        input_2_test	<= "11001001";
	borrow_in_test	<= '0';
        wait for 10 ns;

	report "Running Test case 5";
	assert output_test = "01000011"		report "Test 5: output_test should equal 01000011" severity error;
	assert borrow_out_test = '1'		report "Test 5: borrow_out_test should equal 1" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
