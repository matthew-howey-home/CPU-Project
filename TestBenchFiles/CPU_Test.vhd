
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity CPU_Test is
end entity CPU_Test;


architecture Behavioral of CPU_Test is
    -- Component declaration for the CPU module
    component CPU
        port (
            	Memory_Data_In		: in std_logic_vector(7 downto 0);
		Clock			: in std_logic;

        	A_Register_Out		: out std_logic_vector(7 downto 0);
		X_Register_Out		: out std_logic_vector(7 downto 0);
		Y_Resister_Out		: out std_logic_vector(7 downto 0);
		Memory_Address_Out_Low	: out std_logic_vector(7 downto 0);
		Memory_Address_Out_High	: out std_logic_vector(7 downto 0);
		Memory_Read_Enable	: out std_logic
        );
    end component CPU;

	-- Signal declarations
    	signal Memory_Data_In_Test				: std_logic_vector(7 downto 0);
	signal Clock_Test					: std_logic;

	signal A_Register_Out_Test				: std_logic_vector(7 downto 0);
	signal X_Register_Out_Test				: std_logic_vector(7 downto 0);
	signal Y_Resister_Out_Test				: std_logic_vector(7 downto 0);
	signal Memory_Address_Out_Low_Test			: std_logic_vector(7 downto 0);
	signal Memory_Address_Out_High_Test			: std_logic_vector(7 downto 0);
	signal Memory_Read_Enable				: std_logic;
begin

end architecture Behavioral;