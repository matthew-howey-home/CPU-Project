
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Two_to_One_Mux_Test is
end entity Two_to_One_Mux_Test;

architecture Behavioral of Two_to_One_Mux_Test is
    -- Component declaration for the Two_to_One_Mux module
    component Two_to_One_Mux
        port (
            	input_1		: in std_logic;
		input_2		: in std_logic;
		selector	: in std_logic;
	
		output		: out std_logic
        );
    end component Two_to_One_Mux;



    -- Signal declarations
    signal input_1_test		: std_logic;
    signal input_2_test		: std_logic;
    signal selector_test	: std_logic;
    
    signal output_test		: std_logic;
   
begin
    -- Instantiate the Two_to_One_Mux module
    UUT: Two_to_One_Mux
        port map (
            input_1		=> input_1_test,
            input_2		=> input_2_test,
	    selector		=> selector_test,
            output		=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Two_to_One_Mux Component";

	-- Selector is 0, so select input_1
	selector_test	<= '0';
	input_1_test	<= '0';
	input_2_test	<= '1';

	wait for 10 ns;

	report "Running Test case 1, selecting input 1";
	assert output_test = '0'	report "Test 1: output_test should equal 0" severity error;

	-- Selector is 0, so select input_1
	selector_test	<= '0';
	input_1_test	<= '1';
	input_2_test	<= '0';

	wait for 10 ns;

	report "Running Test case 2, selecting input 1";
	assert output_test = '1'	report "Test 2: output_test should equal 1" severity error;

	-- Selector is 1, so select input_2
	selector_test	<= '1';
	input_1_test	<= '1';
	input_2_test	<= '0';

	wait for 10 ns;

	report "Running Test case 3, selecting input 2";
	assert output_test = '0'	report "Test 3: output_test should equal 0" severity error;

	-- Selector is 1, so select input_2
	selector_test	<= '1';
	input_1_test	<= '0';
	input_2_test	<= '1';

	wait for 10 ns;

	report "Running Test case 4, selecting input 2";
	assert output_test = '1'	report "Test 2: output_test should equal 1" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
