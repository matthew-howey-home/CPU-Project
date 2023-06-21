
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity three_bit_decoder_TB is
end entity three_bit_decoder_TB;

architecture Behavioral of three_bit_decoder_TB is
    -- Component declaration for the AND_Component module
    component three_bit_decoder
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
    end component three_bit_decoder;

    	-- Signal declarations
    	signal code_tb    : std_logic_vector(2 downto 0);

    	signal control_0_tb    : std_logic;
    	signal control_1_tb    : std_logic;
	signal control_2_tb    : std_logic;
    	signal control_3_tb    : std_logic;
    	signal control_4_tb    : std_logic;
    	signal control_5_tb    : std_logic;
    	signal control_6_tb    : std_logic;
	signal control_7_tb    : std_logic;

begin
    -- Instantiate the three_bit_decoder module
    UUT: three_bit_decoder
        port map (
            	code       => code_tb,

		control_0    => control_0_tb,
		control_1    => control_1_tb,
		control_2    => control_2_tb,
		control_3    => control_3_tb,
		control_4    => control_4_tb,
		control_5    => control_5_tb,
		control_6    => control_6_tb,
		control_7    => control_7_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for Decoder Component";

        -- Test case 0
        code_tb <= "000";
        wait for 10 ns;

	report "Running Test case 0";
	assert control_0_tb = '1' report "control_0_tb should equal 1" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 1
        code_tb <= "001";
        wait for 10 ns;

	report "Running Test case 1";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '1' report "control_1_tb should equal 1" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 2
        code_tb <= "010";
        wait for 10 ns;

	report "Running Test case 2";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '1' report "control_2_tb should equal 1" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 3
        code_tb <= "011";
        wait for 10 ns;

	report "Running Test case 3";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '1' report "control_3_tb should equal 1" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 4
        code_tb <= "100";
        wait for 10 ns;

	report "Running Test case 4";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '1' report "control_4_tb should equal 1" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 5
        code_tb <= "101";
        wait for 10 ns;

	report "Running Test case 5";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '1' report "control_5_tb should equal 1" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 6
        code_tb <= "110";
        wait for 10 ns;

	report "Running Test case 6";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '1' report "control_6_tb should equal 1" severity error;
	assert control_7_tb = '0' report "control_7_tb should equal 0" severity error;

	-- Test case 7
        code_tb <= "111";
        wait for 10 ns;

	report "Running Test case 7";
	assert control_0_tb = '0' report "control_0_tb should equal 0" severity error;
	assert control_1_tb = '0' report "control_1_tb should equal 0" severity error;
	assert control_2_tb = '0' report "control_2_tb should equal 0" severity error;
	assert control_3_tb = '0' report "control_3_tb should equal 0" severity error;
	assert control_4_tb = '0' report "control_4_tb should equal 0" severity error;
	assert control_5_tb = '0' report "control_5_tb should equal 0" severity error;
	assert control_6_tb = '0' report "control_6_tb should equal 0" severity error;
	assert control_7_tb = '1' report "control_7_tb should equal 1" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;
