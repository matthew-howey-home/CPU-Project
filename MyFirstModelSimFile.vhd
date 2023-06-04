library ieee;
use ieee.std_logic_1164.all;

entity AND_Gate is
    port (
        A, B: in std_logic;
        Y: out std_logic
    );
end entity AND_Gate;

architecture rtl of AND_Gate is
begin
    Y <= A and B;
end architecture rtl;
