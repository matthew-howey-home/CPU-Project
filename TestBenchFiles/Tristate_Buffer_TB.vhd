
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
    signal a_tb_1   : std_logic_vector(7 downto 0);
    signal en_tb_1 : std_logic;
    
    signal a_tb_2   : std_logic_vector(7 downto 0);
    signal en_tb_2 : std_logic;

    signal y_tb   : std_logic_vector(7 downto 0);
   
begin
    -- Instantiate the Tristate_Buffer module
    UUT1: Tristate_Buffer
        port map (
            a       => a_tb_1,
            en       => en_tb_1,
            y    => y_tb
        );

    UUT2: Tristate_Buffer
        port map (
            a       => a_tb_2,
            en       => en_tb_2,
            y    => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Tristate Buffer Component";

	-- Set UUT2 to not enabled so we can test UUT1 in isolation
	-- note enable is active low, so 1 means not enabled
	en_tb_2 <= '1';


	-- Test case 1 (for UUT1 only)
        a_tb_1 <= "00101011";
	-- enable is active low, so 0 means enable
        en_tb_1 <= '0';
        wait for 10 ns;
	
	report "Running Test case 1";
	assert y_tb = "00101011" report "Test 1: y_tb should equal 00101011" severity error;

	-- Test case 2 (for UUT2 only)
        a_tb_1 <= "00101011";
	-- enable is active low, so 1 means do not enable
        en_tb_1 <= '1';
        wait for 10 ns;
	
	report "Running Test case 2";
	assert y_tb = "ZZZZZZZZ" report "Test 2: y_tb should equal ZZZZZZZZ" severity error;

	
	-- Test two tri state buffers at the same time

	-- Test case 3 (For UUT1 and UUT2)

	-- Set UUT1 to enable
	a_tb_1 <= "11110000";
        en_tb_1 <= '0';

	-- Set UUT2 to not enabled
	a_tb_2 <= "00001111";
        en_tb_2 <= '1';
        wait for 10 ns;

	-- Only UUT1 output should be visible
	report "Running Test case 3";
	assert y_tb = "11110000" report "Test 3: y_tb should equal 11110000" severity error;

	-- Test case 4 (For UUT1 and UUT2)

	-- Set UUT1 to not enabled
	a_tb_1 <= "11110000";
        en_tb_1 <= '1';

	-- Set UUT2 to enabled
	a_tb_2 <= "00001111";
        en_tb_2 <= '0';
        wait for 10 ns;

	-- Only UUT2 output should be visible
	report "Running Test case 4";
	assert y_tb = "00001111" report "Test 4: y_tb should equal 00001111" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
