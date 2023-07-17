

-- TestBench for 8 bit D Latch

library ieee;
use ieee.std_logic_1164.all;

entity Eight_Bit_D_Latch_Test is
end entity Eight_Bit_D_Latch_Test;

architecture behavior of Eight_Bit_D_Latch_Test is
    -- Component declaration for the 8 bit D Latch
    component Eight_Bit_D_Latch is
        port (
            D			: in std_logic_vector(7 downto 0);      -- Data
            E			: in std_logic;        			-- Input Enable
	    OE			: in std_logic;				-- Output Enable
            Q			: out std_logic_vector(7 downto 0)      -- Output Q
        );
    end component Eight_Bit_D_Latch;

    -- Signal declarations
    signal D_Test		: std_logic_vector(7 downto 0); 
    signal E_Test		: std_logic;
    signal OE_Test		: std_logic;
    signal Q_Test		: std_logic_vector(7 downto 0); 

begin
    -- Instantiate the 8 bit D Latch
    UUT: Eight_Bit_D_Latch port map (
        D		=> D_Test,
        E		=> E_Test,
	OE		=> OE_Test,
        Q		=> Q_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	-- Initialise Quiescent state (Input enable switched off)
 	E_Test	<= '0';
	OE_Test <= '1'; -- active low

        wait for 10 ns;
        -- ****** 1: Test input

	-- Set Data
	D_Test	<= "10110101";
        wait for 10 ns;

	-- Enable
	E_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Input Enable switched off)
	E_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	D_Test 	<= "ZZZZZZZZ";
 	wait for 10 ns;

	-- Set Output Enable to 0 (= enabled, is active low)
	OE_Test <= '0';
	wait for 10 ns;

	report "Test content of Latch following output";
        assert Q_Test			= "10110101"	report "Error: Q_Test should be '10110101'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;