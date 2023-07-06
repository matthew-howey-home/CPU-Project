
-- ***** ALU 8 BIT ADD COMPONENT *****

library ieee;
use ieee.std_logic_1164.all;

-- INPUTS AND OUTPUTS OF ADD COMPONENT
entity ADD_Component is
    port (
        input_1		: in std_logic_vector(7 downto 0);
        input_2		: in std_logic_vector(7 downto 0);
        carry_in	: in std_logic;
        output		: out std_logic_vector(7 downto 0);
        carry_out	: out std_logic
    );
end entity ADD_Component;

architecture Behavioral of ADD_Component is
    signal output_internal 	: std_logic_vector(7 downto 0);
    signal carry_out_internal 	: std_logic_vector(8 downto 0);
begin
    -- LEFT SIDE SHOWS ONE_BIT_ADDER INPUTS/OUTPUTS
    -- RIGHT SIDE SHOWS ADD_Component Internal Signals
    -- First Full Adder
    FA0: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(0),
            input_2 	=> input_2(0),
            carry_in	=> carry_in,
            output	=> output_internal(0),
            carry_out	=> carry_out_internal(1)
        );

    -- Intermediate Full Adders
    FA1: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(1),
            input_2 	=> input_2(1),
            carry_in	=> carry_out_internal(1),
            output	=> output_internal(1),
            carry_out	=> carry_out_internal(2)
        );
    FA2: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(2),
            input_2 	=> input_2(2),
            carry_in	=> carry_out_internal(2),
            output	=> output_internal(2),
            carry_out	=> carry_out_internal(3)
        );
    FA3: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(3),
            input_2 	=> input_2(3),
            carry_in	=> carry_out_internal(3),
            output	=> output_internal(3),
            carry_out	=> carry_out_internal(4)
        );
    FA4: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(4),
            input_2 	=> input_2(4),
            carry_in	=> carry_out_internal(4),
            output	=> output_internal(4),
            carry_out	=> carry_out_internal(5)
        );
    FA5: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(5),
            input_2 	=> input_2(5),
            carry_in	=> carry_out_internal(5),
            output	=> output_internal(5),
            carry_out	=> carry_out_internal(6)
        );
    FA6: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(6),
            input_2 	=> input_2(6),
            carry_in	=> carry_out_internal(6),
            output	=> output_internal(6),
            carry_out	=> carry_out_internal(7)
        );

    -- Last Full Adder
    FA7: entity work.One_Bit_Adder
        port map (
            input_1	=> input_1(7),
            input_2 	=> input_2(7),
            carry_in	=> carry_out_internal(7),
            output	=> output_internal(7),
            carry_out	=> carry_out_internal(8)
        );
   
    -- LEFT SIDE SHOWS FINAL OUTPUTS OF ADD COMPONENT
    -- RIGHT SIDE SHOWS INTERNAL SIGNALS OF ADD COMPONENT
    -- Output
    output 	<= output_internal;
    carry_out	<= carry_out_internal(8);
end architecture Behavioral;
