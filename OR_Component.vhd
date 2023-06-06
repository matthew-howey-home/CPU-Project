library ieee;
use ieee.std_logic_1164.all;

entity OR_Component is
    port (
        A       : in  std_logic_vector(7 downto 0);
        B       : in  std_logic_vector(7 downto 0);
        Y	: out std_logic_vector(7 downto 0)
    );
end entity OR_Component;

architecture Behavioral of OR_Component is
begin
    Y <= A or B;
end architecture Behavioral;