
library ieee;
use ieee.std_logic_1164.all;

entity Eight_Bit_Register is
    port (
        Data_Input	: in std_logic_vector(7 downto 0);
        Input_Enable	: in std_logic;
	Clock		: in std_logic;
	Output_Enable	: in std_logic;

        Output		: out std_logic_vector(7 downto 0)
    );
end entity Eight_Bit_Register;

architecture Behavioral of Eight_Bit_Register is
	signal internal_state		: std_logic_vector(7 downto 0);
	signal internal_output		: std_logic_vector(7 downto 0);
begin
	Flip_Flop_0: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(0),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(0)
        	);

	Flip_Flop_1: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(1),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(1)
        	);

	Flip_Flop_2: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(2),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(2)
        	);

	Flip_Flop_3: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(3),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(3)
        	);

	Flip_Flop_4: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(4),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(4)
        	);

	Flip_Flop_5: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(5),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(5)
        	);

	Flip_Flop_6: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(6),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(6)
        	);

	Flip_Flop_7: entity work.Edge_Triggered_Flip_Flop
       		port map (
			-- input
   			Data_Input	=> Data_Input(7),
       			Input_Enable	=> Input_Enable,
			Clock		=> Clock,
       			-- output
			Output		=> internal_state(7)
        	);

	
	
	Eight_Bit_Tristate_Buffer: entity work.Eight_Bit_Tristate_Buffer
        	port map (
            		input	=> 	internal_state,
            		enable	=> 	Output_Enable,
            		output  =>	internal_output
        	);
	 -- Output
	 Output	 	<= internal_output;
end architecture Behavioral;