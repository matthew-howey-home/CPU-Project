library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity eight_bit_register_rtl is
    Port (
       	Data_Input	: in std_logic_vector(7 downto 0);
        Input_Enable	: in std_logic;
	Clock		: in std_logic;
	Output_Enable	: in std_logic;

        Output		: out std_logic_vector(7 downto 0)
    );
end eight_bit_register_rtl;

architecture Behavioral of eight_bit_register_rtl is
    signal register_internal : std_logic_vector(7 downto 0) := (others => '0');
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if Input_Enable = '1' then
                register_internal <= Data_Input;
            end if;
        end if;
    end process;

    Output <= register_internal when Output_Enable = '1' else (others => 'Z');
end Behavioral;