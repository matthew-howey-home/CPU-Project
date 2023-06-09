library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity AND_Component_TB is
end entity AND_Component_TB;

architecture Behavioral of AND_Component_TB is
    -- Component declaration for the AND_Component module
    component AND_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            b       : in  std_logic_vector(7 downto 0);
            y       : out std_logic_vector(7 downto 0)
        );
    end component AND_Component;

    -- Signal declarations
    signal a_tb    : std_logic_vector(7 downto 0);
    signal b_tb    : std_logic_vector(7 downto 0);
    signal y_tb    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the AND_Component module
    UUT: AND_Component
        port map (
            A       => a_tb,
            b       => b_tb,
            y       => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for AND Component";

        -- Test case 1
        a_tb <= "00000000";
        b_tb <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert y_tb = "00000000" report "Test 1: Y_TB should equal 00000000" severity error;

        -- Test case 2
        a_tb <= "11111111";
        b_tb <= "00000000";
        wait for 10 ns;

	report "Running Test case 2";
	assert y_tb = "00000000" report "Test 2: Y_TB should equal 00000000" severity error;

        -- Test case 3
        a_tb <= "10101010";
        b_tb <= "01010101";
        wait for 10 ns;

	report "Running Test case 3";
	assert y_tb = "00000000" report "Test 3: Y_TB should equal 00000000" severity error;

	-- Test case 4
        a_tb <= "11111111";
        b_tb <= "11111111";
        wait for 10 ns;

	report "Running Test case 4";
	assert y_tb = "11111111" report "Test 4: Y_TB should equal 11111111" severity error;

	-- Test case 5
        a_tb <= "10110101";
        b_tb <= "00101101";
        wait for 10 ns;

	report "Running Test case 5";
	assert y_tb = "00100101" report "Test 5: Y_TB should equal 00100101" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

