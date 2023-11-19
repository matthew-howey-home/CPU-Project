

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
	MDR_Input_Enable			: out std_logic;
	MDR_Output_Enable			: out std_logic;
	IR_Input_Enable				: out std_logic;
	Increment_PC				: out std_logic;
	A_Reg_Input_Enable			: out std_logic;
	X_Reg_Input_Enable			: out std_logic;
	Y_Reg_Input_Enable			: out std_logic
    );
end entity Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

signal Internal_Step_0_Initial_State 		: std_logic;
signal Internal_Step_1_Load_MAR_Low 		: std_logic;
signal Internal_Step_2_Load_MAR_High 		: std_logic;
signal Internal_Step_3_Fetch_Instruction	: std_logic;
signal Internal_Step_4_Load_Instruction		: std_logic;
signal Internal_Step_5_Increment_PC		: std_logic;
signal Internal_Branch_LD_Reg_Absolute		: std_logic;
signal Internal_LD_Reg_Absolute_Step_1		: std_logic;
signal Internal_LD_Reg_Absolute_Step_2		: std_logic;
signal Internal_LD_Reg_Absolute_Step_3		: std_logic;
signal Internal_LD_Reg_Absolute_Step_4_LDA	: std_logic;
signal Internal_LD_Reg_Absolute_Step_4_LDX	: std_logic;
signal Internal_LD_Reg_Absolute_Step_4_LDY	: std_logic;
signal Internal_LD_Reg_Absolute_Step_5		: std_logic;
signal Internal_Branch_LD_Memory_to_Reg		: std_logic;

