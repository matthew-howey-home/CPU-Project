

library ieee;
use ieee.std_logic_1164.all;

-- One to Two byte De-Multiplexer (De,mux)
-- selects output_0 if selector is 0
-- selects output_1 if selector is 1

entity One_to_Two_Byte_Demux is
    port (
        input		: in std_logic_vector(7 downto 0);
	selector	: in std_logic;

	output_0	: out std_logic_vector(7 downto 0);
	output_1	: out std_logic_vector(7 downto 0)
    );
end entity One_to_Two_Byte_Demux;

architecture Behavioral of One_to_Two_Byte_Demux is
begin
	output_0 <= input when (selector = '0') else "ZZZZZZZZ";
	output_1 <= input when (selector = '1') else "ZZZZZZZZ";	
end architecture Behavioral;