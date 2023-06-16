
library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch is
    port (
        S : in std_logic;         -- Set input (active low)
        R : in std_logic;         -- Reset input (active low)
        Q : out std_logic;        -- Output Q
        QN : out std_logic        -- Output Q complement
    );
end entity SR_Latch;

architecture Behavioral of SR_Latch is
    signal internal_q : std_logic := '0';
    signal internal_q_complement : std_logic := '1';
begin
    -- NAND gates implementation
    process (S, R)
    begin
        internal_q_complement <= (not R) nand internal_q;
        internal_q <= (not S) nand internal_q_complement;
    end process;

    Q <= internal_q;
    QN <= internal_q_complement;
end architecture Behavioral;