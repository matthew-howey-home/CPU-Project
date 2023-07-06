
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity NOT_Component_Test is
end entity NOT_Component_Test;

architecture Behavioral of NOT_Component_Test is
    -- Component declaration for the NOT_Component module
    component NOT_Component
        port (
            input	: in  std_logic_vector(7 downto 0);
            output	: out std_logic_vector(7 downto 0)
        );
    end component NOT_Component;

    -- Signal declarations
    signal input_test    : std_logic_vector(7 downto 0);
    signal output_test    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the NOT_Component module
    UUT: NOT_Component
        port map (
            input	=> input_test,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for NOT Component";

        -- Test case 1
        input_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert output_test = "11111111"		report "Test 1: output_test should equal 11111111" severity error;

        -- Test case 2
        input_test <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert output_test = "00000000"		report "Test 2: output_test should equal 00000000" severity error;

	-- Test case 3
        input_test <= "10110101";
        wait for 10 ns;

	report "Running Test case 3";
	assert output_test = "01001010"		report "Test 3: output_test should equal 01001010" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
