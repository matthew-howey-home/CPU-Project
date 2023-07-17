

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
            E			: in std_logic;        			-- Enable input
            Q			: out std_logic_vector(7 downto 0);     -- Output Q
            Q_Complement	: out std_logic_vector(7 downto 0)	-- Output Q complement
        );
    end component Eight_Bit_D_Latch;

    -- Signal declarations
    signal D_Test		: std_logic_vector(7 downto 0); 
    signal E_Test		: std_logic;
    signal Q_Test		: std_logic_vector(7 downto 0); 
    signal Q_Complement_Test	: std_logic_vector(7 downto 0); 

begin
    -- Instantiate the 8 bit D Latch
    UUT: Eight_Bit_D_Latch port map (
        D		=> D_Test,
        E		=> E_Test,
        Q		=> Q_Test,
        Q_Complement	=> Q_Complement_Test
    );

    -- Stimulus process
    stim_proc: process
    begin
	-- Initialise Quiescent state (Enable switched off)
 	E_Test	<= '0';

        wait for 10 ns;
        -- ****** 1: Test input

	-- Set Data
	D_Test	<= "10110101";
        wait for 10 ns;

	-- Enable
	E_Test	<= '1';
        wait for 10 ns;

	-- Return to Quiescent state (Enable switched off)
	E_Test	<= '0';
        wait for 10 ns;

	-- Remove data input
	D_Test 	<= "ZZZZZZZZ";


	report "Test content of Latch following output";
        assert Q_Test			= "10110101"	report "Error: Q_Test should be '10110101'." severity error;
        assert Q_Complement_Test	= "01001010"	report "Error: Q_Complement_Test should be '01001010'." severity error;

        -- End simulation
        wait;
    end process stim_proc;

end architecture behavior;