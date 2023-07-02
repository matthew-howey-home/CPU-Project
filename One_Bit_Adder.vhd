library ieee;
use ieee.std_logic_1164.all;

entity One_Bit_Adder is
    port (
	input_1		: in std_logic;
	input_2		: in std_logic;
	carry_in	: in std_logic;

        output		: out std_logic;
	carry_out 	: out std_logic
    );
end entity One_Bit_Adder;

architecture Behavioral of One_Bit_Adder is
begin
    output	<= input_1 xor input_2 xor carry_in;
    carry_out	<= (input_1 and	input_2) or (carry_in and (input_1 xor input_2));
end architecture Behavioral;