
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Two_to_One_Byte_Mux_Test is
end entity Two_to_One_Byte_Mux_Test;

architecture Behavioral of Two_to_One_Byte_Mux_Test is
    -- Component declaration for the Two_to_One_Byte_Mux module
    component Two_to_One_Byte_Mux
        port (
            	input_1		: in std_logic_vector(7 downto 0);
		input_2		: in std_logic_vector(7 downto 0);
		selector	: in std_logic;
	
		output		: out std_logic_vector(7 downto 0)
        );
    end component Two_to_One_Byte_Mux;



    -- Signal declarations
    signal input_1_test		: std_logic_vector(7 downto 0);
    signal input_2_test		: std_logic_vector(7 downto 0);
    signal selector_test	: std_logic;
    
    signal output_test		: std_logic_vector(7 downto 0);
   
begin
    -- Instantiate the Two_to_One_Byte_Mux module
    UUT: Two_to_One_Byte_Mux
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
	input_1_test	<= "01011010";
	input_2_test	<= "11001100";

	wait for 10 ns;

	report "Running Test case 1, selecting input 1";
	assert output_test = "01011010"	report "Test 1: output_test should equal 01011010" severity error;

	-- Selector is 1, so select input_2
	selector_test	<= '1';
	input_1_test	<= "01011010";
	input_2_test	<= "11001100";

	wait for 10 ns;

	report "Running Test case 2, selecting input 2";
	assert output_test = "11001100"	report "Test 2: output_test should equal 11001100" severity error;

	-- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;