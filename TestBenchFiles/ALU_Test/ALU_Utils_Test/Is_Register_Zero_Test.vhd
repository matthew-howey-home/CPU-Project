
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Is_Register_Zero_Test is
end entity Is_Register_Zero_Test;

architecture Behavioral of Is_Register_Zero_Test is
    -- Component declaration for the Is_Register_Zero module
    component Is_Register_Zero
        port (
            input	: in  std_logic_vector(7 downto 0);
            output      : out std_logic
        );
    end component Is_Register_Zero;

    -- Signal declarations
    signal input_test	: std_logic_vector(7 downto 0);
    signal output_test	: std_logic;

begin
    -- Instantiate the XOR_Component module
    UUT: Is_Register_Zero
        port map (
            input	=> input_test,
            output	=> output_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	
	report "Running Tests for Is_Register_Zero Component";

        -- Test case 1
        input_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 1, register equals 0";
	assert output_test = '1' 	report "output_test should equal 1" severity error;

        -- Test case 2
        input_test <= "11111111";
        wait for 10 ns;

	report "Running Test case 2, register equals 11111111";
	assert output_test = '0' 	report "output_test should equal 0" severity error;

	-- Test case 3
        input_test <= "00000001";
        wait for 10 ns;

	report "Running Test case 3, register equals 00000001";
	assert output_test = '0' 	report "output_test should equal 0" severity error;

	-- Test case 4
        input_test <= "01000000";
        wait for 10 ns;

	report "Running Test case 4, register equals 01000000";
	assert output_test = '0' 	report "output_test should equal 0" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;