library  ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
	Clock			: in std_logic;
	Reset			: in std_logic;

	Memory_In		: in std_logic_vector(7 downto 0);

	Memory_Out_Low		: out std_logic_vector(7 downto 0);
	Memory_Out_High		: out std_logic_vector(7 downto 0);
	Memory_Read_Enable	: out std_logic
    );
end entity  CPU;

architecture Behavioral of CPU is
	signal FSM_Register_Initial_State	: std_logic_vector(7 downto 0);
	signal FSM_Register_In			: std_logic_vector(7 downto 0);

	signal PC_Low_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_Low_In			: std_logic_vector(7 downto 0);
	signal PC_Low_Input_Enable		: std_logic;
	signal PC_High_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_High_In			: std_logic_vector(7 downto 0);
	signal PC_High_Input_Enable		: std_logic;

	signal Decoder_FSM_In			: std_logic_vector(7 downto 0);
	signal Decoder_FSM_Out			: std_logic_vector(7 downto 0);

	signal Instruction			: std_logic_vector(7 downto 0);
	signal Control_Bus			: std_logic_vector(15 downto 0);
	signal Data_Bus				: std_logic_vector(7 downto 0);
	
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
			MDR_Input_Enable			=> Control_Bus(4), 	
			MDR_Output_Enable			=> Control_Bus(5), 	
			Memory_Read_Enable			=> Control_Bus(6), 
			PC_Low_Input_Enable			=> Control_Bus(7), 	
			PC_Low_Output_Enable			=> Control_Bus(8),
			PC_High_Input_Enable			=> Control_Bus(9),	 	
			PC_High_Output_Enable			=> Control_Bus(10),			
			IR_Input_Enable				=> Control_Bus(11), 	
			Increment_PC				=> Control_Bus(12), 	
			A_Reg_Input_Enable			=> Control_Bus(13), 	
			X_Reg_Input_Enable			=> Control_Bus(14), 	
			Y_Reg_Input_Enable			=> Control_Bus(15) 	
        	);


	-- RESET FSM MUX, connect FSM_Initial_State to FSM input if Reset is asserted, otherwise connect output from decoder (next state)
	Reset_FSM_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Decoder_FSM_Out, -- i.e. next FSM state as output from decoder
            		input_2 	=> FSM_Register_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> FSM_Register_In
        	);

	-- RESET PC Low Mux, connect PC Low Initial State to PC Low input if Reset is asserted, otherwise connect data bus
	Reset_PC_Low_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Data_Bus, -- default input to PC Low
            		input_2 	=> PC_Low_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> PC_Low_In
        	);

	Reset_PC_Low_Input_Mux: entity work.Two_to_One_Mux
		port map (
	    		input_1 	=> Control_Bus(7), -- default input to PC Low Input Enable
            		input_2 	=> '1', -- assert input enable if Reset siganl is asserted 
            		selector	=> Reset,
	
            		Output 		=> PC_Low_Input_Enable
        	);

	-- RESET PC High Mux, connect PC High Initial State to PC High input if Reset is asserted, otherwise connect data bus
	Reset_PC_High_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Data_Bus, -- default input to PC High
            		input_2 	=> PC_High_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> PC_High_In
        	);

	Reset_PC_High_Input_Mux: entity work.Two_to_One_Mux
		port map (
	    		input_1 	=> Control_Bus(9), -- default input to PC High Input Enable
            		input_2 	=> '1', -- assert input enable if Reset siganl is asserted 
            		selector	=> Reset,
	
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
	    		Data_Input 	=> PC_High_In,
            		Input_Enable 	=> Control_Bus(2),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(3),
			Output 		=> Memory_Out_High
        	);


	MDR: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Memory_In,
            		Input_Enable 	=> Control_Bus(4),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(5),

            		Output 		=> Data_Bus
        	);

	PC_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_Low_In,
            		Input_Enable 	=> PC_Low_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(8),

            		Output 		=> Data_Bus
        	);

	PC_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_High_In,
            		Input_Enable 	=> PC_High_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(10),

            		Output 		=> Data_Bus
        	);

	IR: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(11),
            		Clock 		=> Clock,
			Output_Enable 	=> '1', -- always outputting to Instruction Decoder

            		Output 		=> Instruction
        	);

	Memory_Read_Enable <= Control_Bus(6);
	
end architecture Behavioral;