

library  ieee;
use ieee.std_logic_1164.all;

entity Instruction_Decoder is
    port (
    	Instruction				: in std_logic_vector(7 downto 0);
	-- Output Control Signals:
	Output_Control_Input_Enable_MAR_Low 	: out std_logic;
	Output_Control_Output_Enable_PC_Low	: out std_logic
    );
end entity  Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

signal FSM	: std_logic_vector(7 downto 0) := "00000000";

begin
end architecture Behavioral;


