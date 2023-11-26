

library  ieee;
use ieee.std_logic_1164.all;

entity Instruction_Decoder is
    port (
    	Instruction				: in std_logic_vector(7 downto 0);
	FSM_In					: in std_logic_vector(7 downto 0);
	-- Output Control Signals:
	FSM_Out					: out std_logic_vector(7 downto 0);
	MAR_Low_Input_Enable		 	: out std_logic;
	MAR_High_Input_Enable			: out std_logic;
	PC_Low_Output_Enable			: out std_logic;
	PC_High_Output_Enable			: out std_logic;
	PC_Low_Input_Enable			: out std_logic;
	PC_High_Input_Enable			: out std_logic;
	MAR_Low_Output_To_Memory_Enable		: out std_logic;
	MAR_High_Output_To_Memory_Enable	: out std_logic;
	Memory_Read_Enable			: out std_logic;
	IR_Input_Enable				: out std_logic;
	Increment_PC				: out std_logic;
	A_Reg_Input_Enable			: out std_logic;
	X_Reg_Input_Enable			: out std_logic;
	Y_Reg_Input_Enable			: out std_logic
    );
end entity Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

signal Internal_Step_0_Initial_State 		: std_logic;
signal Internal_Step_1_Fetch_Instruction 	: std_logic;
signal Internal_LD_Reg_Immediate_Step_1_LDA	: std_logic;
signal Internal_LD_Reg_Immediate_Step_1_LDX	: std_logic;
signal Internal_LD_Reg_Immediate_Step_1_LDY	: std_logic;
signal Internal_Branch_LD_Reg_Absolute		: std_logic;
signal Internal_LD_Reg_Absolute_Step_1		: std_logic;
signal Internal_LD_Reg_Absolute_Step_2		: std_logic;
signal Internal_LD_Reg_Absolute_Step_3		: std_logic;
signal Internal_LD_Reg_Absolute_Step_4		: std_logic;
signal Internal_LD_Reg_Absolute_Step_5		: std_logic;
signal Internal_LD_Reg_Absolute_Step_6		: std_logic;
signal Internal_LD_Reg_Absolute_Step_7		: std_logic;


begin
	--************ Setting signal to represent current step based on current FSM Value **********-------
	
	-- if FSM_In = "00000000" set Step 0 Initial State (No Action)
	Internal_Step_0_Initial_State <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	not FSM_In(1) and 	not FSM_In(0);

	-- if FSM_In = "00000001" set Step 1 Fetch Instruction and Increment PC
	Internal_Step_1_Fetch_Instruction <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	not FSM_In(1) and 	FSM_In(0);

	-- if FSM_In = "00000011" and Instruction is 00010001 Step One of Load Immediate Value to Register - Load A Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDA <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000011" and Instruction is 00010010 Step One of Load Immediate Value to Register - Load X Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDX <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00000011" and Instruction is 00010011 Step One of Load Immediate Value to Register - Load Y Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDY <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000011" and Instruction is 0010xxxx Step One of Load Absolute Value to Register - Load MAR (high) 
	Internal_LD_Reg_Absolute_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	Instruction(5) and 	not Instruction(4);

	-- if FSM_In = "00000101" set Step Two of Load Absolute Value to Register - Increment PC
	Internal_LD_Reg_Absolute_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and	FSM_In(0);

 	--************** Set next value of FSM based on Current Step **************--

	-- If Internal_Step_0_Initial_State		set FSM_Out = "00000001" (Step 1)	
	-- if Internal_Step_1_Fetch_Instruction		set FSM_Out = "00000011" (Step 3 - Start Instruction Subroutines)

	-- if Internal_LD_Reg_Immediate_Step_1_LDA	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Immediate_Step_1_LDX	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Immediate_Step_1_LDY	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_LD_Reg_Absolute_Step_1 		set FSM_Out = "00000101" (Branch to Ld Reg Absolute Step 2)
	-- if Internal_LD_Reg_Absolute_Step_2 		set FSM_Out = "00000111" (Branch to Ld Reg Absolute Step 3)

	FSM_Out(7) <= '0';
 	FSM_Out(6) <= '0';
	FSM_Out(5) <= '0';
	FSM_Out(4) <= '0';
	FSM_Out(3) <= '0';
	FSM_Out(2) <=
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2;
	FSM_Out(1) <=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_2;
	FSM_Out(0) <=		
		Internal_Step_0_Initial_State or
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or		
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2;
	
	PC_Low_Output_Enable	<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2;

	MAR_Low_Input_Enable	<= '0';

	PC_High_Output_Enable	<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2;

	MAR_High_Input_Enable	<= Internal_LD_Reg_Absolute_Step_1;

	PC_Low_Input_Enable  <= '0';
	PC_High_Input_Enable <= '0';
	
	MAR_Low_Output_To_Memory_Enable		<= '0';
	MAR_High_Output_To_Memory_Enable	<= '0';

	Memory_Read_Enable			<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1;

	IR_Input_Enable				<= Internal_Step_1_Fetch_Instruction;

	A_Reg_Input_Enable			<= Internal_LD_Reg_Immediate_Step_1_LDA;
	X_Reg_Input_Enable			<= Internal_LD_Reg_Immediate_Step_1_LDX;
	Y_Reg_Input_Enable			<= Internal_LD_Reg_Immediate_Step_1_LDY;

	-- To increment PC you must also assert PC Output Enable control signals
	Increment_PC <=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_2;

end architecture Behavioral;
