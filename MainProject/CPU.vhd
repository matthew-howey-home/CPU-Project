library  ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
	Clock			: in std_logic;
	Reset			: in std_logic;

	Memory_In		: in std_logic_vector(7 downto 0);
	

	Memory_Out_Low		: out std_logic_vector(7 downto 0);
	Memory_Out_High		: out std_logic_vector(7 downto 0);
	Memory_Read_Enable	: out std_logic;
	Memory_Write_Enable	: out std_logic;
	Memory_Data_Out		: out std_logic_vector(7 downto 0);

	A_Reg_External_Output	: out std_logic_vector(7 downto 0);
	X_Reg_External_Output	: out std_logic_vector(7 downto 0);
	Y_Reg_External_Output	: out std_logic_vector(7 downto 0)
    );
end entity  CPU;

architecture Behavioral of CPU is
	signal FSM_Register_Initial_State	: std_logic_vector(7 downto 0);
	signal FSM_Register_In			: std_logic_vector(7 downto 0);

	signal PC_Low_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_Low_In			: std_logic_vector(7 downto 0);
	signal PC_Low_Input_Enable		: std_logic;
	signal PC_Low_Mux_Selector		: std_logic_vector(1 downto 0);
	signal PC_Low_Out			: std_logic_vector(7 downto 0);
	signal Increment_PC_Low_In		: std_logic_vector(7 downto 0);
	signal PC_Low_Incremented		: std_logic_vector(7 downto 0);
	signal Increment_PC_Low_Carry_Out	: std_logic;

	signal PC_High_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_High_In			: std_logic_vector(7 downto 0);
	signal PC_High_Input_Enable		: std_logic;
	signal PC_High_Mux_Selector		: std_logic_vector(1 downto 0);
	signal PC_High_Out			: std_logic_vector(7 downto 0);
	signal Increment_PC_High_In		: std_logic_vector(7 downto 0);
	signal PC_High_Incremented		: std_logic_vector(7 downto 0);
	signal Increment_PC_High_Carry_Out	: std_logic;

	signal Decoder_FSM_In			: std_logic_vector(7 downto 0);
	signal Decoder_FSM_Out			: std_logic_vector(7 downto 0);

	signal Instruction			: std_logic_vector(7 downto 0);
	signal Control_Bus			: std_logic_vector(15 downto 0);
	signal Data_Bus				: std_logic_vector(7 downto 0);

	signal A_Reg_Output			: std_logic_vector(7 downto 0);
	signal X_Reg_Output			: std_logic_vector(7 downto 0);
	signal Y_Reg_Output			: std_logic_vector(7 downto 0);

