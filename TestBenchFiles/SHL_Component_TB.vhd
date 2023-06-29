
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SHL_Component_TB is
end entity SHL_Component_TB;

architecture Behavioral of SHL_Component_TB is
    -- Component declaration for the SHL_Component module
    component SHL_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            y       : out std_logic_vector(7 downto 0)
        );
    end component SHL_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal y_tb    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the SHL_Component module
    UUT: SHL_Component
        port map (
            a       => a_tb,
            y       => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	
	report "Running Tests for SHR Component";

        -- Test case 1
        a_tb <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert y_tb = "00000000" report "y_tb should equal 00000000" severity error;

        -- Test case 2
        a_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert y_tb = "11111110" report "y_tb should equal 11111110" severity error;

        -- Test case 3
        a_tb <= "10101010";
        wait for 10 ns;

	report "Running Test case 3";
	assert y_tb = "10101000" report "y_tb should equal 10101000" severity error;

	-- Test case 4
        a_tb <= "01010101";
        wait for 10 ns;

	report "Running Test case 4";
	assert y_tb = "10101010" report "y_tb should equal 10101010" severity error;

	-- Test case 5
        a_tb <= "10110101";
        wait for 10 ns;

	report "Running Test case 5";
	assert y_tb = "01101010" report "y_tb should equal 01101010" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;