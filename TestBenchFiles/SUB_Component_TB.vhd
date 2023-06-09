
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
            diff: out std_logic_vector(7 downto 0);  -- Output
    	    borrow: out std_logic  -- Borrow output
        );
    end component SUB_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal b_tb    : std_logic_vector(7 downto 0);
    signal diff_tb    : std_logic_vector(7 downto 0);
    signal borrow_tb : std_logic;

begin
    -- Instantiate the AND_Component module
    UUT: SUB_Component
        port map (
            a       => a_tb,
            b       => b_tb,
            diff => diff_tb,
            borrow    => borrow_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for SUB Component";

        -- Test case 1
        a_tb <= "11111111";
        b_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 1";
	assert diff_tb = "00000000" report "Test 1: diff_tb should equal 00000000" severity error;
	assert borrow_tb = '0' report "Test 1: borrow_tb should equal 0" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
