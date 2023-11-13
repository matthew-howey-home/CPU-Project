

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Four_to_One_Byte_Mux_Test is
end entity Four_to_One_Byte_Mux_Test;

architecture Behavioral of Four_to_One_Byte_Mux_Test is
    -- Component declaration for the Four_to_One_Byte_Mux module
    component Four_to_One_Byte_Mux
        port (
            	input_0		: in std_logic_vector(7 downto 0);
		input_1		: in std_logic_vector(7 downto 0);
		input_2		: in std_logic_vector(7 downto 0);
		input_3		: in std_logic_vector(7 downto 0);
		
		selector	: in std_logic_vector(1 downto 0);
	
		output		: out std_logic_vector(7 downto 0)
        );
    end component Four_to_One_Byte_Mux;


    -- Signal declarations
    signal input_0_test		: std_logic_vector(7 downto 0);
    signal input_1_test		: std_logic_vector(7 downto 0);
    signal input_2_test		: std_logic_vector(7 downto 0);
    signal input_3_test		: std_logic_vector(7 downto 0);
    signal selector_test	: std_logic_vector(1 downto 0);
    
    signal output_test		: std_logic_vector(7 downto 0);
   
begin
    -- Instantiate the Four_to_One_Byte_Mux module
    UUT: Four_to_One_Byte_Mux
        port map (
            input_0		=> input_0_test,
            input_1		=> input_1_test,
	    input_2		=> input_2_test,
            input_3		=> input_3_test,
	    selector		=> selector_test,
            output		=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Four_to_One_Bit_Mux_Test Component";

	input_0_test	<= "01010101";
	input_1_test	<= "10101010";
	input_2_test	<= "00000000";
	input_3_test	<= "11111111";

	-- Selector is 00, so select input_0
	selector_test	<= "00";

	wait for 10 ns;

	report "Running Test case 1, selecting input 0";
	assert output_test = "01010101"	report "Test 1: output_test should equal 01010101" severity error;

	-- Selector is 01, so select input_1
	selector_test	<= "01";

	wait for 10 ns;

	report "Running Test case 2, selecting input 1";
	assert output_test = "10101010"	report "Test 2: output_test should equal 10101010" severity error;

	-- Selector is 10, so select input_2
	selector_test	<= "10";

	wait for 10 ns;

	report "Running Test case 3, selecting input 2";
	assert output_test = "00000000"	report "Test 3: output_test should equal 00000000" severity error;

	-- Selector is 11, so select input_3
	selector_test	<= "11";

	wait for 10 ns;

	report "Running Test case 4, selecting input 3";
	assert output_test = "11111111"	report "Test 4: output_test should equal 11111111" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;