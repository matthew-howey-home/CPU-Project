

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ALU_Interface_Test is
end entity ALU_Interface_Test;

architecture Behavioral of ALU_Interface_Test is
    -- Component declaration for the ALU_Interface module
    component ALU_Interface
       port (
		Clock					: in std_logic;
       
		-- main inputs
		Opcode  				: in std_logic_vector(2 downto 0);
		Input_Operand_1				: in std_logic_vector(7 downto 0);
        	Input_Operand_2				: in std_logic_vector(7 downto 0);
		Input_Carry				: in std_logic;
		Input_Negative				: in std_logic;
		
		-- Enable Controls
		Enable_Input_For_Temp_Input_Reg		: in std_logic;
		Enable_Operation			: in std_logic;
		Enable_Output_Final			: in std_logic;
	
		-- Other Control Signals

		Control_Clear_Carry			: in std_logic;
		Control_Clear_Negative			: in std_logic;
		Control_Clear_Zero			: in std_logic;

		-- Final Outputs
		Output_Final				: out std_logic_vector(7 downto 0);
		Output_From_Carry_Flag			: out std_logic;
		Output_From_Negative_Flag		: out std_logic
    	);
    end component ALU_Interface;

	-- Signal declarations
    	signal Clock_Test				: std_logic;
       
	-- main inputs
	signal Opcode_Test  				: std_logic_vector(2 downto 0);
	signal Input_Operand_1_Test			: std_logic_vector(7 downto 0);
    	signal Input_Operand_2_Test			: std_logic_vector(7 downto 0);
	signal Input_Carry_Test				: std_logic;
	signal Input_Negative_Test			: std_logic;
	
	-- Enable Controls
	signal Enable_Input_For_Temp_Input_Reg_Test	: std_logic;
	signal Enable_Operation_Test			: std_logic;
	signal Enable_Output_Final_Test			: std_logic;
	
	-- Other Control Signals
	signal Control_Clear_Carry_Test			: std_logic;
	signal Control_Clear_Negative_Test		: std_logic;
	signal Control_Clear_Zero_Test			: std_logic;

	-- Final Outputs
	signal Output_Final_Test			: std_logic_vector(7 downto 0);
	signal Output_From_Carry_Flag_Test		: std_logic;
	signal Output_From_Negative_Flag_Test		: std_logic;

begin

   -- Instantiate the ALU_Interface module
    UUT: ALU_Interface
        port map (
            	Clock					=> Clock_Test,
       
		-- main inputs
		Opcode  				=> Opcode_Test,
		Input_Operand_1				=> Input_Operand_1_Test,
        	Input_Operand_2				=> Input_Operand_2_Test,
		Input_Carry				=> Input_Carry_Test,
		Input_Negative				=> Input_Negative_Test,
	
		-- Enable Controls
		Enable_Input_For_Temp_Input_Reg		=> Enable_Input_For_Temp_Input_Reg_Test,
		Enable_Operation			=> Enable_Operation_Test,
		Enable_Output_Final			=> Enable_Output_Final_Test,
	
		-- Other Control Signals
		Control_Clear_Carry			=> Control_Clear_Carry_Test,
		Control_Clear_Negative			=> Control_Clear_Negative_Test,
		Control_Clear_Zero			=> Control_Clear_Zero_Test,

		-- Final Outputs
		Output_Final				=> Output_Final_Test,
		Output_From_Carry_Flag			=> Output_From_Carry_Flag_Test,
		Output_From_Negative_Flag		=> Output_From_Negative_Flag_Test
    	);



    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	-- ################## Operation 1 - AND 01011011 with 11001010
	
	-- Load Temp Input Reg with first operand	
	Clock_Test <= '0';
	Input_Operand_1_Test			<= "01011011";
	Enable_Input_For_Temp_Input_Reg_Test	<= '1';
	wait for 10 ns;
	Clock_Test <= '1';
	wait for 10 ns;

	-- clear inputs / controls
	Enable_Input_For_Temp_Input_Reg_Test 	<= '0';
	Input_Operand_1_Test 			<= "ZZZZZZZZ";
	
	-- Set second operand and opcode, and enable operation
	Clock_Test <= '0';
	Input_Operand_2_Test 	<= "11001010";
	Opcode_Test 		<= "000"; -- opcode for AND
	Enable_Operation_Test 	<= '1';
	wait for 10 ns;
	Clock_Test <= '1';
	wait for 10 ns;

	-- clear inputs / controls
	Enable_Operation_Test 	<= '0';
	Input_Operand_2_Test 	<= "ZZZZZZZZ";
	
	-- Output Result
	Clock_Test <= '0';
	Enable_Output_Final_Test <= '1';
	wait for 10 ns;
	
	report "Running Test 1: AND 01011011 with 11001010";
	assert Output_Final_Test = "01001010" report "Test 1: output_test should equal 01001010" severity error;

	Clock_Test <= '1';
	wait for 10 ns;

	-- clear inputs / controls
	Enable_Output_Final_Test 	<= '0';
	
	-- ################## Operation 2 - ADD 11011011 with 11001010
	-- Load Temp Input Reg with first operand
	Clock_Test 				<= '0';
	Input_Operand_1_Test			<= "11011011";
	Enable_Input_For_Temp_Input_Reg_Test	<= '1';
	wait for 10 ns;
	Clock_Test <= '1';
	wait for 10 ns;

	-- clear inputs / controls
	Enable_Input_For_Temp_Input_Reg_Test 	<= '0';
	Input_Operand_1_Test 			<= "ZZZZZZZZ";

	-- Set second operand and opcode, and enable operation
	Clock_Test <= '0';
	Input_Operand_2_Test 	<= "11001010";
	Opcode_Test 		<= "110"; -- opcode for ADD
	Enable_Operation_Test 	<= '1';
	wait for 10 ns;
	Clock_Test <= '1';
	wait for 10 ns;
	
	-- clear previous
	Enable_Operation_Test 	<= '0';
	Input_Operand_2_Test 	<= "ZZZZZZZZ";
	Opcode_Test 		<= "000"; 

	-- Output Result
	Clock_Test <= '0';
	Enable_Output_Final_Test <= '1';
	wait for 10 ns;
	
	report "Running Test 2: ADD 11011011 to 11001010";
	assert Output_Final_Test = "10001001" report "Test 2: Output_Final_Test should equal 10001001" severity error;
	assert Output_From_Carry_Flag_Test = '1' report "Test 2: Output_From_Carry_Flag_Test should equal 1" severity error;

	wait;

    end process stimulus_proc;

end architecture Behavioral;