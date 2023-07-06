library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity AND_Component_Test is
end entity AND_Component_Test;

architecture Behavioral of AND_Component_Test is
    -- Component declaration for the AND_Component module
    component AND_Component
        port (
            input_1	: in  std_logic_vector(7 downto 0);
            input_2	: in  std_logic_vector(7 downto 0);
            output	: out std_logic_vector(7 downto 0)
        );
    end component AND_Component;

    -- Signal declarations
    signal input_1_test    : std_logic_vector(7 downto 0);
    signal input_2_test    : std_logic_vector(7 downto 0);
    signal output_test    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the AND_Component module
    UUT: AND_Component
        port map (
            input_1	=> input_1_test,
            input_2	=> input_2_test,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for AND Component";

        -- Test case 1
        input_1_test <= "00000000";
        input_2_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert output_test = "00000000" report "Test 1: output_test should equal 00000000" severity error;

        -- Test case 2
        input_1_test <= "11111111";
        input_2_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 2";
	assert output_test = "00000000" report "Test 2: output_test should equal 00000000" severity error;

        -- Test case 3
        input_1_test <= "10101010";
        input_2_test <= "01010101";
        wait for 10 ns;

	report "Running Test case 3";
	assert output_test = "00000000" report "Test 3: output_test should equal 00000000" severity error;

	-- Test case 4
        input_1_test <= "11111111";
        input_2_test <= "11111111";
        wait for 10 ns;

	report "Running Test case 4";
	assert output_test = "11111111" report "Test 4: output_test should equal 11111111" severity error;

	-- Test case 5
        input_1_test <= "10110101";
        input_2_test <= "00101101";
        wait for 10 ns;

	report "Running Test case 5";
	assert output_test = "00100101" report "Test 5: output_test should equal 00100101" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

