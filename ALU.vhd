
library ieee;
use ieee.std_logic_1164.all;

entity ALU is
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
end entity ALU;

architecture Behavioral of ALU is

	signal control_0: std_logic;
	signal control_1: std_logic;
	signal control_2: std_logic;
	signal control_3: std_logic;
	signal control_4: std_logic;
	signal control_5: std_logic;
	signal control_6: std_logic;
	signal control_7: std_logic;
	
begin
	decoder: entity work.three_bit_decoder
        	port map (
	    		code => opcode,
            		control_0 => control_0,
            		control_1 => control_1,
            		control_2 => control_2,
            		control_3 => control_3,
            		control_4 => control_4,
            		control_5 => control_5,
            		control_6 => control_6,
            		control_7 => control_7
        	);
	
    
end architecture Behavioral;