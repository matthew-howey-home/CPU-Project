
library ieee;
use ieee.std_logic_1164.all;

entity D_Latch is
    port (
        Data_Input		: in std_logic;        -- Data input
        Input_Enable		: in std_logic;        -- Enable input
        Output			: out std_logic	       -- Output
    );
end entity D_Latch;

architecture Behavioral of D_Latch is
    signal Not_Data_Input		: std_logic; -- invert Data_Input to connect to reset
    signal Set				: std_logic; -- Set (active low)
    signal Reset			: std_logic; -- Reset (active low)
    signal Internal_Output		: std_logic;
    signal Not_Internal_Output		: std_logic;
begin
    -- D latch implementation
    Not_Data_Input		<= not Data_Input;
    Set				<= Data_Input nand Input_Enable;
    Reset			<= Not_Data_Input nand Input_Enable;
    -- SR Latch implementation
    Not_Internal_Output		<= Reset nand Internal_Output;
    Internal_Output		<= Set nand Not_Internal_Output;

    Output			<= Internal_Output;
end architecture Behavioral;