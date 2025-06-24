

-- TestBench for 8 bit D Latch

library ieee;
use ieee.std_logic_1164.all;

entity Eight_Bit_Register_Test is
end entity Eight_Bit_Register_Test;

architecture behavior of Eight_Bit_Register_Test is
    -- Component declaration for the 8 bit D Latch
    component Eight_Bit_Register is
        port (
	    -- inputs            
	    Data_Input		: in std_logic_vector(7 downto 0);
            Input_Enable	: in std_logic;
	    Clock		: in std_logic;
	    Output_Enable	: in std_logic;
	    
            -- output
            Output		: out std_logic_vector(7 downto 0)
        );
    end component Eight_Bit_Register;

    -- Signal declarations
    signal Data_Input_Test	: std_logic_vector(7 downto 0); 
    signal Input_Enable_Test	: std_logic;
    signal Clock_Test		: std_logic; 
    signal Output_Enable_Test	: std_logic;
    signal Output_Test		: std_logic_vector(7 downto 0); 

begin
    -- Instantiate the 8 bit D Latch
    UUT: Eight_Bit_Register port map (
        Data_Input	=> Data_Input_Test,
        Input_Enable	=> Input_Enable_Test,
	Clock		=> Clock_Test,
	Output_Enable	=> Output_Enable_Test,
        Output		=> Output_Test
    );

     -- Stimulus process
    stim_proc: process
    begin
	report "Running Edge Triggered Flip Flop tests";
	
	Data_Input_Test		<= "11010101";
	Input_Enable_Test	<= '1';
	Clock_Test		<= '0';

	wait for 10 ns;

	-- Output should now be change to 1 on rising edge
	Clock_Test		<= '1';
	Output_Enable_Test	<= '1'; -- this means enable output

	wait for 10 ns;

	report "Running Test 1: Output should be set to 11010101 on rising edge";
	assert Output_Test = "11010101"	report "Error: Output_Test should be '11010101'." severity error;

	Clock_Test	<= '0';
	
	-- now set Data to 0 but Enable is Off, it should maintain output of 11010101
	Data_Input_Test		<= "00000000";
	Input_Enable_Test	<= '0';

	wait for 10 ns;
	
	Clock_Test	<= '1';

	wait for 10 ns;

	report "Running Test 2: Output should remain 1 as input enable is off";
	assert Output_Test = "11010101"	report "Error: Output_Test should be '1'." severity error;

	Data_Input_Test		<= "01110010";
	Input_Enable_Test	<= '1';
	Clock_Test		<= '0';

	wait for 10 ns;

        -- Output should now be change to 0 on rising edge
	Clock_Test	<= '1';

	wait for 10 ns;

	report "Running Test 3: Output should be set to 01110010 on rising edge";
	assert Output_Test = "01110010"	report "Error: Output_Test should be '01110010'." severity error;

	Clock_Test	<= '0';
	
	-- now set Data to 1 but Enable is Off, it should maintain output of 01110010
	Data_Input_Test		<= "11111111";
	Input_Enable_Test	<= '0';

	wait for 10 ns;
	
	Clock_Test	<= '1';

	wait for 10 ns;

	report "Running Test 4: Output should remain 01110010 as input enable is off";
	assert Output_Test = "01110010"	report "Error: Output_Test should be '01110010'." severity error;
	
	Output_Enable_Test <= '0'; -- this switches off output enable

	wait for 10 ns;

	report "Running Test 5: Output should be ZZZZZZZZ as output enable is off";
	assert Output_Test = "ZZZZZZZZ"		report "Error: Output_Test should be 'ZZZZZZZZ'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;