
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Tristate_Buffer_TB is
end entity Tristate_Buffer_TB;

architecture Behavioral of Tristate_Buffer_TB is
    -- Component declaration for the Tristate_Buffer module
    component Tristate_Buffer
        port (
            a       : in  std_logic_vector(7 downto 0);
	    en      : in std_logic;
            y       : out std_logic_vector(7 downto 0)
        );
    end component Tristate_Buffer;

    -- Signal declarations
    signal a_tb   : std_logic_vector(7 downto 0);
    signal en_tb : std_logic;
    signal y_tb    : std_logic_vector(7 downto 0);
   

begin
    -- Instantiate the Tristate_Buffer module
    UUT: Tristate_Buffer
        port map (
            a       => a_tb,
            en       => en_tb,
            y    => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Tristate Buffer Component";

        -- Test case 1
        a_tb <= "00101011";
	-- enable is active low
        en_tb <= '0';
        wait for 10 ns;
	
	report "Running Test case 1";
	assert y_tb = "00101011" report "Test 1: y_tb should equal 00101011" severity error;

	-- Test case 2
        a_tb <= "00101011";
	-- enable is active low
        en_tb <= '1';
        wait for 10 ns;
	
	report "Running Test case 2";
	assert y_tb = "ZZZZZZZZ" report "Test 1: y_tb should equal ZZZZZZZZ" severity error;

        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
