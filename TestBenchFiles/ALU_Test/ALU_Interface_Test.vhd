

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ALU_Interface_Test is
end entity ALU_Interface_Test;

architecture Behavioral of ALU_Interface_Test is
    -- Component declaration for the ALU_Interface module
    component ALU_Interface
        port (
            	opcode  				: in std_logic_vector(2 downto 0);
		input_1					: in std_logic_vector(7 downto 0);
        	input_2					: in std_logic_vector(7 downto 0);
		carry_in				: in std_logic;
		negative_in				: in std_logic;
		temp_input_register_input_enable	: in std_logic;
		Clock					: in std_logic;
		clear_carry_flag_control		: in std_logic;
		clear_negative_flag_control		: in std_logic;
		clear_zero_flag_control			: in std_logic;

        	output					: out std_logic_vector(7 downto 0);
		carry_out				: out std_logic;
		negative_out				: out std_logic
        );
    end component ALU_Interface;

	-- Signal declarations
    	signal opcode_test				: std_logic_vector(2 downto 0);

    	signal input_1_test				: std_logic_vector(7 downto 0);
    	signal input_2_test				: std_logic_vector(7 downto 0);
	signal carry_in_test    			: std_logic;
    	signal negative_in_test				: std_logic;
	signal temp_input_register_input_enable_test	: std_logic;
	signal Clock_Test				: std_logic;
	signal clear_carry_flag_control_test		: std_logic;
	signal clear_negative_flag_control_test		: std_logic;
	signal clear_zero_flag_control_test		: std_logic;

    	signal output_test		: std_logic_vector(7 downto 0);
    	signal carry_out_test		: std_logic;
    	signal negative_out_test	: std_logic;

begin

   -- Instantiate the ALU_Interface module
    UUT: ALU_Interface
        port map (
            	opcode					=> opcode_test,
		input_1					=> input_1_test,
		input_2					=> input_2_test,
		carry_in				=> carry_in_test,
		negative_in    				=> negative_in_test,
		temp_input_register_input_enable	=> temp_input_register_input_enable_test,
		Clock					=> Clock_Test,
		clear_carry_flag_control		=> clear_carry_flag_control_test,
		clear_negative_flag_control		=> clear_negative_flag_control_test,
		clear_zero_flag_control			=> clear_zero_flag_control_test,

        	output					=> output_test,
		carry_out				=> carry_out_test,
		negative_out				=> negative_out_test
        );


    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	Clock_Test <= '1';
	temp_input_register_input_enable_test <= '1';
	input_1_test <= "01011011";

	wait for 10 ns;

	Clock_Test <= '0';

	wait for 10 ns;

	Clock_Test <= '1';

	wait;

    end process stimulus_proc;

end architecture Behavioral;