
library  ieee;
use ieee.std_logic_1164.all;

-- This Interface sits between the Buses and the ALU
-- It handles the temporary input and temporary output registers
-- And the condition flags 

entity  ALU_Interface is
    port (
	Clock					: in std_logic;
       
	-- main inputs
	Opcode  				: in std_logic_vector(2 downto 0);
	Input_Operand_1				: in std_logic_vector(7 downto 0);
        Input_Operand_2				: in std_logic_vector(7 downto 0);
	Input_Carry				: in std_logic;
	Input_Negative				: in std_logic;
	
	-- Enable Controls
	Enable_Input_For_Temp_Input_Reg		: in std_logic;
	Enable_Operation			: in std_logic;
	Enable_Flags_Input			: in std_logic;
	Enable_Output_Final			: in std_logic;
	
	-- Other Control Signals

	Control_Clear_Carry			: in std_logic;
	Control_Clear_Negative			: in std_logic;
	Control_Clear_Zero			: in std_logic;

	-- Final Outputs
	Output_Final				: out std_logic_vector(7 downto 0);
	Output_From_Carry_Flag			: out std_logic;
	Output_From_Negative_Flag		: out std_logic;
	Output_From_Zero_Flag			: out std_logic
    );
end entity  ALU_Interface;

architecture Behavioral of ALU_Interface is
   signal Internal_Temp_Input_Reg_Output	: std_logic_vector(7 downto 0);

   signal Internal_Input_To_Carry_Flag		: std_logic;
   signal Internal_Input_To_Negative_Flag	: std_logic;
   signal Internal_Input_To_Zero_Flag   	: std_logic;

   signal Internal_Output_From_Carry_Flag	: std_logic;
   signal Internal_Output_From_Negative_Flag	: std_logic;
   signal Internal_Output_From_Zero_Flag   	: std_logic;

   signal Internal_Carry_Out_From_Op		: std_logic;
   signal Internal_Negative_Out_From_Op		: std_logic;
   signal Internal_Output_From_Zero_Check	: std_logic;

   signal Internal_Output_From_ALU		: std_logic_vector(7 downto 0);
   signal Internal_Output_From_Result_Register	: std_logic_vector(7 downto 0);

   begin
	Temp_Input_Reg		: entity work.Eight_Bit_Register
        	port map (
	    		Data_Input		=> Input_Operand_1,
			Input_Enable		=> Enable_Input_For_Temp_Input_Reg,
			Clock			=> Clock,
            		Output_Enable		=> '1',

			Output			=> Internal_Temp_Input_Reg_Output
        	);
	
	-- carry flag is set by the result of an operation (Internal_Carry_Out_From_Op)
	-- but if the Control_Clear_Carry bit is set, this overrides it and sets the carry flag to zero. 
	Internal_Input_To_Carry_Flag <= (not Control_Clear_Carry) and Internal_Carry_Out_From_Op;

	Carry_Flag		: entity work.Edge_Triggered_Flip_Flop
		port map (
			Data_Input		=> Internal_Input_To_Carry_Flag,
			Input_Enable		=> Enable_Flags_Input,
			Clock			=> Clock,
			output			=> Internal_Output_From_Carry_Flag
		);

	-- negative flag is set by the result of an operation (internal_negative_out)
	-- but if the clear_negative_flag_control bit is set, this overrides it and sets the negative flag to zero. 
	Internal_Input_To_Negative_Flag <= not Control_Clear_Negative and Internal_Negative_Out_From_Op;

	Negative_Flag		: entity work.Edge_Triggered_Flip_Flop
		port map (
			Data_Input		=> Internal_Input_To_Negative_Flag,
			-- flags should be loaded when operation takes place
			Input_Enable		=> Enable_Flags_Input,
			Clock			=> Clock,
			output			=> Internal_Output_From_Negative_Flag
		);
	
	
	ALU			: entity work.ALU
		port map (
	    		opcode			=> Opcode,
			-- first input is read from temporary input register
			-- second input is read directly from the bus 
			input_1			=> Internal_Temp_Input_Reg_Output,
			input_2			=> Input_Operand_2,
			-- carry in is the result of the previous carry out
			carry_in		=> Internal_Output_From_Carry_Flag,
			-- negative in is the result of the previous negative out
			negative_in		=> Internal_Output_From_Negative_Flag,
	
			output			=> Internal_Output_From_ALU,
			carry_out		=> Internal_Carry_Out_From_Op,
			negative_out		=> Internal_Negative_Out_From_Op
        	);

	-- Load result of operation, ready for Final Output
	Operation_Result_Register	: entity work.Eight_Bit_Register
        	port map (
	    		Data_Input		=> Internal_Output_From_ALU,
			Input_Enable		=> Enable_Operation,
			Clock			=> Clock,
            		Output_Enable		=> Enable_Output_Final,

			Output			=> Internal_Output_From_Result_Register
        	);

	Is_Output_Zero			: entity work.Is_Register_Zero
		port map (
			input			=> Internal_Output_From_ALU,
			output			=> Internal_Output_From_Zero_Check
		);

	-- zero flag is set by the result of an operation followed by check (Internal_Output_From_Zero_Check)
	-- but if the Control_Clear_Zero bit is set, this overrides it and sets the zero flag to zero. 
	Internal_Input_To_Zero_Flag <= (not Control_Clear_Zero) and Internal_Output_From_Zero_Check;

	Zero_Flag			: entity work.Edge_Triggered_Flip_Flop
		port map (
			Data_Input		=> Internal_Input_To_Zero_Flag,
			-- flags should be loaded when operation takes place
			Input_Enable		=> Enable_Flags_Input,
			Clock			=> Clock,
			output			=> Internal_Output_From_Zero_Flag
		);
	
	Output_From_Carry_Flag			<= Internal_Output_From_Carry_Flag;
	Output_From_Negative_Flag		<= Internal_Output_From_Negative_Flag;
	Output_From_Zero_Flag			<= Internal_Output_From_Zero_Flag;
	Output_Final				<= Internal_Output_From_Result_Register;

end architecture Behavioral;