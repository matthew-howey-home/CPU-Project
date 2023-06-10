

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity SHR_Component_TB is
end entity SHR_Component_TB;

architecture Behavioral of SHR_Component_TB is
    -- Component declaration for the SHR_Component module
    component SHR_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            y       : out std_logic_vector(7 downto 0);
	    remain  : out std_logic
        );
    end component SHR_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal y_tb    : std_logic_vector(7 downto 0);
    signal remain_tb    : std_logic;

begin
    -- Instantiate the SHR_Component module
    UUT: SHR_Component
        port map (
            a       => a_tb,
            y       => y_tb,
	    remain  => remain_tb
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
	assert remain_tb = '0' report "remain_tb should equal 0" severity error;


        -- Test case 2
        a_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 2";
	assert y_tb = "01111111" report "y_tb should equal 01111111" severity error;
	assert remain_tb = '1' report "remain_tb should equal 1" severity error;

        -- Test case 3
        a_tb <= "10101010";
        wait for 10 ns;

	report "Running Test case 3";
	assert y_tb = "01010101" report "y_tb should equal 01010101" severity error;
	assert remain_tb = '0' report "remain_tb should equal 0" severity error;

	-- Test case 4
        a_tb <= "01010101";
        wait for 10 ns;

	report "Running Test case 4";
	assert y_tb = "00101010" report "y_tb should equal 00101010" severity error;
	assert remain_tb = '1' report "remain_tb should equal 1" severity error;

	-- Test case 5
        a_tb <= "10110101";
        wait for 10 ns;

	report "Running Test case 5";
	assert y_tb = "01011010" report "y_tb should equal 01011010" severity error;
	assert remain_tb = '1' report "remain_tb should equal 1" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;