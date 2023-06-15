
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity NOT_Component_TB is
end entity NOT_Component_TB;

architecture Behavioral of NOT_Component_TB is
    -- Component declaration for the NOT_Component module
    component NOT_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            y       : out std_logic_vector(7 downto 0)
        );
    end component NOT_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal y_tb    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the NOT_Component module
    UUT: NOT_Component
        port map (
            a       => a_tb,
            y       => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for NOT Component";

        -- Test case 1
        a_tb <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert y_tb = "11111111" report "Test 1: y_tb should equal 11111111" severity error;

        -- Test case 2
        a_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert y_tb = "00000000" report "Test 2: y_tb should equal 00000000" severity error;

	-- Test case 3
        a_tb <= "10110101";
        wait for 10 ns;

	report "Running Test case 3";
	assert y_tb = "01001010" report "Test 3: y_tb should equal 01001010" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
