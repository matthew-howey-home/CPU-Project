
library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    port (
        opcode  : in  std_logic_vector(2 downto 0);
	a	: in  std_logic_vector(7 downto 0);
        b       : in  std_logic_vector(7 downto 0);
	cin	: in std_logic;
	negative_in : in std_logic;

        y	: out std_logic_vector(7 downto 0);
	cout 	: out std_logic;
	negative_out : out std_logic
    );
end entity ALU;

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

	signal and_output: std_logic_vector(7 downto 0);
	signal or_output: std_logic_vector(7 downto 0);
	signal not_output: std_logic_vector(7 downto 0);
	signal xor_output: std_logic_vector(7 downto 0);
	signal shr_output: std_logic_vector(7 downto 0);
	signal shl_output: std_logic_vector(7 downto 0);
	signal add_output: std_logic_vector(7 downto 0);
	signal add_cout: std_logic;

	
begin
	decoder: entity work.three_bit_decoder
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
	not_control_7 <= not control_6;
	
	-- AND connections (opcode 0)--------------------

	and_component: entity work.AND_Component
		port map (
			a => a,
			b => b,
			y => and_output
		);

	and_tristate: entity work.Tristate_Buffer
		port map (
			a => and_output,
			en => not_control_0,
			y => y
		);
	
	and_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_0,
			y => cout
		);

	and_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_0,
			y => negative_out
		);

	-- OR connections (opcode 1) --------------------

	or_component: entity work.OR_Component
		port map (
			a => a,
			b => b,
			y => or_output
		);

	or_tristate: entity work.Tristate_Buffer
		port map (
			a => or_output,
			en => not_control_1,
			y => y
		);

	or_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_1,
			y => cout
		);

	or_and_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_1,
			y => negative_out
		);

	-- NOT connections (opcode 2) --------------------

	not_component: entity work.NOT_Component
		port map (
			a => a,
			y => not_output
		);

	not_tristate: entity work.Tristate_Buffer
		port map (
			a => not_output,
			en => not_control_2,
			y => y
		);

	not_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_2,
			y => cout
		);

	not_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_2,
			y => negative_out
		);

	-- XOR connections (opcode 3) --------------------

	xor_component: entity work.XOR_Component
		port map (
			a => a,
			b => b,
			y => xor_output
		);

	xor_tristate: entity work.Tristate_Buffer
		port map (
			a => xor_output,
			en => not_control_3,
			y => y
		);

	xor_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_3,
			y => cout
		);

	xor_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_3,
			y => negative_out
		);

	-- SHR connections (opcode 4) --------------------

	shr_component: entity work.SHR_Component
		port map (
			a => a,
			y => shr_output
		);

	shr_tristate: entity work.Tristate_Buffer
		port map (
			a => shr_output,
			en => not_control_4,
			y => y
		);

	shr_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_4,
			y => cout
		);

	shr_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_4,
			y => negative_out
		);

	-- SHL connections (opcode 5) --------------------

	shl_component: entity work.SHL_Component
		port map (
			a => a,
			y => shl_output
		);

	shl_tristate: entity work.Tristate_Buffer
		port map (
			a => shl_output,
			en => not_control_5,
			y => y
		);

	shl_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_5,
			y => cout
		);

	shl_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_5,
			y => negative_out
		);

	-- ADD connections (opcode 6) --------------------

	add_component: entity work.ADD_Component
		port map (
			cin => cin,
			a => a,
			b => b,
			sum => add_output,
			cout => add_cout
		);

	add_tristate: entity work.Tristate_Buffer
		port map (
			a => add_output,
			en => not_control_6,
			y => y
		);

	add_one_bit_tristate_cout: entity work.One_Bit_Tristate_Buffer
		port map (
			a => add_cout,
			en => not_control_6,
			y => cout
		);

	add_one_bit_tristate_negative_out: entity work.One_Bit_Tristate_Buffer
		port map (
			a => '0',
			en => not_control_6,
			y => negative_out
		);
    
end architecture Behavioral;