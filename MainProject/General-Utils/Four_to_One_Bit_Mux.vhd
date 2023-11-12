
library ieee;
use ieee.std_logic_1164.all;

-- Four to One bit Multiplexer (Mux)
-- selects input_0 if selector is 00
-- selects input_1 if selector is 01
-- selects input_2 if selector is 10
-- selects input_3 if selector is 11


entity Four_to_One_Bit_Mux is
    port (
        input_0		: in std_logic;
	input_1		: in std_logic;
 	input_2		: in std_logic;
	input_3		: in std_logic;
	selector	: in std_logic_vector(1 downto 0);

	output		: out std_logic
    );
end entity Four_to_One_Bit_Mux;

architecture Behavioral of Four_to_One_Bit_Mux is
begin
	output <= 
		(input_0 and not selector(1) and not selector(0)) or
		(input_1 and not selector(1) and selector(0)) or
		(input_2 and selector(1) and not selector(0)) or
		(input_3 and selector(1) and selector(0));
end architecture Behavioral;