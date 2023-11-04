library  ieee;
use ieee.std_logic_1164.all;

entity CPU is
    port (
	Clock			: in std_logic;
	Reset			: in std_logic
    );
end entity  CPU;

architecture Behavioral of CPU is
	signal FSM_Initial_State	: std_logic_vector(7 downto 0);
	signal FSM_In_Signal		: std_logic_vector(7 downto 0);
	signal FSM_Out_Signal		: std_logic_vector(7 downto 0);
	signal Decoder_FSM_Next_State	: std_logic_vector(7 downto 0);
	
begin
	FSM_Initial_State <= "00000001";
	Decoder_FSM_Next_State <= "UUUUUUUU";

	-- RESET MUX, connect FSM_Initial_State to FSM input if Reset is asserted
	Reset_Mux: entity work.Two_to_One_Byte_Mux
		port map (
	    		input_1 	=> Decoder_FSM_Next_State,
            		Input_2 	=> FSM_Initial_State,
            		selector	=> Reset,
	
            		Output 		=> FSM_In_Signal
        	);

 
	-- FINITE STATE MACHINE
	FSM: entity work.Eight_Bit_Register
		port map (
	    		Data_Input 	=> FSM_In_Signal,
            		Input_Enable 	=> '1',
            		Clock 		=> Clock,
			Output_Enable 	=> '1',

            		Output 		=> FSM_Out_Signal
        	);
	
end architecture Behavioral;