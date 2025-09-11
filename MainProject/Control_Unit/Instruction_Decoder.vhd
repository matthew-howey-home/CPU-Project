


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
	MAR_Low_Output_Enable			: out std_logic;
	MAR_High_Output_Enable			: out std_logic;
	Memory_Read_Enable			: out std_logic;
	Memory_Write_Enable			: out std_logic;
	IR_Input_Enable				: out std_logic;
	Increment_PC				: out std_logic;
	A_Reg_Input_Enable			: out std_logic;
	X_Reg_Input_Enable			: out std_logic;
	Y_Reg_Input_Enable			: out std_logic;
	A_Reg_Output_Enable			: out std_logic;
	X_Reg_Output_Enable			: out std_logic;
	Y_Reg_Output_Enable			: out std_logic;
	JMP_Enable				: out std_logic;
	Enable_Operand_1_Temp_Storage		: out std_logic;
	ALU_Enable_Operation			: out std_logic;
	ALU_Opcode				: out std_logic_vector(2 downto 0);
	ALU_Enable_Final_Output			: out std_logic;
	ALU_Enable_Flags_Input			: out std_logic;
	ALU_Control_Clear_Carry			: out std_logic;
	ALU_Control_Clear_Negative		: out std_logic;
	ALU_Control_Clear_Zero			: out std_logic
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
signal Internal_LD_Reg_Absolute_Step_3_LDA	: std_logic;
signal Internal_LD_Reg_Absolute_Step_3_LDX	: std_logic;
signal Internal_LD_Reg_Absolute_Step_3_LDY	: std_logic;
signal Internal_ST_Reg_Absolute_Step_1		: std_logic;
signal Internal_ST_Reg_Absolute_Step_2		: std_logic;
signal Internal_ST_Reg_Absolute_Step_3_STA	: std_logic;
signal Internal_ST_Reg_Absolute_Step_3_STX	: std_logic;
signal Internal_ST_Reg_Absolute_Step_3_STY	: std_logic;
signal Internal_JMP_Step_1			: std_logic;
signal Internal_JMP_Step_2			: std_logic;
signal Internal_JMP_Step_3			: std_logic;
signal Internal_ALU_Imm_Step_1			: std_logic;
signal Internal_ALU_Imm_Step_2			: std_logic;
signal Internal_ALU_Imm_Step_3			: std_logic;
signal Internal_ALU_Abs_Step_1			: std_logic;
signal Internal_ALU_Abs_Step_2			: std_logic;
signal Internal_ALU_Abs_Step_3			: std_logic;
signal Internal_ALU_Abs_Step_4			: std_logic;


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
	
	-- Note: if FSM_In = "00000010", and the instruction is not recognised, then none of the conditions below will be met
	-- So the FSM will then be set back to zero
		
	-- if FSM_In = "00000010" and Instruction is 00010001 Step One of Load Immediate Value to Register - Load A Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDA <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000010" and Instruction is 00010010 Step One of Load Immediate Value to Register - Load X Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDX <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00000010" and Instruction is 00010011 Step One of Load Immediate Value to Register - Load Y Reg with value from Memory, and Inc PC
	Internal_LD_Reg_Immediate_Step_1_LDY <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	not Instruction(5) and 	Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000010" and Instruction is 0010xxxx Step One of Load Absolute Value to Register - Load MAR (high) and increment PC
	Internal_LD_Reg_Absolute_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	not Instruction(6) and	Instruction(5) and 	not Instruction(4);

	-- if FSM_In = "00000011" set Step Two of Load Absolute Value to Register - Load MAR (low) and increment PC
	Internal_LD_Reg_Absolute_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		FSM_In(0);

	-- if FSM_In = "00000100" and Instruction is xxxx0001 set Step Three of Load Absolute Value to Register - Load Reg A from Memory
	Internal_LD_Reg_Absolute_Step_3_LDA <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and	not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000100" and Instruction is xxxx0010 set Step Three of Load Absolute Value to Register - Load Reg X from Memory
	Internal_LD_Reg_Absolute_Step_3_LDX <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and	not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00000100" and Instruction is xxxx0011 set Step Three of Load Absolute Value to Register - Load Reg Y from Memory
	Internal_LD_Reg_Absolute_Step_3_LDY <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and	not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000010" and Instruction is 0100xxxx set Step One of Store Register to Absolute Address - Load MAR High
	Internal_ST_Reg_Absolute_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	Instruction(6) and	not Instruction(5) and 	not Instruction(4);

	-- if FSM_In = "00000101" set Step Two of Store Register to Absolute Address - Load MAR Low and Inc PC
	Internal_ST_Reg_Absolute_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		not FSM_In(1) and	FSM_In(0);

	-- if FSM_In = "00000110" and Instruction is xxxx0001 set Step Three of Store Register to Absolute Address - Load A Reg to Memory
	Internal_ST_Reg_Absolute_Step_3_STA <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000110" and Instruction is xxxx0010 set Step Three of Store Register to Absolute Address - Load X Reg to Memory
	Internal_ST_Reg_Absolute_Step_3_STX <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00000110" and Instruction is xxxx0011 set Step Three of Store Register to Absolute Address - Load Y Reg to Memory
	Internal_ST_Reg_Absolute_Step_3_STY <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		not FSM_In(0) and
		not Instruction(3) and	not Instruction(2) and	Instruction(1) and 	Instruction(0);

	-- if FSM_In = "00000010" and Instruction is 01100000 set Step One of JMP - Unconditional Jump to Absolute Address - Load MAR (High), and Inc PC
	Internal_JMP_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		not Instruction(7) and	Instruction(6) and	Instruction(5) and 	not Instruction(4) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00000111" set Step Two of JMP - Unconditional Jump to Absolute Address - Load MAR (Low)
	Internal_JMP_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	FSM_In(2) and		FSM_In(1) and		FSM_In(0);

	-- if FSM_In = "00001000" set Step Three of JMP - Unconditional Jump to Absolute Address - Load PC with MAR
	Internal_JMP_Step_3 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and		not FSM_In(2) and	not FSM_In(1) and	not FSM_In(0);
	
	-- if FSM_In = "00000010" and Instruction is 1xxx0000 set Step One of ALU Operation Imm - Output Enable Reg A, Input Enable ALU Temp Reg
	Internal_ALU_Imm_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		Instruction(7) and
		not Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00001001" set Step Two of ALU Operation Imm - Load ALU with value from Memory, Load ALU with Opcode from IR, Enable ALU Op & flags input, and Inc PC
	Internal_ALU_Imm_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	not FSM_In(1) and	FSM_In(0);

	-- if FSM_In = "00001010" set Step Three of ALU Operation Imm - Enable Final Output from ALU, Load output from ALU into A Register
	Internal_ALU_Imm_Step_3 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		not FSM_In(0);

	-- if FSM_In = "00000010" and Instruction is 1xxx1000 set Step One of ALU Operation ABS - Output Enable Reg A, Input Enable ALU Temp Reg
	Internal_ALU_Abs_Step_1 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		not FSM_In(3) and 	not FSM_In(2) and	FSM_In(1) and		not FSM_In(0) and
		Instruction(7) and
		Instruction(3) and	not Instruction(2) and	not Instruction(1) and 	not Instruction(0);

	-- if FSM_In = "00001011" set Step Two of ALU Operation ABS - Load MAR High and Inc PC
	Internal_ALU_Abs_Step_2 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		not FSM_In(2) and	FSM_In(1) and		FSM_In(0);

	-- if FSM_In = "00001100" set Step Three of ALU Operation ABS - Load MAR Low and Inc PC
	Internal_ALU_Abs_Step_3 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		FSM_In(2) and		not FSM_In(1) and	not FSM_In(0);

	-- if FSM_In = "00001101" set Step Four of ALU Operation ABS - Load ALU with value from Memory(using MAR), Load ALU with Opcode from IR
	-- Enable ALU Op & flags input
	Internal_ALU_Abs_Step_3 <=
		not FSM_In(7) and	not FSM_In(6) and	not FSM_In(5) and	not FSM_In(4) and
		FSM_In(3) and 		FSM_In(2) and		not FSM_In(1) and	FSM_In(0);




 	--************** Set next value of FSM based on Current Step **************--

	-- If Internal_Step_0_Initial_State		set FSM_Out = "00000001" (Step 1)	
	-- if Internal_Step_1_Fetch_Instruction		set FSM_Out = "00000010" (Start Instruction Subroutines)

	-- if Internal_LD_Reg_Immediate_Step_1_LDA	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Immediate_Step_1_LDX	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Immediate_Step_1_LDY	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_LD_Reg_Absolute_Step_1 		set FSM_Out = "00000011" (Branch to Ld Reg Absolute Step 2)
	-- if Internal_LD_Reg_Absolute_Step_2 		set FSM_Out = "00000100" (Branch to Ld Reg Absolute Step 3)
	-- if Internal_LD_Reg_Absolute_Step_3_LDA	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Absolute_Step_3_LDX	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_LD_Reg_Absolute_Step_3_LDY	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_ST_Reg_Absolute_Step_1		set FSM_Out = "00000101" (Branch to Store Reg to Absoluet Step 2)
	-- if Internal_ST_Reg_Absolute_Step_2		set FSM_Out = "00000110" (Branch to Store Reg to Absoluet Step 3)
	-- if Internal_ST_Reg_Absolute_Step_3_STA	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_ST_Reg_Absolute_Step_3_STX	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)
	-- if Internal_ST_Reg_Absolute_Step_3_STY	set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_JMP_Step_1			set FSM_Out = "00000111" (JMP Step 2)
	-- if Internal_JMP_Step_2			set FSM_Out = "00001000" (JMP Step 3)
	-- if Internal_JMP_Step_3			set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_ALU_Imm_Step_1			set FSM_Out = "00001001" (ALU Imm Step 2)
	-- if Internal_ALU_Imm_Step_2			set FSM_Out = "00001010" (ALU Imm Step 3)
	-- if Internal_ALU_Imm_Step_3			set FSM_Out = "00000001" (Back to Step 1 Fetch Instruction)

	-- if Internal_ALU_Abs_Step_1			set FSM_Out = "00001011" (ALU Abs Step 2)
	-- if Internal_ALU_Abs_Step_2			set FSM_Out = "00001100" (ALU Abs Step 3)
	-- if Internal_ALU_Abs_Step_3			set FSM_Out = "00001101" (ALU Abs Step 4)
	-- if Internal_ALU_Abs_Step_4			set FSM_Out = "00001110" (ALU Abs Step 5)

	FSM_Out(7) <= '0';
 	FSM_Out(6) <= '0';
	FSM_Out(5) <= '0';
	FSM_Out(4) <= '0';
	FSM_Out(3) <= 
		Internal_JMP_Step_2 or
		Internal_ALU_Imm_Step_1 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_1 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_3 or
		Internal_ALU_Abs_Step_4;
	FSM_Out(2) <=
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_ALU_Abs_Step_3 or
		Internal_JMP_Step_1 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_4;
	FSM_Out(1) <=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_1 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_1 or
		Internal_ALU_Abs_Step_4;
	FSM_Out(0) <=		
		Internal_Step_0_Initial_State or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or		
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_3_LDA or
		Internal_LD_Reg_Absolute_Step_3_LDX or
		Internal_LD_Reg_Absolute_Step_3_LDY or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_3_STA or
		Internal_ST_Reg_Absolute_Step_3_STX or
		Internal_ST_Reg_Absolute_Step_3_STY or
		Internal_JMP_Step_1 or
		Internal_JMP_Step_3 or
		Internal_ALU_Imm_Step_1 or
		Internal_ALU_Imm_Step_3 or
		Internal_ALU_Abs_Step_1 or
		Internal_ALU_Abs_Step_3;

	PC_Low_Output_Enable	<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_1 or
		Internal_JMP_Step_2 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_3;

	MAR_Low_Input_Enable	<=
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_2 or
		Internal_ALU_Abs_Step_3;

	PC_High_Output_Enable	<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_1 or
		Internal_JMP_Step_2 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_3;

	MAR_High_Input_Enable	<=
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_JMP_Step_1 or
		Internal_ALU_Abs_Step_2;

	PC_Low_Input_Enable  <= '0';
	PC_High_Input_Enable <= '0';
	
	MAR_Low_Output_Enable		<=
		Internal_LD_Reg_Absolute_Step_3_LDA or
		Internal_LD_Reg_Absolute_Step_3_LDX or
		Internal_LD_Reg_Absolute_Step_3_LDY or
		Internal_ST_Reg_Absolute_Step_3_STA or
		Internal_ST_Reg_Absolute_Step_3_STX or
		Internal_ST_Reg_Absolute_Step_3_STY or
		Internal_JMP_Step_3 or
		Internal_ALU_Abs_Step_4;
	MAR_High_Output_Enable	<=
		Internal_LD_Reg_Absolute_Step_3_LDA or
		Internal_LD_Reg_Absolute_Step_3_LDX or
		Internal_LD_Reg_Absolute_Step_3_LDY or
		Internal_ST_Reg_Absolute_Step_3_STA or
		Internal_ST_Reg_Absolute_Step_3_STX or
		Internal_ST_Reg_Absolute_Step_3_STY or
		Internal_JMP_Step_3 or
		Internal_ALU_Abs_Step_4;

	Memory_Read_Enable			<=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_LD_Reg_Absolute_Step_3_LDA or
		Internal_LD_Reg_Absolute_Step_3_LDX or
		Internal_LD_Reg_Absolute_Step_3_LDY or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_1 or
		Internal_JMP_Step_2 or
		Internal_JMP_Step_3 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_3 or
		Internal_ALU_Abs_Step_4;

	Memory_Write_Enable <=
		Internal_ST_Reg_Absolute_Step_3_STA or
		Internal_ST_Reg_Absolute_Step_3_STX or
		Internal_ST_Reg_Absolute_Step_3_STY;

	IR_Input_Enable <=
		Internal_Step_1_Fetch_Instruction;

	A_Reg_Input_Enable			<=
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Absolute_Step_3_LDA or
		Internal_ALU_Imm_Step_3;
	X_Reg_Input_Enable			<=
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Absolute_Step_3_LDX;
	Y_Reg_Input_Enable			<=
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_3_LDY;

	A_Reg_Output_Enable			<=
		Internal_ST_Reg_Absolute_Step_3_STA or
		Internal_ALU_Imm_Step_1 or
		Internal_ALU_Abs_Step_1;
	X_Reg_Output_Enable			<=
		Internal_ST_Reg_Absolute_Step_3_STX;
	Y_Reg_Output_Enable			<=
		Internal_ST_Reg_Absolute_Step_3_STY;

	JMP_Enable <=
		Internal_JMP_Step_3;

	Enable_Operand_1_Temp_Storage <=
		Internal_ALU_Imm_Step_1 or
		Internal_ALU_Abs_Step_1;

	ALU_Enable_Operation <=
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_4;

	ALU_Enable_Final_Output <=
		Internal_ALU_Imm_Step_3;

	ALU_Enable_Flags_Input <=
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_4;

	ALU_Control_Clear_Carry 	<= '0';
	ALU_Control_Clear_Negative 	<= '0';
	ALU_Control_Clear_Zero 		<= '0';
	
		

	-- ALU Operation Instruction is 1xxx0000 with xxx in the Instruction, so xxx (4-6 bits) determines the ALU opcode
	ALU_Opcode(0) <= Instruction(4);
	ALU_Opcode(1) <= Instruction(5);
	ALU_Opcode(2) <= Instruction(6);
	
	-- To increment PC you must also assert PC Output Enable control signals
	Increment_PC <=
		Internal_Step_1_Fetch_Instruction or
		Internal_LD_Reg_Immediate_Step_1_LDA or
		Internal_LD_Reg_Immediate_Step_1_LDX or
		Internal_LD_Reg_Immediate_Step_1_LDY or
		Internal_LD_Reg_Absolute_Step_1 or
		Internal_LD_Reg_Absolute_Step_2 or
		Internal_ST_Reg_Absolute_Step_1 or
		Internal_ST_Reg_Absolute_Step_2 or
		Internal_JMP_Step_1 or
		Internal_ALU_Imm_Step_2 or
		Internal_ALU_Abs_Step_2 or
		Internal_ALU_Abs_Step_3;

end architecture Behavioral;
