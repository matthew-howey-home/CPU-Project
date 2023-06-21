
library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    port (
        opcode  : in  std_logic_vector(2 downto 0);
	a	: in  std_logic_vector(2 downto 0);
        b       : in  std_logic_vector(7 downto 0);
	cin	: in std_logic;
	negative_in : in std_logic;

        y	: out std_logic_vector(7 downto 0);
	cout 	: out std_logic;
	negative_out : out std_logic
    );
end entity ALU;

architecture Behavioral of ALU is
begin
    
end architecture Behavioral;