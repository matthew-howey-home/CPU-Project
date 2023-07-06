
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ALU_Test is
end entity ALU_Test;

architecture Behavioral of ALU_Test is
    -- Component declaration for the AND_Component module
    component ALU
        port (
            	opcode 		: in  std_logic_vector(2 downto 0);
		input_1		: in  std_logic_vector(7 downto 0);
	        input_2		: in  std_logic_vector(7 downto 0);
		carry_in	: in std_logic;
		negative_in	: in std_logic;
	
	        output		: out std_logic_vector(7 downto 0);
		carry_out 	: out std_logic;
		negative_out	: out std_logic
        );
    end component ALU;

    	-- Signal declarations
    	signal opcode_test	: std_logic_vector(2 downto 0);

    	signal input_1_test	: std_logic_vector(7 downto 0);
    	signal input_2_test	: std_logic_vector(7 downto 0);
	signal carry_in_test    : std_logic;
    	signal negative_in_tb	: std_logic;
    	signal output_test	: std_logic_vector(7 downto 0);
    	signal carry_out_test	: std_logic;
    	signal negative_out_tb	: std_logic;

begin
    -- Instantiate the three_bit_decoder module
    UUT: ALU
        port map (
            	opcode		=> opcode_test,

		input_1		=> input_1_test,
		input_2		=> input_2_test,
		carry_in	=> carry_in_test,
		negative_in    	=> negative_in_tb,
		output		=> output_test,
		carry_out    	=> carry_out_test,
		negative_out    => negative_out_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for AND Component - opcode 000";

        opcode_test	<= "000";
	input_1_test	<= "11010110";
	input_2_test	<= "00110011";
        wait for 10 ns;

	assert output_test = "00010010"	report "Test 1: output_test should equal 00010010" severity error;
	assert carry_out_test = '0'	report "Test 1: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'	report "Test 1: negative_out should equal 0" severity error;

	report "Running Tests for OR Component - opcode 001";

        opcode_test	<= "001";
	input_1_test	<= "11010110";
	input_2_test	<= "00110011";
        wait for 10 ns;

	assert output_test = "11110111"	report "Test 1: output_test should equal 11110111" severity error;
	assert carry_out_test = '0'	report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'	report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for NOT Component - opcode 010";

        opcode_test	<= "010";
	input_1_test	<= "11010110";
        wait for 10 ns;

	assert output_test = "00101001" 	report "Test 1: output_test should equal 00101001" severity error;
	assert carry_out_test = '0'		report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'		report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for XOR Component - opcode 011";

        opcode_test	<= "011";
	input_1_test	<= "11010110";
	input_2_test	<= "00110011";
        wait for 10 ns;

	assert output_test = "11100101"		report "Test 1: output_test should equal 11100101" severity error;
	assert carry_out_test = '0'		report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'		report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for SHR Component - opcode 100";

        opcode_test	<= "100";
	input_1_test	<= "11010110";
        wait for 10 ns;

	assert output_test = "01101011"		report "Test 1: output_test should equal 01101011" severity error;
	assert carry_out_test = '0'		report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'		report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for SHL Component - opcode 101";

        opcode_test	<= "101";
	input_1_test	<= "11010110";
        wait for 10 ns;

	assert output_test = "10101100"		report "Test 1: output_test should equal 10101100" severity error;
	assert carry_out_test = '0'		report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '0'		report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for ADD Component - opcode 110";

        opcode_test	<= "110";
	input_1_test	<= "11010110";
	input_2_test	<= "00110011";
	carry_in_test	<= '1';
        wait for 10 ns;

	assert output_test = "00001010"		report "Test 1: output_test should equal 00001010" severity error;
	assert carry_out_test = '1'		report "Test 2: carry_out_test should equal 1" severity error;
	assert negative_out_tb = '0'		report "Test 3: negative_out should equal 0" severity error;

	report "Running Tests for SUB Component - opcode 111";

        opcode_test	<= "111";
	input_1_test	<= "00001100";
	input_2_test	<= "11001000";
	negative_in_tb	<= '1';
        wait for 10 ns;

	assert output_test = "01000011"		report "Test 1: output_test should equal 01000011" severity error;
	assert carry_out_test = '0'		report "Test 2: carry_out_test should equal 0" severity error;
	assert negative_out_tb = '1'		report "Test 3: negative_out should equal 1" severity error;


        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;