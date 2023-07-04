
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Eight_Bit_Tristate_Buffer is
    Port ( 
           input	: in std_logic_vector(7 downto 0);
	   -- enable is active low, so '0' = enabled, '1' = not enabled
           enable	: in  std_logic;
           output	: out std_logic_vector (7 downto 0));
end Eight_Bit_Tristate_Buffer;

architecture Behavioral of Eight_Bit_Tristate_Buffer is

begin    
    -- 8 input/output active low enabled tri-state buffer
    output <= input when (enable = '0') else "ZZZZZZZZ";
end Behavioral;