
library ieee;
use ieee.std_logic_1164.all;

entity SHL_Component is
    port (
        a : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0)
    );
end entity SHL_Component;

architecture Behavioral of SHL_Component is
begin
    y(0) <= '0';
    y(1) <= a(0);
    y(2) <= a(1);
    y(3) <= a(2);
    y(4) <= a(3);
    y(5) <= a(4);
    y(6) <= a(5);
    y(7) <= a(6);
end architecture Behavioral;
