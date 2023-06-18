
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tri_state_buffer is
    Port ( 
           -- 4 input / output buffer with one enable
           a  : in  std_logic_vector(7 downto 0);
           en  : in  std_logic;
           y : out STD_LOGIC_VECTOR (7 downto 0));
end tri_state_buffer;

architecture Behavioral of tri_state_buffer is

begin    
    -- 8 input/output active low enabled tri-state buffer
    y <= a when (en = '0') else "ZZZZZZZZ";
end Behavioral;