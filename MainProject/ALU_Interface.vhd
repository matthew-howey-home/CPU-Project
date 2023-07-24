
library  ieee;
use ieee.std_logic_1164.all;

-- This Interface sits between the Buses and the ALU
-- It handles the temporary input and temporary output registers
-- And the condition flags 

entity  ALU_Interface is
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
	operation_enable			: in std_logic;
	Output_Enable				: in std_logic;

        output					: out std_logic_vector(7 downto 0);
	carry_flag_output			: out std_logic;
	negative_flag_output			: out std_logic
    );
end entity  ALU_Interface;

architecture Behavioral of ALU_Interface is
   signal temp_input_register_output		: std_logic_vector(7 downto 0);

   signal carry_flag_input			: std_logic;
   signal negative_flag_input			: std_logic;
   signal zero_flag_input   			: std_logic;

   signal carry_flag_internal_output		: std_logic;
   signal negative_flag_internal_output		: std_logic;
   signal zero_flag_output   			: std_logic;

   signal internal_carry_out			: std_logic;
   signal internal_negative_out			: std_logic;
   signal internal_zero_out			: std_logic;

   signal ALU_output				: std_logic_vector(7 downto 0);
   signal operation_result_register_output	: std_logic_vector(7 downto 0);

   begin
	temp_input_register	: entity work.Eight_Bit_Register
        	port map (
	    		Data_Input		=> input_1,
			Input_Enable		=> temp_input_register_input_enable,
			Clock			=> Clock,
            		Output_Enable		=> '1',

			Output			=> temp_input_register_output
        	);
	
	-- carry flag is set by the result of an operation (internal_carry_out)
	-- but if the clear_carry_flag_control bit is set, this overrides it and sets the carry flag to zero. 
	carry_flag_input <= (not clear_carry_flag_control) and internal_carry_out;

	carry_flag		: entity work.Edge_Triggered_Flip_Flop
		port map (
			Data_Input		=> carry_flag_input,
			Input_Enable		=> '1',
			Clock			=> Clock,
			output			=> carry_flag_internal_output
		);

	-- negative flag is set by the result of an operation (internal_negative_out)
	-- but if the clear_negative_flag_control bit is set, this overrides it and sets the negative flag to zero. 
	negative_flag_input <= not clear_negative_flag_control and internal_negative_out;

	negative_flag		: entity work.Edge_Triggered_Flip_Flop
		port map (
			Data_Input		=> negative_flag_input,
			Input_Enable		=> '1',
			Clock			=> Clock,
			output			=> negative_flag_internal_output
		);
	
	ALU			: entity work.ALU
		port map (
	    		opcode			=> opcode,
			input_1			=> temp_input_register_output,
			input_2			=> input_2,
			-- carry in is the result of the previous carry out
			carry_in		=> carry_flag_internal_output,
			-- negative in is the result of the previous negative out
			negative_in		=> negative_flag_internal_output,
	
			output			=> ALU_output,
			carry_out		=> internal_carry_out,
			negative_out		=> internal_negative_out
        	);

	-- loads result of operation, ready for output
	operation_result_register	: entity work.Eight_Bit_Register
        	port map (
	    		Data_Input		=> ALU_output,
			Input_Enable		=> operation_enable,
			Clock			=> Clock,
            		Output_Enable		=> Output_Enable,

			Output			=>  operation_result_register_output
        	);
	
	carry_flag_output			<= carry_flag_internal_output;
	negative_flag_output			<= negative_flag_internal_output;
	output					<= operation_result_register_output;

end architecture Behavioral;