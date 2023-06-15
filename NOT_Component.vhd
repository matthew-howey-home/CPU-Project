
library ieee;
use ieee.std_logic_1164.all;

entity NOT_Component is
    port (
        a       : in  std_logic_vector(7 downto 0);
        y	: out std_logic_vector(7 downto 0)
    );
end entity NOT_Component;

architecture Behavioral of NOT_Component is
begin
    y <= not a;
end architecture Behavioral;