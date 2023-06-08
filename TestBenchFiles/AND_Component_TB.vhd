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
            A       : in  std_logic_vector(7 downto 0);
            B       : in  std_logic_vector(7 downto 0);
            Y       : out std_logic_vector(7 downto 0)
        );
    end component AND_Component;

    -- Signal declarations
    signal A_TB    : std_logic_vector(7 downto 0);
    signal B_TB    : std_logic_vector(7 downto 0);
    signal Y_TB    : std_logic_vector(7 downto 0);

begin
    -- Instantiate the AND_Component module
    UUT: AND_Component
        port map (
            A       => A_TB,
            B       => B_TB,
            Y       => Y_TB
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for AND Component";

        -- Test case 1
        A_TB <= "00000000";
        B_TB <= "00000000";
        wait for 10 ns;

	report "Running Test case 1";
	assert Y_TB = "00000000" report "Test 1: Y_TB should equal 00000000" severity error;

        -- Test case 2
        A_TB <= "11111111";
        B_TB <= "00000000";
        wait for 10 ns;

	report "Running Test case 2";
	assert Y_TB = "00000000" report "Test 2: Y_TB should equal 00000000" severity error;

        -- Test case 3
        A_TB <= "10101010";
        B_TB <= "01010101";
        wait for 10 ns;

	report "Running Test case 3";
	assert Y_TB = "00000000" report "Test 3: Y_TB should equal 00000000" severity error;

	-- Test case 4
        A_TB <= "11111111";
        B_TB <= "11111111";
        wait for 10 ns;

	report "Running Test case 4";
	assert Y_TB = "11111111" report "Test 4: Y_TB should equal 11111111" severity error;

	-- Test case 5
        A_TB <= "10110101";
        B_TB <= "00101101";
        wait for 10 ns;

	report "Running Test case 5";
	assert Y_TB = "00100101" report "Test 5: Y_TB should equal 00100101" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

