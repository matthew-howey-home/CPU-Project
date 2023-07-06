
library  ieee;
use ieee.std_logic_1164.all;

entity  ALU is
    port (
        opcode  	: in  std_logic_vector(2 downto 0);
	input_1		: in  std_logic_vector(7 downto 0);
        input_2		: in  std_logic_vector(7 downto 0);
	carry_in	: in std_logic;
	negative_in	: in std_logic;

        output		: out std_logic_vector(7 downto 0);
	carry_out	: out std_logic;
	negative_out	: out std_logic
    );
end entity  ALU;

architecture Behavioral of ALU is

	signal control_0: std_logic;
	signal control_1: std_logic;
	signal control_2: std_logic;
	signal control_3: std_logic;
	signal control_4: std_logic;
	signal control_5: std_logic;
	signal control_6: std_logic;
	signal control_7: std_logic;

	signal not_control_0: std_logic;
	signal not_control_1: std_logic;
	signal not_control_2: std_logic;
	signal not_control_3: std_logic;
	signal not_control_4: std_logic;
	signal not_control_5: std_logic;
	signal not_control_6: std_logic;
	signal not_control_7: std_logic;

	signal and_output: 		std_logic_vector(7 downto 0);
	signal or_output: 		std_logic_vector(7 downto 0);
	signal not_output:		std_logic_vector(7 downto 0);
	signal xor_output: 		std_logic_vector(7 downto 0);
	signal shr_output:		std_logic_vector(7 downto 0);
	signal shl_output:		std_logic_vector(7 downto 0);
	signal add_output:		std_logic_vector(7 downto 0);
	signal add_carry_out:		std_logic;
	signal sub_output:		std_logic_vector(7 downto 0);
	signal sub_negative_out:	std_logic;

	
begin
	decoder: entity  work.three_bit_decoder
        	port map (
	    		code => opcode,
            		control_0 => control_0,
            		control_1 => control_1,
            		control_2 => control_2,
            		control_3 => control_3,
            		control_4 => control_4,
            		control_5 => control_5,
            		control_6 => control_6,
            		control_7 => control_7
        	);
	
	-- invert control signals as tri state buffer is active low
	not_control_0 <= not control_0;
	not_control_1 <= not control_1;
	not_control_2 <= not control_2;
	not_control_3 <= not control_3;
	not_control_4 <= not control_4;
	not_control_5 <= not control_5;
	not_control_6 <= not control_6;
	not_control_7 <= not control_7;
	
	-- AND connections (opcode 0)--------------------

	and_component: entity  work.AND_Component
		port map (
			input_1	=> input_1,
			input_2	=> input_2,
			output	=> and_output
		);

	and_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> and_output,
			enable	=> not_control_0,
			output	=> output
		);
	
	and_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_0,
			output	=> carry_out
		);

	and_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_0,
			output	=> negative_out
		);

	-- OR connections (opcode 1) --------------------

	or_component: entity  work.OR_Component
		port map (
			input_1	=> input_1,
			input_2	=> input_2,
			output	=> or_output
		);

	or_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> or_output,
			enable	=> not_control_1,
			output	=> output
		);

	or_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_1,
			output	=> carry_out
		);

	or_and_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_1,
			output	=> negative_out
		);

	-- NOT connections (opcode 2) --------------------

	not_component: entity work.NOT_Component
		port map (
			input	=> input_1,
			output	=> not_output
		);

	not_tristate: entity work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> not_output,
			enable	=> not_control_2,
			output	=> output
		);

	not_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_2,
			output	=> carry_out
		);

	not_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_2,
			output	=> negative_out
		);

	-- XOR connections (opcode 3) --------------------

	xor_component: entity  work.XOR_Component
		port map (
			input_1	=> input_1,
			input_2	=> input_2,
			output	=> xor_output
		);

	xor_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> xor_output,
			enable	=> not_control_3,
			output	=> output
		);

	xor_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_3,
			output	=> carry_out
		);

	xor_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_3,
			output	=> negative_out
		);

	-- SHR connections (opcode 4) --------------------

	shr_component: entity  work.SHR_Component
		port map (
			input	=> input_1,
			output	=> shr_output
		);

	shr_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> shr_output,
			enable	=> not_control_4,
			output	=> output
		);

	shr_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_4,
			output	=> carry_out
		);

	shr_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_4,
			output	=> negative_out
		);

	-- SHL connections (opcode 5) --------------------

	shl_component: entity  work.SHL_Component
		port map (
			input	=> input_1,
			output	=> shl_output
		);

	shl_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> shl_output,
			enable	=> not_control_5,
			output	=> output
		);

	shl_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_5,
			output	=> carry_out
		);

	shl_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_5,
			output	=> negative_out
		);

	-- ADD connections (opcode 6) --------------------

	add_component: entity  work.ADD_Component
		port map (
			carry_in	=> carry_in,
			input_1		=> input_1,
			input_2		=> input_2,
			output		=> add_output,
			carry_out	=> add_carry_out
		);

	add_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> add_output,
			enable	=> not_control_6,
			output	=> output
		);

	add_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> add_carry_out,
			enable	=> not_control_6,
			output	=> carry_out
		);

	add_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_6,
			output	=> negative_out
		);
    
	-- SUB connections (opcode 7) --------------------

	sub_component: entity  work.SUB_Component
		port map (
			borrow_in	=> carry_in,
			input_1		=> input_1,
			input_2		=> input_2,
			output		=> sub_output,
			borrow_out	=> sub_negative_out
		);

	sub_tristate: entity  work.Eight_Bit_Tristate_Buffer 
		port map (
			input	=> sub_output,
			enable	=> not_control_7,
			output	=> output
		);

	sub_one_bit_tristate_carry_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> '0',
			enable	=> not_control_7,
			output	=> carry_out
		);

	sub_one_bit_tristate_negative_out: entity  work.One_Bit_Tristate_Buffer  
		port map (
			input	=> sub_negative_out,
			enable	=> not_control_7,
			output	=> negative_out
		);
    
end architecture Behavioral;