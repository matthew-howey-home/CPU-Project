
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Tristate_Buffer is
    Port ( 
           -- 4 input / output buffer with one enable
           a  : in  std_logic_vector(7 downto 0);
	   -- enable is active low
           en  : in  std_logic;
           y : out std_logic_vector (7 downto 0));
end Tristate_Buffer;

architecture Behavioral of Tristate_Buffer is

begin    
    -- 8 input/output active low enabled tri-state buffer
    y <= a when (en = '0') else "ZZZZZZZZ";
end Behavioral;