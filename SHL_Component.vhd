
library ieee;
use ieee.std_logic_1164.all;

entity SHL_Component is
    port (
        input	: in std_logic_vector(7 downto 0);
        output	: out std_logic_vector(7 downto 0)
    );
end entity SHL_Component;

architecture Behavioral of SHL_Component is
begin
    output(0) <= '0';
    output(1) <= input(0);
    output(2) <= input(1);
    output(3) <= input(2);
    output(4) <= input(3);
    output(5) <= input(4);
    output(6) <= input(5);
    output(7) <= input(6);
end architecture Behavioral;
