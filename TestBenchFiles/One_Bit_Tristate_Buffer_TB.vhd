
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity One_Bit_Tristate_Buffer_TB is
end entity One_Bit_Tristate_Buffer_TB;

architecture Behavioral of One_Bit_Tristate_Buffer_TB is
    -- Component declaration for the One_Bit_Tristate_Buffer module
    component One_Bit_Tristate_Buffer
        port (
            a       : in  std_logic;
	    en      : in std_logic;
            y       : out std_logic
        );
    end component One_Bit_Tristate_Buffer;

    -- Signal declarations
    signal a_tb_1   : std_logic;
    signal en_tb_1 : std_logic;
    
    signal a_tb_2   : std_logic;
    signal en_tb_2 : std_logic;

    signal y_tb   : std_logic;
   
begin
    -- Instantiate the Tristate_Buffer module
    UUT1: One_Bit_Tristate_Buffer
        port map (
            a       => a_tb_1,
            en       => en_tb_1,
            y    => y_tb
        );

    UUT2: One_Bit_Tristate_Buffer
        port map (
            a       => a_tb_2,
            en       => en_tb_2,
            y    => y_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for One Bit Tristate Buffer Component";

	-- Set UUT2 to not enabled so we can test UUT1 in isolation
	-- note enable is active low, so 1 means not enabled
	en_tb_2 <= '1';

	-- Test two tri state buffers at the same time

	-- Test case 1 (For UUT1 and UUT2)

	-- Set UUT1 to enable
	a_tb_1 <= '1';
        en_tb_1 <= '0';

	-- Set UUT2 to not enabled
	a_tb_2 <= '0';
        en_tb_2 <= '1';
        wait for 10 ns;

	-- Only UUT1 output should be visible
	report "Running Test case 1";
	assert y_tb = '1' report "Test 1: y_tb should equal 1" severity error;

	-- Test case 2 (For UUT1 and UUT2)

	-- Set UUT1 to not enabled
	a_tb_1 <= '1';
        en_tb_1 <= '1';

	-- Set UUT2 to enabled
	a_tb_2 <= '0';
        en_tb_2 <= '0';
        wait for 10 ns;

	-- Only UUT2 output should be visible
	report "Running Test case 2";
	assert y_tb = '0' report "Test 2: y_tb should equal 0" severity error;


        -- Add more test cases here if needed

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;