begin
	FSM_Register_Initial_State 	<= "00000000";
	PC_Low_Initial_State 		<= "00000000";
	PC_High_Initial_State 		<= "00000000";

	-- CONTROL UNIT INSTRUCTION DECODER
	Instruction_Decoder: entity work.Instruction_Decoder
		port map (
	    		Instruction 				=> Instruction,
            		FSM_In	 				=> Decoder_FSM_In,

			FSM_Out					=> Decoder_FSM_Out,
			MAR_Low_Input_Enable			=> Control_Bus(0),
			MAR_Low_Output_To_Memory_Enable		=> Control_Bus(1),
			MAR_High_Input_Enable			=> Control_Bus(2),
			MAR_High_Output_To_Memory_Enable	=> Control_Bus(3),
			Memory_Read_Enable			=> Control_Bus(4), 
			Memory_Write_Enable			=> Control_Bus(5),
			PC_Low_Input_Enable			=> Control_Bus(6), 	
			PC_Low_Output_Enable			=> Control_Bus(7),
			PC_High_Input_Enable			=> Control_Bus(8),	 	
			PC_High_Output_Enable			=> Control_Bus(9),			
			IR_Input_Enable				=> Control_Bus(10), 	
			Increment_PC				=> Control_Bus(11), 	
			A_Reg_Input_Enable			=> Control_Bus(12), 	
			X_Reg_Input_Enable			=> Control_Bus(13), 	
			Y_Reg_Input_Enable			=> Control_Bus(14),
			A_Reg_Output_Enable			=> Control_Bus(15)	
        	);


	-- RESET FSM MUX, connect FSM_Initial_State to FSM input if Reset is asserted, otherwise connect output from decoder (next state)
	Reset_FSM_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Decoder_FSM_Out, -- i.e. next FSM state as output from decoder
            		input_2 	=> FSM_Register_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> FSM_Register_In
        	);

	-- RESET PC Low Mux, directs Reset and Increment input

	PC_Low_Mux_Selector(0) <= Control_Bus(11); -- Increment PC
	PC_Low_Mux_Selector(1) <= Reset;

	PC_Low_Input_Mux: entity work.Four_to_One_Byte_Mux
		port map (
	    		input_0 	=> Data_Bus, -- default input to PC High, neither reset nor increment asserted
            		input_1 	=> PC_Low_Incremented, -- Increment asserted, set to incremented value
			input_2 	=> PC_Low_Initial_State, -- Reset asserted, set to initial value
			input_3 	=> PC_Low_Initial_State, -- Both asserted, prioritise reset

            		selector	=> PC_Low_Mux_Selector,
	
            		Output 		=> PC_Low_In
        	);

	PC_Low_Input_Enable_Mux: entity work.Four_to_One_Bit_Mux
		port map (	    		
			input_0 	=> Control_Bus(6), -- default input to PC Low Input Enable
            		input_1 	=> '1', -- assert input enable if Increment signal is asserted
			input_2 	=> '1', -- assert input enable if Reset signal is asserted
			input_3 	=> '1', -- assert input enable if both signals asserted

            		selector	=> PC_Low_Mux_Selector,
	
            		Output 		=> PC_Low_Input_Enable
        	);

	
	-- RESET PC High Mux, directs Reset and Increment input
	PC_High_Mux_Selector(0) <= Control_Bus(11); -- Increment PC
	PC_High_Mux_Selector(1) <= Reset;

	PC_High_Input_Mux: entity work.Four_to_One_Byte_Mux
		port map (
	    		input_0 	=> Data_Bus, -- default input to PC High, neither reset nor increment asserted
            		input_1 	=> PC_High_Incremented, -- Increment asserted, set to incremented value
			input_2 	=> PC_High_Initial_State, -- Reset asserted, set to initial value
			input_3 	=> PC_High_Initial_State, -- Both asserted, prioritise reset

            		selector	=> PC_High_Mux_Selector,
	
            		Output 		=> PC_High_In
        	);

	PC_High_Input_Enable_Mux: entity work.Four_to_One_Bit_Mux
		port map (	    		
			input_0 	=> Control_Bus(8), -- default input to PC High Input Enable
            		input_1 	=> '1', -- assert input enable if Increment signal is asserted
			input_2 	=> '1', -- assert input enable if Reset signal is asserted
			input_3 	=> '1', -- assert input enable if both signals asserted

            		selector	=> PC_High_Mux_Selector,
	
            		Output 		=> PC_High_Input_Enable
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

	-- SPECIAL PURPOSE REGISTERS

	MAR_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(0),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(1),

            		Output 		=> Memory_Out_Low
        	);

	MAR_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(2),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(3),
			Output 		=> Memory_Out_High
        	);
	
	-- connects byte fetched from memory to Data Bus if Memory Read Enable is set
	Memory_In_Tristate_Buffer: entity work.Eight_Bit_Tristate_Buffer
		port map (
			input		=> Memory_In,
			enable		=> Control_Bus(4), -- Memory Read Enable
			output		=> Data_Bus
		);

	PC_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_Low_In,
            		Input_Enable 	=> PC_Low_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(7),

            		Output 		=> PC_Low_Out
        	);
	
	Increment_PC_Low_In 	<= PC_Low_Out;
	Memory_Out_Low 		<= PC_Low_Out;

	PC_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_High_In,
            		Input_Enable 	=> PC_High_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(9),

            		Output 		=> PC_High_Out
        	);

	Increment_PC_High_In 	<= PC_High_Out;
	Memory_Out_High 	<= PC_High_Out;

	Increment_PC_Low: entity work.ADD_Component
		port map (
			carry_in	=> '0',
			input_1		=> Increment_PC_Low_In,
			input_2		=> "00000001",
		
	    		output		=> PC_Low_Incremented,
            		carry_out	=> Increment_PC_Low_Carry_Out
        	);

	Increment_PC_High: entity work.ADD_Component
		port map (
			carry_in	=> Increment_PC_Low_Carry_Out,
			input_1		=> Increment_PC_High_In,
			input_2		=> "00000000",
		
	    		output		=> PC_High_Incremented,
            		carry_out	=> Increment_PC_High_Carry_Out
        	);

	IR: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(10),
            		Clock 		=> Clock,
			Output_Enable 	=> '1', -- always outputting to Instruction Decoder

            		Output 		=> Instruction
        	);

	-- Accumulator
	
	A_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(12),
            		Clock 		=> Clock,
			Output_Enable 	=> '1', -- always outputting to expose for external monitoring

            		Output 		=> A_Reg_Output
        	);
	
	A_Register_Out_Mux: entity work.Eight_Bit_Tristate_Buffer
		port map (
	    		input	=> A_Reg_Output,
           		enable	=> Control_Bus(15), -- A_Reg_Output_Enable,
           		output	=> Data_Bus
        	);

	-- General Purpose registers
	X_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(13),
            		Clock 		=> Clock,
			Output_Enable 	=> '1', -- always outputting to expose for external monitoring

            		Output 		=> X_Reg_Output
        	);

	Y_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(14),
            		Clock 		=> Clock,
			Output_Enable 	=> '1', -- always outputting to expose for external monitoring

            		Output 		=> Y_Reg_Output
        	);
	
	Memory_Read_Enable <= Control_Bus(4);
	Memory_Write_Enable <= Control_Bus(5);
	Memory_Data_Out <= Data_Bus;
	A_Reg_External_Output <= A_Reg_Output;
	X_Reg_External_Output <= X_Reg_Output;
	Y_Reg_External_Output <= Y_Reg_Output;
	
end architecture Behavioral;