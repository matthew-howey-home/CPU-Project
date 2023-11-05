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

	signal PC_Low_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_Low_In			: std_logic_vector(7 downto 0);
	signal PC_Low_Input_Enable		: std_logic;
	signal PC_High_Initial_State		: std_logic_vector(7 downto 0);
	signal PC_High_In			: std_logic_vector(7 downto 0);
	signal PC_High_Input_Enable		: std_logic;

	signal Decoder_FSM_In			: std_logic_vector(7 downto 0);
	signal Decoder_FSM_Out			: std_logic_vector(7 downto 0);

	signal Instruction			: std_logic_vector(7 downto 0);
	signal Control_Bus			: std_logic_vector(13 downto 0);
	signal Data_Bus				: std_logic_vector(7 downto 0);
	
begin
	FSM_Register_Initial_State 	<= "00000001";
	PC_Low_Initial_State 		<= "00000000";
	PC_High_Initial_State 		<= "00000000";

	-- RESET FSM MUX, connect FSM_Initial_State to FSM input if Reset is asserted, otherwise connect output from decoder (next state)
	Reset_FSM_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Decoder_FSM_Out, -- i.e. next FSM state as output from decoder
            		Input_2 	=> FSM_Register_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> FSM_Register_In
        	);

	-- RESET PC Low Mux, connect PC Low Initial State to PC Low input if Reset is asserted, otherwise connect data bus
	Reset_PC_Low_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Data_Bus, -- default input to PC Low
            		Input_2 	=> PC_Low_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> PC_Low_In
        	);

	Reset_PC_Low_Input_Mux: entity work.Two_to_One_Mux
		port map (
	    		input_1 	=> Control_Bus(2), -- default input to PC Low Input Enable
            		Input_2 	=> '1', -- assert input enable if Reset siganl is asserted 
            		selector	=> Reset,
	
            		Output 		=> PC_Low_Input_Enable
        	);

	-- RESET PC High Mux, connect PC High Initial State to PC High input if Reset is asserted, otherwise connect data bus
	Reset_PC_High_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Data_Bus, -- default input to PC High
            		Input_2 	=> PC_High_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> PC_High_In
        	);

	Reset_PC_High_Input_Mux: entity work.Two_to_One_Mux
		port map (
	    		input_1 	=> Control_Bus(3), -- default input to PC High Input Enable
            		Input_2 	=> '1', -- assert input enable if Reset siganl is asserted 
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
	
	PC_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_Low_In,
            		Input_Enable 	=> PC_Low_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(2),

            		Output 		=> Data_Bus
        	);

	PC_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> PC_High_In,
            		Input_Enable 	=> PC_High_Input_Enable,
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(3),

            		Output 		=> Data_Bus
        	);
	
end architecture Behavioral;