

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity One_to_Two_Byte_Demux_Test is
end entity One_to_Two_Byte_Demux_Test;

architecture Behavioral of One_to_Two_Byte_Demux_Test is
    -- Component declaration for the One_to_Two_Byte_Demux module
    component One_to_Two_Byte_Demux
        port (
            	input		: in std_logic_vector(7 downto 0);
		selector	: in std_logic;
	
		output_0	: out std_logic_vector(7 downto 0);
		output_1	: out std_logic_vector(7 downto 0)
        );
    end component One_to_Two_Byte_Demux;



    -- Signal declarations
    signal input_test		: std_logic_vector(7 downto 0);
    signal selector_test	: std_logic;
    
    signal output_0_test	: std_logic_vector(7 downto 0);
    signal output_1_test	: std_logic_vector(7 downto 0);
   
begin
    -- Instantiate the One_to_Two_Byte_Demux module
    UUT: One_to_Two_Byte_Demux
        port map (
            input		=> input_test,
	    selector		=> selector_test,

            output_0		=> output_0_test,
	    output_1		=> output_1_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Two_to_One_Mux Component";

	-- Selector is 0, so connect input to output_0
	input_test	<= "01011010";
	selector_test	<= '0';

	wait for 10 ns;

	report "Running Test case 1, connecting input to output_0";
	assert output_0_test = "01011010"	report "Test 1: output_0_test should equal 01011010" severity error;
	assert output_1_test = "ZZZZZZZZ"	report "Test 1: output_1_test should equal ZZZZZZZZ" severity error;
 
	-- Selector is 1, so connect input to output_1
	input_test	<= "01011010";
	selector_test	<= '1';

	wait for 10 ns;

	report "Running Test case 2, connecting input to output_1";
	assert output_0_test = "ZZZZZZZZ"	report "Test 1: output_0_test should equal ZZZZZZZZ" severity error;
	assert output_1_test = "01011010"	report "Test 1: output_1_test should equal 01011010" severity error;

	-- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;