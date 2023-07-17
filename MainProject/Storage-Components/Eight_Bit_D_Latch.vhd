
library ieee;
use ieee.std_logic_1164.all;

entity Eight_Bit_D_Latch is
    port (
        D		: in std_logic_vector(7 downto 0);     	-- Data input
        E		: in std_logic;				-- Input enable
	OE		: in std_logic;				-- Output enable

        Q		: out std_logic_vector(7 downto 0)	-- Output Q
    );
end entity Eight_Bit_D_Latch;

architecture Behavioral of Eight_Bit_D_Latch is
	signal q_internal		: std_logic_vector(7 downto 0);
	signal q_output			: std_logic_vector(7 downto 0);
begin
	D_Latch_0: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(0),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(0)
        	);

	D_Latch_1: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(1),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(1)
        	);

	D_Latch_2: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(2),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(2)
        	);

	D_Latch_3: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(3),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(3)
        	);

	D_Latch_4: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(4),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(4)
        	);

	D_Latch_5: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(5),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(5)
        	);

	D_Latch_6: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(6),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(6)
        	);

	D_Latch_7: entity work.D_Latch
       		port map (
			-- input
   			D		=> D(7),
       			E	 	=> E,
       			-- output
			Q		=> q_internal(7)
        	);
	
	Eight_Bit_Tristate_Buffer: entity work.Eight_Bit_Tristate_Buffer
        	port map (
            		input	=> 	q_internal,
            		enable	=> 	OE,
            		output  =>	q_output
        	);
	 -- Output
	 Q	 	<= q_output;
end architecture Behavioral;