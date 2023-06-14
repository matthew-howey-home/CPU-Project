
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SUB_Component_TB is
end entity SUB_Component_TB;

architecture Behavioral of SUB_Component_TB is
    -- Component declaration for the SUB_Component module
    component SUB_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            b       : in  std_logic_vector(7 downto 0);
	    borrow_in: in std_logic;
            diff: out std_logic_vector(7 downto 0);  -- Output
    	    borrow_out: out std_logic  -- Borrow output
        );
    end component SUB_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal b_tb    : std_logic_vector(7 downto 0);
    signal diff_tb    : std_logic_vector(7 downto 0);
    signal borrow_in_tb : std_logic;
    signal borrow_out_tb : std_logic;

begin
    -- Instantiate the AND_Component module
    UUT: SUB_Component
        port map (
            a       => a_tb,
            b       => b_tb,
	    borrow_in => borrow_in_tb,
            diff => diff_tb,
            borrow_out    => borrow_out_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for SUB Component";

        -- Test case 1
        a_tb <= "11111111";
        b_tb <= "11111111";
	borrow_in_tb <= '0';
        wait for 10 ns;

	report "Running Test case 1";
	assert diff_tb = "00000000" report "Test 1: diff_tb should equal 00000000" severity error;
	assert borrow_out_tb = '0' report "Test 1: borrow_tb should equal 0" severity error;

	-- Test case 2
        a_tb <= "11111111";
        b_tb <= "00000000";
	borrow_in_tb <= '0';
        wait for 10 ns;

	report "Running Test case 2";
	assert diff_tb = "11111111" report "Test 2: diff_tb should equal 11111111" severity error;
	assert borrow_out_tb = '0' report "Test 2: borrow_tb should equal 0" severity error;

	-- Test case 3
        a_tb <= "00000000";
        b_tb <= "00000001";
	borrow_in_tb <= '0';
        wait for 10 ns;

	report "Running Test case 3";
	assert diff_tb = "11111111" report "Test 3: diff_tb should equal 11111111" severity error;
	assert borrow_out_tb = '1' report "Test 3: borrow_tb should equal 1" severity error;

	-- Test case 4
        a_tb <= "01110001";
        b_tb <= "01011000";
	borrow_in_tb <= '0';
        wait for 10 ns;

	report "Running Test case 4";
	assert diff_tb = "00011001" report "Test 4: diff_tb should equal 00011001" severity error;
	assert borrow_out_tb = '0' report "Test 4: borrow_tb should equal 0" severity error;

	-- Test case 5
        a_tb <= "00001100";
        b_tb <= "11001001";
	borrow_in_tb <= '0';
        wait for 10 ns;

	report "Running Test case 5";
	assert diff_tb = "01000011" report "Test 5: diff_tb should equal 01000011" severity error;
	assert borrow_out_tb = '1' report "Test 5: borrow_tb should equal 1" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
