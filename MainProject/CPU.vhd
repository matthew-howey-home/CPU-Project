library  ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
	Clock			: in std_logic;
	Reset			: in std_logic
    );
end entity  CPU;

architecture Behavioral of CPU is
	signal FSM_Register_Initial_State	: std_logic_vector(7 downto 0);
	signal FSM_Register_In			: std_logic_vector(7 downto 0);

	signal Decoder_FSM_In			: std_logic_vector(7 downto 0);
	signal Decoder_FSM_Out			: std_logic_vector(7 downto 0);
	signal Instruction	: std_logic_vector(7 downto 0);
	signal Control_Bus	: std_logic_vector(13 downto 0);

	
begin
	FSM_Register_Initial_State <= "00000001";

	-- RESET MUX, connect FSM_Initial_State to FSM input if Reset is asserted
	Reset_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Decoder_FSM_Out, -- i.e. next FSM state as output from decoder
            		Input_2 	=> FSM_Register_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> FSM_Register_In
        	);

 
	-- FINITE STATE MACHINE
	FSM: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> FSM_Register_In,
            		Input_Enable 	=> '1',
            		Clock 		=> Clock,
			Output_Enable 	=> '1',

            		Output 		=> Decoder_FSM_In
        	);

	-- CONTROL UNIT INSTRUCTION DECODER
	Instruction_Decoder: entity work.Instruction_Decoder
		port map (
	    		Instruction 				=> Instruction,
            		FSM_In	 				=> Decoder_FSM_In,

			FSM_Out					=> Decoder_FSM_Out,
			MAR_Low_Input_Enable			=> Control_Bus(0),
			MAR_High_Input_Enable			=> Control_Bus(1), 	
			PC_Low_Output_Enable			=> Control_Bus(2), 	
			PC_High_Output_Enable			=> Control_Bus(3), 	
			MAR_Low_Output_To_Memory_Enable		=> Control_Bus(4), 	
			MAR_High_Output_To_Memory_Enable	=> Control_Bus(5), 	
			Memory_Read_Enable			=> Control_Bus(6), 	
			MDR_Input_Enable			=> Control_Bus(7), 	
			MDR_Output_Enable			=> Control_Bus(8), 	
			IR_Input_Enable				=> Control_Bus(9), 	
			Increment_PC				=> Control_Bus(10), 	
			A_Reg_Input_Enable			=> Control_Bus(11), 	
			X_Reg_Input_Enable			=> Control_Bus(12), 	
			Y_Reg_Input_Enable			=> Control_Bus(13) 	
        	);
	
end architecture Behavioral;