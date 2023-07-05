library ieee;
use ieee.std_logic_1164.all;

entity OR_Component is
    port (
        input_1		: in  std_logic_vector(7 downto 0);
        input_2		: in  std_logic_vector(7 downto 0);
       	output		: out std_logic_vector(7 downto 0)
    );
end entity OR_Component;

architecture Behavioral of OR_Component is
begin
    output <= input_1 or input_2;
end architecture Behavioral;