begin
	-- if FSM_In = "00000000" set Step 0 Initial State (No Action)
	Internal_Step_0_Initial_State <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	not FSM_In(1) and 	not FSM_In(0);

	-- if FSM_In = "00000001" set Step 1 Load MAR (low)
	Internal_Step_1_Load_MAR_Low <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	not FSM_In(1) and 	FSM_In(0);

	-- if FSM_In = "00000010" set Step 2 Load MAR (high)
	Internal_Step_2_Load_MAR_High <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and 		not FSM_In(0);

	-- if FSM_In = "00000011" set Step 3 Fetch Instruction
	Internal_Step_3_Fetch_Instruction <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and 		FSM_In(0);

	-- if FSM_In = "00000100" set Step 4 Load Instruction Register
	Internal_Step_4_Load_Instruction <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and 	not FSM_In(0);

	-- if FSM_In = "00000101" set Step 5 Increment PC
	Internal_Step_5_Increment_PC <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and 	FSM_In(0);

	-- if FSM_In = "00000110" and Instruction is 0001xxxx Branch to Load Absolute Value to Register (111)
	Internal_Branch_LD_Reg_Absolute <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4);

	-- if FSM_In = "00000111" Step One of Load Absolute Value to Register - Load MAR (low)
	Internal_LD_Reg_Absolute_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		FSM_In(0);

	-- if FSM_In = "00001000" Step Two of Load Absolute Value to Register - Load MAR (high)
	Internal_LD_Reg_Absolute_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	not FSM_In(1) and	not FSM_In(0);

	-- if FSM_In = "00001001" Step Three of Load Absolute Value to Register - Fetch Value from Memory
	Internal_LD_Reg_Absolute_Step_3 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	not FSM_In(1) and	FSM_In(0);

	-- if FSM_In = "00001010" and Instruction is xxxx0001 Step Four of Load Absolute Value to Register - Load A Reg
	Internal_LD_Reg_Absolute_Step_4_LDA <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00001010" and Instruction is xxxx0010 Step Four of Load Absolute Value to Register - Load X Reg
	Internal_LD_Reg_Absolute_Step_4_LDX <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00001010" and Instruction is xxxx0011 Step Four of Load Absolute Value to Register - Load Y Reg
	Internal_LD_Reg_Absolute_Step_4_LDY <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00001011" set Step Five of Load Absolute Value to Register - Increment Programme Counter
	Internal_LD_Reg_Absolute_Step_5 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		FSM_In(0);

	-- if FSM_In = "00000110" and Instruction is 0010xxxx Branch to Load Value from Memory to Register 
	Internal_Branch_LD_Memory_to_Reg <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	Instruction(5) and 	not Instruction(4);
 
	-- If Internal_Step_0_Initial_State		set FSM_Out = "00000001" (Step 1)
	-- if Internal_Step_1_Load_MAR_Low 		set FSM_Out = "00000010" (Step 2)
	-- if Internal_Step_2_Load_MAR_High 		set FSM_Out = "00000011" (Step 3)
	-- if Internal_Step_3_Fetch_Instruction 	set FSM_Out = "00000100" (Step 4)
	-- if Internal_Step_4_Load_Instruction 		set FSM_Out = "00000101" (Step 5)
	-- if Internal_Step_5_Increment_PC 		set FSM_Out = "00000110" (Step 6)
	-- if Internal_Branch_LD_Reg_Absolute 		set FSM_Out = "00000111" (Branch to Ld Abs to Reg Step 1)
	-- if Internal_LD_Reg_Absolute_Step_1		set FSM_Out = "00001000" (Ld Abs to Reg Step 2)
	-- if Internal_LD_Reg_Absolute_Step_2		set FSM_Out = "00001001" (Ld Abs to Reg Step 3)
	-- if Internal_LD_Reg_Absolute_Step_3		set FSM_Out = "00001010" (Ld Abs to Reg Step 4)
	-- if Internal_LD_Reg_Absolute_Step_4_LDA	set FSM_Out = "00001011" (Ld Abs to Reg Step 5)
	-- if Internal_LD_Reg_Absolute_Step_4_LDX	set FSM_Out = "00001011" (Ld Abs to Reg Step 5)
	-- if Internal_LD_Reg_Absolute_Step_4_LDY	set FSM_Out = "00001011" (Ld Abs to Reg Step 5)
	-- if Internal_LD_Reg_Absolute_Step_5		set FSM_Out = "00000001" (Back to Step 1)
	-- if Internal_Branch_LD_Memory_to_Reg 		set FSM_Out = "00001100" (Branch to Ld from Memory To Reg Step 1)

	FSM_Out(7) <= '0';
 	FSM_Out(6) <= '0';
	FSM_Out(5) <= '0';
	FSM_Out(4) <= '0';
	FSM_Out(3) <=
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_LD_Reg_Absolute_Step_3 or
		Internal_LD_Reg_Absolute_Step_4_LDA or
		Internal_LD_Reg_Absolute_Step_4_LDX or
		Internal_LD_Reg_Absolute_Step_4_LDY or
		Internal_Branch_LD_Memory_to_Reg;
	FSM_Out(2) <=
		Internal_Step_3_Fetch_Instruction or
		Internal_Step_4_Load_Instruction or
		Internal_Step_5_Increment_PC or
		Internal_Branch_LD_Reg_Absolute or
		Internal_Branch_LD_Memory_to_Reg;
	FSM_Out(1) <=
		Internal_Step_1_Load_MAR_Low or
		Internal_Step_2_Load_MAR_High or
		Internal_Step_5_Increment_PC or
		Internal_Branch_LD_Reg_Absolute or
		Internal_LD_Reg_Absolute_Step_3 or
		Internal_LD_Reg_Absolute_Step_4_LDA or
		Internal_LD_Reg_Absolute_Step_4_LDX or
		Internal_LD_Reg_Absolute_Step_4_LDY;
	FSM_Out(0) <=
		Internal_Step_0_Initial_State or
		Internal_Step_2_Load_MAR_High or
		Internal_Step_4_Load_Instruction or
		Internal_Branch_LD_Reg_Absolute or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_LD_Reg_Absolute_Step_4_LDA or
		Internal_LD_Reg_Absolute_Step_4_LDX or
		Internal_LD_Reg_Absolute_Step_4_LDY or
		Internal_LD_Reg_Absolute_Step_5;
	
	PC_Low_Output_Enable	<=
		Internal_Step_1_Load_MAR_Low or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_Step_5_Increment_PC or
		Internal_LD_Reg_Absolute_Step_5;
	MAR_Low_Input_Enable	<=
		Internal_Step_1_Load_MAR_Low or
		Internal_LD_Reg_Absolute_Step_1;

	PC_High_Output_Enable	<=
		Internal_Step_2_Load_MAR_High or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_Step_5_Increment_PC or
		Internal_LD_Reg_Absolute_Step_5;
	MAR_High_Input_Enable	<=
		Internal_Step_2_Load_MAR_High or
		Internal_LD_Reg_Absolute_Step_2;

	PC_Low_Input_Enable  <= '0';
	PC_High_Input_Enable <= '0';
	
	MAR_Low_Output_To_Memory_Enable		<=
		Internal_Step_3_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_3;

	MAR_High_Output_To_Memory_Enable	<=
		Internal_Step_3_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_3;

	Memory_Read_Enable			<=
		Internal_Step_3_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_3;

	MDR_Input_Enable			<=
		Internal_Step_3_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_3;

	MDR_Output_Enable			<=
		Internal_Step_4_Load_Instruction or
		Internal_LD_Reg_Absolute_Step_4_LDA or
		Internal_LD_Reg_Absolute_Step_4_LDX or
		Internal_LD_Reg_Absolute_Step_4_LDY;

	IR_Input_Enable				<= Internal_Step_4_Load_Instruction;

	A_Reg_Input_Enable			<= Internal_LD_Reg_Absolute_Step_4_LDA;
	X_Reg_Input_Enable			<= Internal_LD_Reg_Absolute_Step_4_LDX;
	Y_Reg_Input_Enable			<= Internal_LD_Reg_Absolute_Step_4_LDY;

	Increment_PC
		<= Internal_Step_5_Increment_PC or
		Internal_LD_Reg_Absolute_Step_5;

end architecture Behavioral;
