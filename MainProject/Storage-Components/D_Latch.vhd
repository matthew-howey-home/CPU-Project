
library ieee;
use ieee.std_logic_1164.all;

entity D_Latch is
    port (
        D		: in std_logic;        -- Data input
        E		: in std_logic;        -- Enable input
        Q		: out std_logic;       -- Output Q
        Q_Complement	: out std_logic        -- Output Q complement
    );
end entity D_Latch;

architecture Behavioral of D_Latch is
    signal not_D			: std_logic; -- invert D to connect to reset
    signal S				: std_logic; -- Set (active low)
    signal R				: std_logic; -- Reset (active low)
    signal internal_q			: std_logic;
    signal internal_q_complement	: std_logic;
begin
    -- D latch implementation
    not_D			<= not D;
    S				<= D nand E;
    R				<= not_D nand E;
    -- SR Latch implementation
    internal_q_complement	<= R nand internal_q;
    internal_q			<= S nand internal_q_complement;

    Q			<= internal_q;
    Q_Complement	<= internal_q_complement;
end architecture Behavioral;