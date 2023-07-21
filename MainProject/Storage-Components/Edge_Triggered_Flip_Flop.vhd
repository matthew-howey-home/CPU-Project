

library ieee;
use ieee.std_logic_1164.all;

entity Edge_Triggered_Flip_Flop is
    port (
        Data_Input	: in std_logic;
        Input_Enable	: in std_logic;
	Clock		: in std_logic;
        Output		: out std_logic
    );
end entity Edge_Triggered_Flip_Flop;

architecture Behavioral of Edge_Triggered_Flip_Flop is
    signal Latch_A_Output		: std_logic;
    signal Latch_B_Output		: std_logic;
    signal Not_Clock			: std_logic;
    signal Mux_Output			: std_logic;
 
begin

    Not_Clock <= not Clock;
    
    Two_to_One_Mux: entity work.Two_to_One_Mux
	port map (
	    -- If Enable is off, feed output of Flip Flop back in to maintain current value
	    -- If Enable is on, feed in external Data input
	    -- inputs
	    input_1	=> Latch_B_Output,
	    input_2	=> Data_Input,
            selector	=> Input_Enable,
	    -- output
	    output      => Mux_Output
        );

    Latch_A: entity work.D_Latch
        port map (
	    -- inputs
            Data_Input		=> Mux_Output,
            Input_Enable 	=> Not_Clock,
	    -- output
	    Output		=> Latch_A_Output
        );

    Latch_B: entity work.D_Latch
        port map (
	    -- inputs
            Data_Input		=> Latch_A_Output,
            Input_Enable 	=> Clock,
	    -- output
	    Output		=> Latch_B_Output
	);
    
    -- Final output of Edge Triggered Flip Flop
    Output 	<= Latch_B_Output;

end architecture Behavioral;