
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
		MDR_Input_Enable			: out std_logic;
		MDR_Output_Enable			: out std_logic;
		IR_Input_Enable				: out std_logic;
		Increment_PC				: out std_logic
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
	signal MDR_Input_Enable_Test				: std_logic;
	signal MDR_Output_Enable_Test				: std_logic;
	signal IR_Input_Enable_Test				: std_logic;
	signal Increment_PC_Test				: std_logic;

begin
    -- Instantiate the Instruction_Decoder module
    UUT: Instruction_Decoder
        port map (
            	Instruction				=> Instruction_Test,
		FSM_In					=> FSM_In_Test,

		FSM_Out					=> FSM_Out_Test,
		MAR_Low_Input_Enable			=> MAR_Low_Input_Enable_Test,
		MAR_High_Input_Enable   	 	=> MAR_High_Input_Enable_Test,
		PC_Low_Output_Enable			=> PC_Low_Output_Enable_Test,
		PC_High_Output_Enable   	 	=> PC_High_Output_Enable_Test,
		MAR_Low_Output_To_Memory_Enable		=> MAR_Low_Output_To_Memory_Enable_Test,
		MAR_High_Output_To_Memory_Enable	=> MAR_High_Output_To_Memory_Enable_Test,
		Memory_Read_Enable			=> Memory_Read_Enable_Test,
		MDR_Input_Enable			=> MDR_Input_Enable_Test,
		MDR_Output_Enable			=> MDR_Output_Enable_Test,
		IR_Input_Enable				=> IR_Input_Enable_Test,
		Increment_PC				=> Increment_PC_Test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for '00000001' set Step 1 Load MAR (low)";

        FSM_In_Test	<= "00000001";
        wait for 10 ns;

	assert PC_Low_Output_Enable_Test = '1'	report "Step 1: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert MAR_Low_Input_Enable_Test = '1'	report "Step 1: MAR_Low_Input_Enable_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000010"	report "Step 1: FSM_Out_Test should equal 00000010" severity error;

	report "Running Tests for '00000010' set Step 2 Load MAR (high)";

        FSM_In_Test	<= "00000010";
        wait for 10 ns;

	assert PC_High_Output_Enable_Test = '1'	report "Step 2: PC_High_Output_Enable_Test should equal 1" severity error;
	assert MAR_High_Input_Enable_Test = '1'	report "Step 2: MAR_High_Input_Enable_Test should equal 1" severity error;
	assert FSM_Out_Test = "00000011"	report "Step 2: FSM_Out_Test should equal 00000011" severity error;

	report "Running Tests for '00000011' set Step 3 Fetch Instruction";

        FSM_In_Test	<= "00000011";
        wait for 10 ns;

	assert MAR_Low_Output_To_Memory_Enable_Test = '1'	report "Step 3: MAR_Low_Output_To_Memory_Enable_Test should equal 1" severity error;
	assert MAR_High_Output_To_Memory_Enable_Test = '1'	report "Step 3: MAR_High_Output_To_Memory_Enable_Test should equal 1" severity error;
	assert Memory_Read_Enable_Test = '1'			report "Step 3: Memory_Read_Enable_Test should equal 1" severity error;
	assert MDR_Input_Enable_Test = '1'			report "Step 3: MDR_Input_Enable_Test should equal 1" severity error;

	assert FSM_Out_Test = "00000100"			report "Step 3: FSM_Out_Test should equal 00000100" severity error;

	report "Running Tests for '00000101' set Step 5 Increment PC";
	FSM_In_Test	<= "00000101";
        wait for 10 ns;

	assert Increment_PC_Test = '1'			report "Step 5: Increment_PC_Test should equal 1" severity error;
	
	assert FSM_Out_Test = "00000110"		report "Step 5: FSM_Out_Test should equal 00000110" severity error;

	report "Running Tests for Branch to Load Register with Absolute Value";
	FSM_In_Test	<= "00000110";
	Instruction_Test <= "00010101"; -- instruction needs to be 0001xxxx
        wait for 10 ns;

	assert FSM_Out_Test = "00000111"		report "Branch to Load Register with Absolute Value: FSM_Out_Test should equal 00000111" severity error;

	-- ************ Tests for Load Register with Absolute Value Subroutine, FSM 00000111 to xxxxxxxx ************
	
	report "Running Tests for Load Register with Absolute Value Step One: Load MAR (Low)";
	FSM_In_Test	<= "00000111";
        wait for 10 ns;
	
	assert PC_Low_Output_Enable_Test = '1'	report "Load Register with Absolute Value Step One: PC_Low_Output_Enable_Test should equal 1" severity error;
	assert MAR_Low_Input_Enable_Test = '1'	report "Load Register with Absolute Value Step One: MAR_Low_Input_Enable_Test should equal 1" severity error;
	assert FSM_Out_Test = "00001000"	report "Load Register with Absolute Value Step One: FSM_Out_Test should equal 00001000" severity error;
        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;