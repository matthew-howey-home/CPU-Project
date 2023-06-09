library ieee;
use ieee.std_logic_1164.all;

entity OR_Component is
    port (
        a       : in  std_logic_vector(7 downto 0);
        b       : in  std_logic_vector(7 downto 0);
        y	: out std_logic_vector(7 downto 0)
    );
end entity OR_Component;

architecture Behavioral of OR_Component is
begin
    y <= a or b;
end architecture Behavioral;