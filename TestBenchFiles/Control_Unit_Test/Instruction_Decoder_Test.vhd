
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Instruction_Decoder_Test is
end entity Instruction_Decoder_Test;

architecture Behavioral of Instruction_Decoder_Test is
    -- Component declaration for the Instruction_Decoder module
    component Instruction_Decoder
        port (
            	Instruction				: in std_logic_vector(7 downto 0);
		FSM_In					: in std_logic_vector(7 downto 0);
		-- Output Control Signals:
		FSM_Out					: out std_logic_vector(7 downto 0);
		MAR_Low_Input_Enable		 	: out std_logic;
		MAR_High_Input_Enable			: out std_logic;
		PC_Low_Output_Enable			: out std_logic;
		PC_High_Output_Enable			: out std_logic;
		MAR_Low_Output_To_Memory_Enable		: out std_logic;
		MAR_High_Output_To_Memory_Enable	: out std_logic;
		Memory_Read_Enable			: out std_logic;
		Memory_Write_Enable			: out std_logic;
		IR_Input_Enable				: out std_logic;
		Increment_PC				: out std_logic;
		A_Reg_Input_Enable			: out std_logic;
		X_Reg_Input_Enable			: out std_logic;
		Y_Reg_Input_Enable			: out std_logic;
		A_Reg_Output_Enable			: out std_logic;
		X_Reg_Output_Enable			: out std_logic;
		Y_Reg_Output_Enable			: out std_logic
        );
    end component Instruction_Decoder;

    	-- Signal declarations
    	signal Instruction_Test					: std_logic_vector(7 downto 0);
	signal FSM_In_Test					: std_logic_vector(7 downto 0);

	signal FSM_Out_Test					: std_logic_vector(7 downto 0);
	signal MAR_Low_Input_Enable_Test		 	: std_logic;
	signal MAR_High_Input_Enable_Test			: std_logic;
	signal PC_Low_Output_Enable_Test			: std_logic;
	signal PC_High_Output_Enable_Test			: std_logic;
	signal MAR_Low_Output_To_Memory_Enable_Test		: std_logic;
	signal MAR_High_Output_To_Memory_Enable_Test		: std_logic;
	signal Memory_Read_Enable_Test				: std_logic;
	signal Memory_Write_Enable_Test				: std_logic;
	signal IR_Input_Enable_Test				: std_logic;
	signal Increment_PC_Test				: std_logic;
	signal A_Reg_Input_Enable_Test				: std_logic;
	signal X_Reg_Input_Enable_Test				: std_logic;
	signal Y_Reg_Input_Enable_Test				: std_logic;
	signal A_Reg_Output_Enable_Test				: std_logic;
	signal X_Reg_Output_Enable_Test				: std_logic;
	signal Y_Reg_Output_Enable_Test				: std_logic;

