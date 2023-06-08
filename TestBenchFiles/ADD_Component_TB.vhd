library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ADD_Component_TB is
end entity ADD_Component_TB;

architecture Behavioral of ADD_Component_TB is
    -- Component declaration for the AND_Component module
    component ADD_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            b       : in  std_logic_vector(7 downto 0);
	    cin	    : in std_logic;
            sum       : out std_logic_vector(7 downto 0);
	    cout    : out std_logic
        );
    end component ADD_Component;

    -- Signal declarations
    signal CIN_TB: std_logic;
    signal A_TB    : std_logic_vector(7 downto 0);
    signal B_TB    : std_logic_vector(7 downto 0);
    signal SUM_TB    : std_logic_vector(7 downto 0);
    signal COUT_TB : std_logic;

begin
    -- Instantiate the ADD_Component module
    UUT: ADD_Component
        port map (
	    cin     => CIN_TB,
            a       => A_TB,
            b       => B_TB,
            sum       => SUM_TB,
            cout    => COUT_TB
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for ADD Component";

        -- Test case 1
	CIN_TB <= '0';
        A_TB <= "00101011";
        B_TB <= "11011010";
        wait for 10 ns;
	
	report "Running Test case 1";
	assert SUM_TB = "00000101" report "Test 1: SUM_TB should equal 00000101" severity error;
	assert COUT_TB = '1' report "COUT_TB should equal 1" severity error;

        -- Test case 2
	CIN_TB <= '1';
        A_TB <= "10011101";
        B_TB <= "01100101";
        wait for 10 ns;

	report "Running Test case 2";
	assert SUM_TB = "00000011" report "Test 2: SUM_TB should equal 00000011" severity error;
	assert COUT_TB = '1' report "COUT_TB should equal 1" severity error;


        -- Test case 3
	CIN_TB <= '0';
        A_TB <= "11110000";
        B_TB <= "00001111";
        wait for 10 ns;

	report "Running Test case 3";
	assert SUM_TB = "11111111" report "Test 3: SUM_TB should equal 11111111" severity error;
	assert COUT_TB = '0' report "COUT_TB should equal 0" severity error;


	-- Test case 4
	CIN_TB <= '1';
        A_TB <= "01010101";
        B_TB <= "10101010";
        wait for 10 ns;

	report "Running Test case 4";
	assert SUM_TB = "00000000" report "Test 4: SUM_TB should equal 00000000" severity error;
	assert COUT_TB = '1' report "COUT_TB should equal 1" severity error;


	-- Test case 5
	CIN_TB <= '0';
        A_TB <= "11111111";
        B_TB <= "11111111";
        wait for 10 ns;

	report "Running Test case 5";
	assert SUM_TB = "11111110" report "Test 5: SUM_TB should equal 11111110" severity error;
	assert COUT_TB = '1' report "COUT_TB should equal 1" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

