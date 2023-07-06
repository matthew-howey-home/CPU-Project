
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SHL_Component_Test is
end entity SHL_Component_Test;

architecture Behavioral of SHL_Component_Test is
    -- Component declaration for the SHL_Component module
    component SHL_Component
        port (
            input	: in  std_logic_vector(7 downto 0);
            output	: out std_logic_vector(7 downto 0)
        );
    end component SHL_Component;

    -- Signal declarations
    signal input_test    : std_logic_vector(7 downto 0);
    signal output_test    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the SHL_Component module
    UUT: SHL_Component
        port map (
            input	=> input_test,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	
	report "Running Tests for SHL Component";

        -- Test case 1
        input_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert output_test = "00000000"		report "output_test should equal 00000000" severity error;

        -- Test case 2
        input_test <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert output_test = "11111110"		report "output_test should equal 11111110" severity error;

        -- Test case 3
        input_test <= "10101010";
        wait for 10 ns;

	report "Running Test case 3";
	assert output_test = "01010100"		report "output_test should equal 01010100" severity error;

	-- Test case 4
        input_test <= "01010101";
        wait for 10 ns;

	report "Running Test case 4";
	assert output_test = "10101010"		report "output_test should equal 10101010" severity error;

	-- Test case 5
        input_test <= "10110101";
        wait for 10 ns;

	report "Running Test case 5";
	assert output_test = "01101010"		report "output_test should equal 01101010" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;