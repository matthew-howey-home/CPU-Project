library  ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
        Memory_Data_In		: in std_logic_vector(7 downto 0);
	Clock			: in std_logic;

        A_Register_Out		: out std_logic_vector(7 downto 0);
	X_Register_Out		: out std_logic_vector(7 downto 0);
	Y_Resister_Out		: out std_logic_vector(7 downto 0);
	Memory_Address_Out_Low	: out std_logic_vector(7 downto 0);
	Memory_Address_Out_High	: out std_logic_vector(7 downto 0);
	Memory_Read_Enable	: out std_logic
    );
end entity  CPU;

architecture Behavioral of CPU is
	signal Control_Bus	: std_logic_vector(14 downto 0);
	signal Data_Bus		: std_logic_vector(7 downto 0);
	signal Condition_Flags	: std_logic_vector(3 downto 0);
	signal ALU_Opcode	: std_logic_vector(3 downto 0);

	signal FSM_Initial_State: std_logic_vector(7 downto 0);
	signal FSM_In_Signal	: std_logic_vector(7 downto 0);

	signal FSM_Out_Signal	: std_logic_vector(7 downto 0);
	
	signal Instruction	: std_logic_vector(7 downto 0);

begin
	FSM_Initial_State <= "00000001";
	FSM_In_Signal <= FSM_Initial_State;

	-- CONTROL UNIT
	Instruction_Decoder: entity work.Instruction_Decoder
		port map (
	    		Instruction 				=> Instruction,
            		FSM_In	 				=> FSM_In_Signal,

			FSM_Out					=> FSM_Out_Signal,
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
 
	-- FINITE STATE MACHINE
	FSM: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> FSM_In_Signal,
            		Input_Enable 	=> '1',
            		Clock 		=> Clock,
			Output_Enable 	=> '0',

            		Output 		=> Data_Bus
        	);

	-- REGISTERS
	A_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(11),
            		Clock 		=> Clock,
			Output_Enable 	=> '0',

            		Output 		=> Data_Bus
        	);

	X_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(12),
            		Clock 		=> Clock,
			Output_Enable 	=> '0',

            		Output 		=> Data_Bus
        	);

	Y_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(13),
            		Clock 		=> Clock,
			Output_Enable 	=> '0',

            		Output 		=> Data_Bus
        	);

	MAR_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(0),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(4),

            		Output 		=> Memory_Address_Out_Low
        	);

	MAR_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(1),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(5),

            		Output 		=> Memory_Address_Out_High
        	);

	Programme_Counter_Low: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(10), -- Increment PC Control Signal
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(2),

            		Output 		=> Data_Bus
        	);

	Programme_Counter_High: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(10), -- Increment PC Control Signal
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(3),

            		Output 		=> Data_Bus
        	);

	MDR: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(7),
            		Clock 		=> Clock,
			Output_Enable 	=> Control_Bus(8),

            		Output 		=> Data_Bus
        	);

	Instruction_Register: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> Data_Bus,
            		Input_Enable 	=> Control_Bus(9),
            		Clock 		=> Clock,
			Output_Enable 	=> '1',

            		Output 		=> Instruction
        	);


	
	
end architecture Behavioral;