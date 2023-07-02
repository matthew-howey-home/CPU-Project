library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ADD_Component_Test is
end entity ADD_Component_Test;

architecture Behavioral of ADD_Component_Test is
    -- Component declaration for the AND_Component module
    component ADD_Component
        port (
	    input_1	: in std_logic_vector(7 downto 0);
            input_2     : in std_logic_vector(7 downto 0);
	    carry_in	: in std_logic;

            output      : out std_logic_vector(7 downto 0);
	    carry_out	: out std_logic
        );
    end component ADD_Component;

    -- Internal Signals of Add Component Test
    signal carry_in_test	: std_logic;
    signal input_1_test  	: std_logic_vector(7 downto 0);
    signal input_2_test    	: std_logic_vector(7 downto 0);

    signal output_test		: std_logic_vector(7 downto 0);
    signal carry_out_test	: std_logic;

begin
    -- Instantiate the ADD_Component module
    UUT: ADD_Component
        port map (
	    carry_in		=> carry_in_test,
 	    input_1     	=> input_1_test,
            input_2       	=> input_2_test,
            output       	=> output_test,
            carry_out    	=> carry_out_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for ADD Component";

        -- Test case 1
	carry_in_test 	<= '0';
        input_1_test 	<= "00101011";
        input_2_test 	<= "11011010";

        wait for 10 ns;
	
	report "Running Test case 1";
	assert output_test 	= 	"00000101" 	report "Test 1: output_test should equal 00000101" severity error;
	assert carry_out_test 	= 	'1' 		report "carry_out_test should equal 1" severity error;

        -- Test case 2
	carry_in_test	<= '1';
        input_1_test 	<= "10011101";
        input_2_test 	<= "01100101";

        wait for 10 ns;

	report "Running Test case 2";
	assert output_test 	= 	"00000011" 	report "Test 2: output_test should equal 00000011" severity error;
	assert carry_out_test 	= 	'1' 		report "carry_out_test should equal 1" severity error;

        -- Test case 3
	carry_in_test	<=	'0';
        input_1_test 	<= 	"11110000";
        input_2_test 	<=	"00001111";

        wait for 10 ns;

	report "Running Test case 3";
	assert output_test 	= 	"11111111" 	report "Test 3: output_test should equal 11111111" severity error;
	assert carry_out_test 	= 	'0' 		report "carry_out_test should equal 0" severity error;


	-- Test case 4
	carry_in_test 	<= 	'1';
        input_1_test 	<= 	"01010101";
        input_2_test 	<= 	"10101010";

        wait for 10 ns;

	report "Running Test case 4";
	assert output_test	=	"00000000" 	report "Test 4: output_test should equal 00000000" severity error;
	assert carry_out_test 	= 	'1' 		report "carry_out_test should equal 1" severity error;


	-- Test case 5
	carry_in_test	<= 	'0';
        input_1_test	<= 	"11111111";
        input_2_test	<=	"11111111";

        wait for 10 ns;

	report "Running Test case 5";
	assert output_test	=	"11111110" 	report "Test 5: output_test should equal 11111110" severity error;
	assert carry_out_test	=	'1' 		report "carry_out_test should equal 1" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

