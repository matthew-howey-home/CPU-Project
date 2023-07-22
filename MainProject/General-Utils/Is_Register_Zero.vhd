
library ieee;
use ieee.std_logic_1164.all;

-- returns 1 if Register is zero i.e. '00000000', returns 0 otherwise
entity Is_Register_Zero is
    port (
	input		: in std_logic_vector(7 downto 0);

        output		: out std_logic
    );
end entity Is_Register_Zero;

architecture Behavioral of Is_Register_Zero is
    signal internal_result : std_logic;
begin
    internal_result	<=
	(
		(input(0) or input(1)) or (input(2) or input(3))
		or
		(input(4) or input(5)) or (input(6) or input(7))
	);

    output <= not internal_result;
end architecture Behavioral;