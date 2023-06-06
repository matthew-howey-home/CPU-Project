library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ADD_Component_TB is
end entity ADD_Component_TB;

architecture Behavioral of ADD_Component_TB is
    -- Component declaration for the AND_Component module
    component ADD_Component
        port (
            a       : in  std_logic_vector(7 downto 0);
            b       : in  std_logic_vector(7 downto 0);
	    cin	    : in std_logic;
            sum       : out std_logic_vector(7 downto 0);
	    cout    : out std_logic
        );
    end component ADD_Component;

    -- Signal declarations
    signal cin_TB: std_logic;
    signal A_TB    : std_logic_vector(7 downto 0);
    signal B_TB    : std_logic_vector(7 downto 0);
    signal Y_TB    : std_logic_vector(7 downto 0);
    signal cout_TB : std_logic;

begin
    -- Instantiate the ADD_Component module
    UUT: ADD_Component
        port map (
	    cin     => cin_TB,
            a       => A_TB,
            b       => B_TB,
            sum       => Y_TB,
            cout    => cout_TB
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
        -- Test case 1
        A_TB <= "00000000";
        B_TB <= "00000000";
        wait for 10 ns;

	assert Y_TB = "00000000" report "Y_TB should equal 00000000" severity error;

        -- Test case 2
        A_TB <= "11111111";
        B_TB <= "00000000";
        wait for 10 ns;

	assert Y_TB = "00000000" report "Y_TB should equal 00000000" severity error;

        -- Test case 3
        A_TB <= "10101010";
        B_TB <= "01010101";
        wait for 10 ns;

	assert Y_TB = "00000000" report "Y_TB should equal 00000000" severity error;

	-- Test case 4
        A_TB <= "11111111";
        B_TB <= "11111111";
        wait for 10 ns;

	assert Y_TB = "11111111" report "Y_TB should equal 11111111" severity error;

	-- Test case 5
        A_TB <= "10110101";
        B_TB <= "00101101";
        wait for 10 ns;

	assert Y_TB = "00100101" report "Y_TB should equal 00100101" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;

