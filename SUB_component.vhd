library ieee;
use ieee.std_logic_1164.all;

entity SUB_Component is
  port (
    a, b: in std_logic_vector(7 downto 0);  -- Inputs
    borrow_in: in std_logic; -- Borrow input
    diff: out std_logic_vector(7 downto 0);  -- Output
    borrow_out: out std_logic  -- Borrow output
  );
end entity SUB_Component;

architecture Behavioral of SUB_Component is
  signal sub: std_logic_vector(7 downto 0);
  signal not_b: std_logic_vector(7 downto 0);
  signal not_borrow_in: std_logic;
  signal c : std_logic_vector(8 downto 0);
begin
  not_b <= not b;
  not_borrow_in <= not borrow_in;

  -- Subtractor
  FA_0: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(0),
		b => not_b(0),
		cin => not_borrow_in,
		-- out of FullAdder
		sum => sub(0),
		cout => c(1)
  	);

  FA_1: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(1),
		b => not_b(1),
		cin => c(1),
		-- out of FullAdder
		sum => sub(1),
		cout => c(2)
	);

  FA_2: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(2),
		b => not_b(2),
		cin => c(2),
		-- out of FullAdder
		sum => sub(2),
		cout => c(3)
	);

  FA_3: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(3),
		b => not_b(3),
		cin => c(3),
		-- out of FullAdder
		sum => sub(3),
		cout => c(4)
	);

  FA_4: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(4),
		b => not_b(4),
		cin => c(4),
		-- out of FullAdder
		sum => sub(4),
		cout => c(5)
	);

  FA_5: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(5),
		b => not_b(5),
		cin => c(5),
		-- out of FullAdder
		sum => sub(5),
		cout => c(6)
	);

  FA_6: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(6),
		b => not_b(6),
		cin => c(6),
		-- out of FullAdder
		sum => sub(6),
		cout => c(7)
	);

  FA_7: entity work.FullAdder
	port map (
		-- into FullAdder
		a => a(7),
		b => not_b(7),
		cin => c(7),
		-- out of FullAdder
		sum => sub(7),
		cout => c(8)
	);

  diff <= sub;
  borrow_out <= not c(8);
end architecture Behavioral;

