
library ieee;
use ieee.std_logic_1164.all;

entity SHR_Component is
    port (
        input	: in std_logic_vector(7 downto 0);
        output	: out std_logic_vector(7 downto 0)
    );
end entity SHR_Component;

architecture Behavioral of SHR_Component is
begin
    output(0) <= input(1);
    output(1) <= input(2);
    output(2) <= input(3);
    output(3) <= input(4);
    output(4) <= input(5);
    output(5) <= input(6);
    output(6) <= input(7);
    output(7) <= '0';
end architecture Behavioral;

