library ieee;
use ieee.std_logic_1164.all;

entity AND_Component is
    port (
        A       : in  std_logic_vector(7 downto 0);
        B       : in  std_logic_vector(7 downto 0);
        Y	: out std_logic_vector(7 downto 0)
    );
end entity AND_Component;

architecture Behavioral of AND_Component is
begin
    Y <= A and B;
end architecture Behavioral;
