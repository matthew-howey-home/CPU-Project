

library ieee;
use ieee.std_logic_1164.all;

entity Edge_Triggered_Flip_Flop is
    port (
        D		: in std_logic;        	-- Data input
        E		: in std_logic;        	-- Enable input
	clk		: in std_logic;		-- Clock input
        Q		: out std_logic       	-- Output Q
    );
end entity Edge_Triggered_Flip_Flop;

architecture Behavioral of Edge_Triggered_Flip_Flop is
    signal Latch_A_Output		: std_logic;
    signal Latch_B_Output		: std_logic;
    signal not_clk			: std_logic;
    signal Mux_Output			: std_logic;
 
begin

    not_clk <= not clk;
    
    Two_to_One_Mux: entity work.Two_to_One_Mux
	port map (
	    -- If Enable is off, feed output of Flip Flop back in to maintain current value
	    -- If Enable is on, feed in external Data input (D) 
	    -- inputs
	    input_1	=> Latch_B_Output,
	    input_2	=> D,
            selector	=> E,
	    -- output
	    output      => Mux_Output
        );

    Latch_A: entity work.D_Latch
        port map (
	    -- inputs
            D		=> Mux_Output,
            E 		=> not_clk,
	    -- output
	    Q		=> Latch_A_Output
        );

    Latch_B: entity work.D_Latch
        port map (
	    -- inputs
            D		=> Latch_A_Output,
            E 		=> clk,
	    -- output
	    Q		=> Latch_B_Output
        );

    Q 	<= Latch_B_Output;
end architecture Behavioral;