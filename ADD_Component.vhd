
library ieee;
use ieee.std_logic_1164.all;

entity ADD_Component is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end entity ADD_Component;

architecture Behavioral of ADD_Component is
    signal s : std_logic_vector(7 downto 0);
    signal c : std_logic_vector(8 downto 0);
begin
    -- First Full Adder
    FA0: entity work.FullAdder
        port map (
            a => a(0),
            b => b(0),
            cin => cin,
            sum => s(0),
            cout => c(1)
        );

    -- Intermediate Full Adders
    FA1: entity work.FullAdder
        port map (
            a => a(1),
            b => b(1),
            cin => c(1),
            sum => s(1),
            cout => c(2)
        );
    FA2: entity work.FullAdder
        port map (
            a => a(2),
            b => b(2),
            cin => c(2),
            sum => s(2),
            cout => c(3)
        );
    FA3: entity work.FullAdder
        port map (
            a => a(3),
            b => b(3),
            cin => c(3),
            sum => s(3),
            cout => c(4)
        );
    FA4: entity work.FullAdder
        port map (
            a => a(4),
            b => b(4),
            cin => c(4),
            sum => s(4),
            cout => c(5)
        );
    FA5: entity work.FullAdder
        port map (
            a => a(5),
            b => b(5),
            cin => c(5),
            sum => s(5),
            cout => c(6)
        );
    FA6: entity work.FullAdder
        port map (
            a => a(6),
            b => b(6),
            cin => c(6),
            sum => s(6),
            cout => c(7)
        );

    -- Last Full Adder
    FA7: entity work.FullAdder
        port map (
            a => a(7),
            b => b(7),
            cin => c(7),
            sum => s(7),
            cout => c(8)
        );

    -- Output
    sum <= s;
    cout <= c(8);
end architecture Behavioral;
