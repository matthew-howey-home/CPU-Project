library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity edge_triggered_flip_flop_rtl is
    Port (
       	Data_Input	: in std_logic;
        Input_Enable	: in std_logic;
	Clock		: in std_logic;
	Output_Enable	: in std_logic;

        Output		: out std_logic
    );
end edge_triggered_flip_flop_rtl;

architecture Behavioral of edge_triggered_flip_flop_rtl is
    signal flip_flop_internal : std_logic := '0';
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if Input_Enable = '1' then
                flip_flop_internal <= Data_Input;
            end if;
        end if;
    end process;

    Output <= flip_flop_internal when Output_Enable = '1' else 'Z';
end Behavioral;