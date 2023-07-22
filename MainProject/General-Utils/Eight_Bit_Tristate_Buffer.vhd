
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Eight_Bit_Tristate_Buffer is
    Port ( 
           input	: in std_logic_vector(7 downto 0);
           enable	: in  std_logic;
           output	: out std_logic_vector (7 downto 0));
end Eight_Bit_Tristate_Buffer;

architecture Behavioral of Eight_Bit_Tristate_Buffer is

begin    
    output <= input when (enable = '1') else "ZZZZZZZZ";
end Behavioral;