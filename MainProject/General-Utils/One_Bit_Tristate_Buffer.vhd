
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity One_Bit_Tristate_Buffer is
    Port ( 
           input	: in  std_logic;
           enable 	: in  std_logic;
           output	: out std_logic
    );
end One_Bit_Tristate_Buffer;

architecture Behavioral of One_Bit_Tristate_Buffer is

begin    
    --  input/output active low enabled tri-state buffer
    output <= input when (enable = '1') else 'Z';
end Behavioral;