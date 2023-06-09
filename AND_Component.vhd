library ieee;
use ieee.std_logic_1164.all;

entity AND_Component is
    port (
        a       : in  std_logic_vector(7 downto 0);
        b       : in  std_logic_vector(7 downto 0);
        y	: out std_logic_vector(7 downto 0)
    );
end entity AND_Component;

architecture Behavioral of AND_Component is
begin
    y <= a and b;
end architecture Behavioral;
