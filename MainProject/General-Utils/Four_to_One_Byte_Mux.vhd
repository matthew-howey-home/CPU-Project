

library ieee;
use ieee.std_logic_1164.all;

-- Four to One byte Multiplexer (Mux)
-- selects input_0 if selector is 00
-- selects input_1 if selector is 01
-- selects input_2 if selector is 10
-- selects input_3 if selector is 11

entity Four_to_One_Byte_Mux is
    port (
        input_0		: in std_logic_vector(7 downto 0);
 	input_1		: in std_logic_vector(7 downto 0);
	input_2		: in std_logic_vector(7 downto 0);
 	input_3		: in std_logic_vector(7 downto 0);

	selector	:  std_logic_vector(1 downto 0);

	output		: out std_logic_vector(7 downto 0)
    );
end entity Four_to_One_Byte_Mux;

architecture Behavioral of Four_to_One_Byte_Mux is
begin
	Bit_0: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(0),
			input_1		=> input_1(0),	
 			input_2		=> input_2(0),
			input_3		=> input_3(0),	
			selector	=> selector,

			output		=> output(0)
        	);

	Bit_1: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(1),
			input_1		=> input_1(1),	
 			input_2		=> input_2(1),
			input_3		=> input_3(1),	
			selector	=> selector,

			output		=> output(1)
        	);

	Bit_2: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(2),
			input_1		=> input_1(2),	
 			input_2		=> input_2(2),
			input_3		=> input_3(2),	
			selector	=> selector,

			output		=> output(2)
        	);

	Bit_3: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(3),
			input_1		=> input_1(3),	
 			input_2		=> input_2(3),
			input_3		=> input_3(3),	
			selector	=> selector,

			output		=> output(3)
        	);

	Bit_4: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(4),
			input_1		=> input_1(4),	
 			input_2		=> input_2(4),
			input_3		=> input_3(4),	
			selector	=> selector,

			output		=> output(4)
        	);

	Bit_5: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(5),
			input_1		=> input_1(5),	
 			input_2		=> input_2(5),
			input_3		=> input_3(5),	
			selector	=> selector,

			output		=> output(5)
        	);

	Bit_6: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(6),
			input_1		=> input_1(6),	
 			input_2		=> input_2(6),
			input_3		=> input_3(6),	
			selector	=> selector,

			output		=> output(6)
        	);

	Bit_7: entity work.Four_to_One_Bit_Mux
        	port map (
  			input_0		=> input_0(7),
			input_1		=> input_1(7),	
 			input_2		=> input_2(7),
			input_3		=> input_3(7),	
			selector	=> selector,

			output		=> output(7)
        	);

end architecture Behavioral;