begin
    -- Instantiate the Instruction_Decoder module
    UUT: Instruction_Decoder
        port map (
            	Instruction					=> Instruction_Test,
		FSM_In						=> FSM_In_Test,

		FSM_Out						=> FSM_Out_Test,
		MAR_Low_Input_Enable				=> MAR_Low_Input_Enable_Test,
		MAR_High_Input_Enable   	 		=> MAR_High_Input_Enable_Test,
		PC_Low_Output_Enable				=> PC_Low_Output_Enable_Test,
		PC_High_Output_Enable   	 		=> PC_High_Output_Enable_Test,
		MAR_Low_Output_To_Memory_Enable			=> MAR_Low_Output_To_Memory_Enable_Test,
		MAR_High_Output_To_Memory_Enable		=> MAR_High_Output_To_Memory_Enable_Test,
		Memory_Read_Enable				=> Memory_Read_Enable_Test,
		Memory_Write_Enable				=> Memory_Write_Enable_Test,
		IR_Input_Enable					=> IR_Input_Enable_Test,
		Increment_PC					=> Increment_PC_Test,
		A_Reg_Input_Enable				=> A_Reg_Input_Enable_Test,
		X_Reg_Input_Enable				=> X_Reg_Input_Enable_Test,
		Y_Reg_Input_Enable				=> Y_Reg_Input_Enable_Test,
		A_Reg_Output_Enable				=> A_Reg_Output_Enable_Test,
		X_Reg_Output_Enable				=> X_Reg_Output_Enable_Test,
		Y_Reg_Output_Enable				=> Y_Reg_Output_Enable_Test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin

	report "************** TESTS FOR INITIAL FETCH AND LOAD INSTRUCTION ***************";

	report "Running Tests for '00000000' set Step 0 Initial State (No Action)";

        FSM_In_Test	<= "00000000";
        wait for 10 ns;

	assert FSM_Out_Test = "00000001"	report "Step 0: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for '00000001' set Step 1 Fetch Instruction and Increment PC";

        FSM_In_Test	<= "00000001";
        wait for 10 ns;

	assert PC_Low_Output_Enable_Test = '1'	report "Step 1: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert PC_High_Output_Enable_Test = '1'	report "Step 1: PC_High_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Step 1: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Step 1: Increment_PC_Test should equal 1" severity error;
	assert IR_Input_Enable_Test = '1'	report "Step 1: IR_Input_Enable_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000010"	report "Step 1: FSM_Out_Test should equal 00000010" severity error;

	report "************ TESTS FOR SUBROUTINE: Load Register with Immediate Value, FSM 00000010 ************";
	
	report "Running Tests for Load Register with Immediate Value Step One: Load A Register with value from memory, and increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "00010001";
        wait for 10 ns;
	
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One A Reg: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert PC_High_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One A Reg: PC_High_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register with Immediate Value Step One A Reg: Memory_Read_Enable_Test should equal 1" severity error;
	assert A_Reg_Input_Enable_Test = '1'	report "Load Register with Immediate Value Step One A Reg: A_Reg_Input_Enable should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register with Immediate Value Step Two: Increment_PC_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000001"	report "Load Register with Immediate Value Step One A Reg: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register with Immediate Value Step One: Load X Register with value from memory, and increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "00010010";
        wait for 10 ns;
	
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One X Reg: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert PC_High_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One X Reg: PC_High_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register with Immediate Value Step One X Reg: Memory_Read_Enable_Test should equal 1" severity error;
	assert X_Reg_Input_Enable_Test = '1'	report "Load Register with Immediate Value Step One X Reg: X_Reg_Input_Enable should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register with Immediate Value Step Two: Increment_PC_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000001"	report "Load Register with Immediate Value Step One X Reg: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register with Immediate Value Step One: Load Y Register with value from memory, and increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "00010011";
        wait for 10 ns;
	
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One Y Reg: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert PC_High_Output_Enable_Test = '1'	report "Load Register with Immediate Value Step One Y Reg: PC_High_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register with Immediate Value Step One Y Reg: Memory_Read_Enable_Test should equal 1" severity error;
	assert Y_Reg_Input_Enable_Test = '1'	report "Load Register with Immediate Value Step One Y Reg: Y_Reg_Input_Enable should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register with Immediate Value Step Two: Increment_PC_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000001"	report "Load Register with Immediate Value Step One Y Reg: FSM_Out_Test should equal 00000001" severity error;

	report "************ TESTS FOR SUBROUTINE: Load Register with Absolute Value Subroutine, FSM 00000010 to 00000011 ************";

	report "Running Tests for Load Register with Absolute Value Step One: Load MAR (High) and Increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "00100001";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Load Register with Absolute Value Step One: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Absolute Value Step One: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register with Absolute Value Step One: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'	report "Load Register with Absolute Value Step One: Increment_PC_Test should equal 1" severity error;
	assert MAR_High_Input_Enable_Test = '1'	report "Load Register with Absolute Value Step One: MAR_High_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000011"	report "Load Register with Absolute Value Step One: FSM_Out_Test should equal 00000011" severity error;

	report "Running Tests for Load Register with Absolute Value Step Two: Load MAR (Low) and Increment PC";
	FSM_In_Test	<= "00000011";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Load Register with Absolute Value Step Two: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Absolute Value Step Two: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register with Absolute Value Step Two: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register with Absolute Value Step Two: Increment_PC_Test should equal 1" severity error;
	assert MAR_Low_Input_Enable_Test = '1'	report "Load Register with Absolute Value Step Two: MAR_Low_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000100"	report "Load Register with Absolute Value Step Two: FSM_Out_Test should equal 00000100" severity error;

	report "Running Tests for Load Register with Absolute Value Step Three: Load A Reg from Memory";
	FSM_In_Test	<= "00000100";
	Instruction_Test <= "00100001";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDA: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDA: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDA: Memory_Read_Enable_Test should equal 1" severity error;
	assert A_Reg_Input_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDA: A_Reg_Input_Enable should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register with Absolute Value Step Three LDA: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register with Absolute Value Step Three: Load X Reg from Memory";
	FSM_In_Test	<= "00000100";
	Instruction_Test <= "00100010";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDX: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDX: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDX: Memory_Read_Enable_Test should equal 1" severity error;
	assert X_Reg_Input_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDX: X_Reg_Input_Enable should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register with Absolute Value Step Three LDX: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register with Absolute Value Step Three: Load Y Reg from Memory";
	FSM_In_Test	<= "00000100";
	Instruction_Test <= "00100011";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDY: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register with Absolute Value Step Three LDY: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDY: Memory_Read_Enable_Test should equal 1" severity error;
	assert Y_Reg_Input_Enable_Test = '1'			report "Load Register with Absolute Value Step Three LDY: Y_Reg_Input_Enable should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register with Absolute Value Step Three LDY: FSM_Out_Test should equal 00000001" severity error;

	report "************ TESTS FOR SUBROUTINE: Load Register to Absolute Memory Address Subroutine, FSM 00000010, 00000101 - 00000110 ************";

	report "Running Tests for Load Register to Absolute Memory Address Step One: Load MAR (High) and Increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "01000001";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step One: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step One: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step One: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register to Absolute Memory Address Step One: Increment_PC_Test should equal 1" severity error;
	assert MAR_High_Input_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step One: MAR_High_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000101"	report "Load Register to Absolute Memory Address Step One: FSM_Out_Test should equal 00000101" severity error;

	report "Running Tests for Load Register to Absolute Memory Address Step Two: Load MAR (Low) and Increment PC";
	FSM_In_Test	<= "00000101";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step Two: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step Two: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step Two: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Load Register to Absolute Memory Address Step Two: Increment_PC_Test should equal 1" severity error;
	assert MAR_Low_Input_Enable_Test = '1'	report "Load Register to Absolute Memory Address Step Two: MAR_Low_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000110"	report "Load Register to Absolute Memory Address Step Two: FSM_Out_Test should equal 00000110" severity error;

	report "Running Tests for Load Register to Absolute Memory Addres Step Three: Load A to Memory";
	FSM_In_Test	<= "00000110";
	Instruction_Test <= "01000001";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STA: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STA: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Write_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STA: Memory_Write_Enable_Test should equal 1" severity error;
	assert A_Reg_Output_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STA: A_Reg_Output_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register to Absolute Memory Addres Step Three STA: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register to Absolute Memory Addres Step Three: Load X to Memory";
	FSM_In_Test	<= "00000110";
	Instruction_Test <= "01000010";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STX: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STX: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Write_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STX: Memory_Write_Enable_Test should equal 1" severity error;
	assert X_Reg_Output_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STX: X_Reg_Output_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register to Absolute Memory Addres Step Three STX: FSM_Out_Test should equal 00000001" severity error;

	report "Running Tests for Load Register to Absolute Memory Addres Step Three: Load Y to Memory";
	FSM_In_Test	<= "00000110";
	Instruction_Test <= "01000011";
	
        wait for 10 ns;
	
	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STY: MAR_Low_Output_To_Memory_Enable should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Load Register to Absolute Memory Addres Step Three STY: MAR_High_Output_To_Memory_Enable should equal 1" severity error;
	assert Memory_Write_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STY: Memory_Write_Enable_Test should equal 1" severity error;
	assert Y_Reg_Output_Enable_Test = '1'			report "Load Register to Absolute Memory Addres Step Three STY: Y_Reg_Output_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000001"			report "Load Register to Absolute Memory Addres Step Three STY: FSM_Out_Test should equal 00000001" severity error;

	report "************ TESTS FOR SUBROUTINE: Unconditional Jump to Absolute Address, FSM 00000010, 00000111 - 00001000 ************";

	report "Running Tests for Unconditional Jump to Absolute Address Step One: Load MAR (High) and Increment PC";
	FSM_In_Test	<= "00000010";
	Instruction_Test <= "01100000";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step One: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step One: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step One: Memory_Read_Enable_Test should equal 1" severity error;
	assert Increment_PC_Test = '1'		report "Unconditional Jump to Absolute Address Step One: Increment_PC_Test should equal 1" severity error;
	assert MAR_High_Input_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step One: MAR_High_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000111"	report "Unconditional Jump to Absolute Address Step One: FSM_Out_Test should equal 00000111" severity error;

	report "Running Tests for Unconditional Jump to Absolute Address Step Two: Load MAR (Low)";
	FSM_In_Test	<= "00000111";
        wait for 10 ns;
	
	assert PC_High_Output_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step Two: PC_High_Output_Enable_Test should equal 1" severity error;
	assert PC_Low_Output_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step Two: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step Two: Memory_Read_Enable_Test should equal 1" severity error;
	assert MAR_Low_Input_Enable_Test = '1'	report "Unconditional Jump to Absolute Address Step Two: MAR_High_Input_Enable_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00001000"	report "Unconditional Jump to Absolute Address Step Two: FSM_Out_Test should equal 00001000" severity error;


        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;