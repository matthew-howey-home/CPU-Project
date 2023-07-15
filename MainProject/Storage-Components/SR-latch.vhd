
library ieee;
use ieee.std_logic_1164.all;

entity SR_Latch is
    port (
        S		: in std_logic;        -- Set input (active low)
        R		: in std_logic;        -- Reset input (active low)
        Q		: out std_logic;       -- Output Q
        Q_Complement	: out std_logic        -- Output Q complement
    );
end entity SR_Latch;

architecture Behavioral of SR_Latch is
    signal internal_q			: std_logic;
    signal internal_q_complement	: std_logic;
begin
    -- NAND gates implementation
    internal_q_complement	<= R nand internal_q;
    internal_q			<= S nand internal_q_complement;

    Q			<= internal_q;
    Q_Complement	<= internal_q_complement;
end architecture Behavioral;