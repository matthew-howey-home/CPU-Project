
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ALU_TB is
end entity ALU_TB;

architecture Behavioral of ALU_TB is
    -- Component declaration for the AND_Component module
    component ALU
        port (
            	opcode  : in  std_logic_vector(2 downto 0);
		a	: in  std_logic_vector(7 downto 0);
	        b       : in  std_logic_vector(7 downto 0);
		cin	: in std_logic;
		negative_in : in std_logic;
	
	        y	: out std_logic_vector(7 downto 0);
		cout 	: out std_logic;
		negative_out : out std_logic
        );
    end component ALU;

    	-- Signal declarations
    	signal opcode_tb    : 	std_logic_vector(2 downto 0);

    	signal a_tb    : 	std_logic_vector(7 downto 0);
    	signal b_tb  : 		std_logic_vector(7 downto 0);
	signal cin_tb    : 	std_logic;
    	signal negative_in_tb :	std_logic;
    	signal y_tb    : 	std_logic_vector(7 downto 0);
    	signal cout_tb    : 	std_logic;
    	signal negative_out_tb:	std_logic;

begin
    -- Instantiate the three_bit_decoder module
    UUT: ALU
        port map (
            	opcode		=> opcode_tb,

		a    		=> a_tb,
		b    		=> b_tb,
		cin    		=> cin_tb,
		negative_in    	=> negative_in_tb,
		y    		=> y_tb,
		cout    	=> cout_tb,
		negative_out    => negative_out_tb
        );

    -- Stimulus process to apply test vectors
    stimulus_proc: process

    begin
	report "Running Tests for AND Component";

        -- Test case 0
        opcode_tb <= "000";
	a_tb <= "11010110";
	b_tb <= "00110011";
        wait for 10 ns;

	report "Running Test case 1";
	assert y_tb = "00010010" report "Test 1: y_tb should equal 00010010" severity error;

        -- End the simulation
        wait;
    end process stimulus_proc;

end architecture Behavioral;