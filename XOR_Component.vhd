library ieee;
use ieee.std_logic_1164.all;

entity XOR_Component is
    port (
        a       : in  std_logic_vector(7 downto 0);
        b       : in  std_logic_vector(7 downto 0);
        y	: out std_logic_vector(7 downto 0)
    );
end entity XOR_Component;

architecture Behavioral of XOR_Component is
begin
    y <= a xor b;
end architecture Behavioral;