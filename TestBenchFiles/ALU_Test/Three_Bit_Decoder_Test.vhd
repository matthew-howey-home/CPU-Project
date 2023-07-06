
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity Three_Bit_Decoder_Test is
end entity Three_Bit_Decoder_Test;

architecture Behavioral of Three_Bit_Decoder_Test is
    -- Component declaration for the AND_Component module
    component Three_Bit_Decoder
        port (
            	code  : in  std_logic_vector(2 downto 0);
	
		control_0: out std_logic;
		control_1: out std_logic;
		control_2: out std_logic;
		control_3: out std_logic;
		control_4: out std_logic;
		control_5: out std_logic;
		control_6: out std_logic;
		control_7: out std_logic
        );
    end component Three_Bit_Decoder;

    	-- Signal declarations
    	signal code_test    : std_logic_vector(2 downto 0);

    	signal control_0_test    : std_logic;
    	signal control_1_test    : std_logic;
	signal control_2_test    : std_logic;
    	signal control_3_test    : std_logic;
    	signal control_4_test    : std_logic;
    	signal control_5_test    : std_logic;
    	signal control_6_test    : std_logic;
	signal control_7_test    : std_logic;

begin
    -- Instantiate the Three_Bit_Decoder module
    UUT: Three_Bit_Decoder
        port map (
            	code       => code_test,

		control_0    => control_0_test,
		control_1    => control_1_test,
		control_2    => control_2_test,
		control_3    => control_3_test,
		control_4    => control_4_test,
		control_5    => control_5_test,
		control_6    => control_6_test,
		control_7    => control_7_test
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Decoder Component";

        -- Test case 0
        code_test <= "000";
        wait for 10 ns;

	report "Running Test case 0";
	assert control_0_test = '1' report "control_0_test should equal 1" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 1
        code_test <= "001";
        wait for 10 ns;

	report "Running Test case 1";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '1' report "control_1_test should equal 1" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 2
        code_test <= "010";
        wait for 10 ns;

	report "Running Test case 2";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '1' report "control_2_test should equal 1" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 3
        code_test <= "011";
        wait for 10 ns;

	report "Running Test case 3";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '1' report "control_3_test should equal 1" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 4
        code_test <= "100";
        wait for 10 ns;

	report "Running Test case 4";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '1' report "control_4_test should equal 1" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 5
        code_test <= "101";
        wait for 10 ns;

	report "Running Test case 5";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '1' report "control_5_test should equal 1" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 6
        code_test <= "110";
        wait for 10 ns;

	report "Running Test case 6";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '1' report "control_6_test should equal 1" severity error;
	assert control_7_test = '0' report "control_7_test should equal 0" severity error;

	-- Test case 7
        code_test <= "111";
        wait for 10 ns;

	report "Running Test case 7";
	assert control_0_test = '0' report "control_0_test should equal 0" severity error;
	assert control_1_test = '0' report "control_1_test should equal 0" severity error;
	assert control_2_test = '0' report "control_2_test should equal 0" severity error;
	assert control_3_test = '0' report "control_3_test should equal 0" severity error;
	assert control_4_test = '0' report "control_4_test should equal 0" severity error;
	assert control_5_test = '0' report "control_5_test should equal 0" severity error;
	assert control_6_test = '0' report "control_6_test should equal 0" severity error;
	assert control_7_test = '1' report "control_7_test should equal 1" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
