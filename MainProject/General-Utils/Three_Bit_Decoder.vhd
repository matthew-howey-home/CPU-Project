
library ieee;
use ieee.std_logic_1164.all;

entity Three_Bit_Decoder is
    port (
        code  : in  std_logic_vector(2 downto 0);
	
	control_0: out std_logic;
	control_1: out std_logic;
	control_2: out std_logic;
	control_3: out std_logic;
	control_4: out std_logic;
	control_5: out std_logic;
	control_6: out std_logic;
	control_7: out std_logic
    );
end entity Three_Bit_Decoder;

architecture Behavioral of three_bit_decoder is
begin
	control_0 <= 	not code(2)	and 	not code(1)	and 	not code(0);
	control_1 <= 	not code(2) 	and 	not code(1) 	and 	code(0);
	control_2 <= 	not code(2) 	and 	code(1) 	and 	not code(0);
	control_3 <= 	not code(2) 	and	code(1)		and 	code(0);
	control_4 <= 	code(2) 	and 	not code(1)	and 	not code(0);
	control_5 <=	code(2) 	and 	not code(1) 	and 	code(0);
	control_6 <= 	code(2)		and	code(1) 	and 	not code(0);
	control_7 <= 	code(2) 	and	code(1) 	and 	code(0);
    
end architecture Behavioral;