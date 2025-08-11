-- Test of CPU Instruction 1000000 - AND Imm 42, Add 42 to the value in the accumulator

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test_AND_Imm is
end entity CPU_Test_AND_Imm;


architecture Behavioral of CPU_Test_AND_Imm is
    -- Component declaration for the CPU module
    component CPU
        port (
		Clock			: in std_logic;
		Slow_Clock		: in std_logic;
		Reset			: in std_logic;
		Memory_Data_In		: in std_logic_vector(7 downto 0);

		Memory_Address_Low		: out std_logic_vector(7 downto 0);
		Memory_Address_High		: out std_logic_vector(7 downto 0);
		Memory_Read_Enable	: out std_logic;

		A_Reg_External_Output	: out std_logic_vector(7 downto 0)		
        );
    end component;

begin
 
end architecture Behavioral;
