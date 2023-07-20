library ieee;
use ieee.std_logic_1164.all;

-- Two to One bit Multiplexer (Mux)
-- selects input_1 if selector is 0
-- selects input_2 if selector is 1

entity Two_To_One_Mux is
    port (
        input_1		: in std_logic;
 	input_2		: in std_logic;
	selector	: in std_logic;

	output		: out std_logic
    );
end entity Two_To_One_Mux;

architecture Behavioral of Two_To_One_Mux is
begin
	output <= (input_1 and not selector) or (input_2 and selector);
end architecture Behavioral;