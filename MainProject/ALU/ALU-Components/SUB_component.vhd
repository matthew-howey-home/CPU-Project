library ieee;
use ieee.std_logic_1164.all;

entity SUB_component is
  port (
    -- Inputs
    input_1	: in std_logic_vector(7 downto 0);
    input_2	: in std_logic_vector(7 downto 0); 
    borrow_in	: in std_logic;
    
    -- Outputs
    output 	: out std_logic_vector(7 downto 0);  
    borrow_out	: out std_logic
  );
end entity SUB_component;

architecture Behavioral of SUB_component is
  signal output_internal	: std_logic_vector(7 downto 0);
  signal not_input_2		: std_logic_vector(7 downto 0);
  signal not_borrow_in		: std_logic;
  signal carry_out_internal	: std_logic_vector(8 downto 0);

begin
  not_input_2	<= not input_2;
  not_borrow_in <= not borrow_in;

  -- output_internaltractor
  FA_0: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(0),
		input_2		=> not_input_2(0),
		carry_in	=> not_borrow_in,
		-- out of One_Bit_Adder
		output		=> output_internal(0),
		carry_out	=> carry_out_internal(1)
  	);

  FA_1: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(1),
		input_2		=> not_input_2(1),
		carry_in	=> carry_out_internal(1),
		-- out of One_Bit_Adder
		output		=> output_internal(1),
		carry_out	=> carry_out_internal(2)
	);

  FA_2: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(2),
		input_2		=> not_input_2(2),
		carry_in	=> carry_out_internal(2),
		-- out of One_Bit_Adder
		output		=> output_internal(2),
		carry_out	=> carry_out_internal(3)
	);

  FA_3: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(3),
		input_2		=> not_input_2(3),
		carry_in	=> carry_out_internal(3),
		-- out of One_Bit_Adder
		output		=> output_internal(3),
		carry_out	=> carry_out_internal(4)
	);

  FA_4: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(4),
		input_2		=> not_input_2(4),
		carry_in	=> carry_out_internal(4),
		-- out of One_Bit_Adder
		output		=> output_internal(4),
		carry_out	=> carry_out_internal(5)
	);

  FA_5: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(5),
		input_2		=> not_input_2(5),
		carry_in	=> carry_out_internal(5),
		-- out of One_Bit_Adder
		output		=> output_internal(5),
		carry_out	=> carry_out_internal(6)
	);

  FA_6: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1(6),
		input_2		=> not_input_2(6),
		carry_in	=> carry_out_internal(6),
		-- out of One_Bit_Adder
		output		=> output_internal(6),
		carry_out	=> carry_out_internal(7)
	);

  FA_7: entity work.One_Bit_Adder
	port map (
		-- into One_Bit_Adder
		input_1		=> input_1( 7),
		input_2		=> not_input_2(7),
		carry_in	=> carry_out_internal(7),
		-- out of One_Bit_Adder
		output		=> output_internal(7),
		carry_out	=> carry_out_internal(8)
	);

  output 	<= output_internal;
  borrow_out	<= not carry_out_internal(8);
end architecture Behavioral;

