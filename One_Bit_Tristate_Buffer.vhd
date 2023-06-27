
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity One_Bit_Tristate_Buffer is
    Port ( 
           a  : in  std_logic;
	   -- enable is active low
           en  : in  std_logic;
           y : out std_logic
    );
end One_Bit_Tristate_Buffer;

architecture Behavioral of One_Bit_Tristate_Buffer is

begin    
    --  input/output active low enabled tri-state buffer
    y <= a when (en = '0') else 'Z';
end Behavioral;