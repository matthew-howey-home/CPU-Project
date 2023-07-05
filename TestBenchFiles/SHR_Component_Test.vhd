

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SHR_Component_Test is
end entity SHR_Component_Test;

architecture Behavioral of SHR_Component_Test is
    -- Component declaration for the SHR_Component module
    component SHR_Component
        port (
            input	: in  std_logic_vector(7 downto 0);
            output	: out std_logic_vector(7 downto 0)
        );
    end component SHR_Component;

    -- Signal declarations
    signal input_test	: std_logic_vector(7 downto 0);
    signal output_test	: std_logic_vector(7 downto 0);

begin
    -- Instantiate the SHR_Component module
    UUT: SHR_Component
        port map (
            input	=> input_test ,
            output	=> output_test 
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	
	report "Running Tests for SHR Component";

        -- Test case 1
        input_test <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert output_test = "00000000"		report "output_test should equal 00000000" severity error;


        -- Test case 2
        input_test <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert output_test = "01111111"		report "output_test should equal 01111111" severity error;

        -- Test case 3
        input_test <= "10101010";
        wait for 10 ns;

	report "Running Test case 3";
	assert output_test = "01010101" 	report "output_test should equal 01010101" severity error;

	-- Test case 4
        input_test <= "01010101";
        wait for 10 ns;

	report "Running Test case 4";
	assert output_test = "00101010"		report "output_test should equal 00101010" severity error;

	-- Test case 5
        input_test <= "10110101";
        wait for 10 ns;

	report "Running Test case 5";
	assert output_test = "01011010" 	report "output_test should equal 01011010" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;