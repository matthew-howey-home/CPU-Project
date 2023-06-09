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
    signal cin_tb: std_logic;
    signal a_tb   : std_logic_vector(7 downto 0);
    signal b_tb    : std_logic_vector(7 downto 0);
    signal sum_tb    : std_logic_vector(7 downto 0);
    signal cout_tb : std_logic;

begin
    -- Instantiate the ADD_Component module
    UUT: ADD_Component
        port map (
	    cin     => cin_tb,
            a       => a_tb,
            b       => b_tb,
            sum       => sum_tb,
            cout    => cout_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for ADD Component";

        -- Test case 1
	cin_tb <= '0';
        a_tb <= "00101011";
        b_tb <= "11011010";
        wait for 10 ns;
	
	report "Running Test case 1";
	assert sum_tb = "00000101" report "Test 1: SUM_TB should equal 00000101" severity error;
	assert cout_tb = '1' report "COUT_TB should equal 1" severity error;

        -- Test case 2
	cin_tb <= '1';
        a_tb <= "10011101";
        b_tb <= "01100101";
        wait for 10 ns;

	report "Running Test case 2";
	assert sum_tb = "00000011" report "Test 2: SUM_TB should equal 00000011" severity error;
	assert cout_tb = '1' report "COUT_TB should equal 1" severity error;


        -- Test case 3
	cin_tb <= '0';
        a_tb <= "11110000";
        b_tb <= "00001111";
        wait for 10 ns;

	report "Running Test case 3";
	assert sum_tb = "11111111" report "Test 3: SUM_TB should equal 11111111" severity error;
	assert cout_tb = '0' report "COUT_TB should equal 0" severity error;


	-- Test case 4
	cin_tb <= '1';
        a_tb <= "01010101";
        b_tb <= "10101010";
        wait for 10 ns;

	report "Running Test case 4";
	assert sum_tb = "00000000" report "Test 4: SUM_TB should equal 00000000" severity error;
	assert cout_tb = '1' report "COUT_TB should equal 1" severity error;


	-- Test case 5
	cin_tb <= '0';
        a_tb <= "11111111";
        b_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 5";
	assert sum_tb = "11111110" report "Test 5: SUM_TB should equal 11111110" severity error;
	assert cout_tb = '1' report "COUT_TB should equal 1" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

