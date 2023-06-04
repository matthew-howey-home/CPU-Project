
library IEEE;
use IEEE.std_logic_1164.all;

entity AND_Gate_TB is
end entity AND_Gate_TB;

architecture tb_arch of AND_Gate_TB is
  component AND_Gate
    port (
      A, B: in std_logic;
      Y: out std_logic
    );
  end component;

  signal A_tb, B_tb: std_logic := '0';
  signal Y_tb: std_logic;

begin
  UUT: AND_Gate
    port map (
      A => A_tb,
      B => B_tb,
      Y => Y_tb
    );

  stimulus_proc: process
  begin
    A_tb <= '0';
    B_tb <= '0';
    wait for 10 ns;
    report "Separate Test Bench! Input: " & std_logic'image(A_tb) & ", " & std_logic'image(B_tb);
    report "Output: " & std_logic'image(Y_tb);

    A_tb <= '0';
    B_tb <= '1';
    wait for 10 ns;
    report "Input: " & std_logic'image(A_tb) & ", " & std_logic'image(B_tb);
    report "Hello First! Output: " & std_logic'image(Y_tb);

    A_tb <= '1';
    B_tb <= '0';
    wait for 10 ns;
    report "Input: " & std_logic'image(A_tb) & ", " & std_logic'image(B_tb);
    report "Hello First! Output: " & std_logic'image(Y_tb);

    A_tb <= '1';
    B_tb <= '1';
    wait for 10 ns;
    report "Input: " & std_logic'image(A_tb) & ", " & std_logic'image(B_tb);
    report "Hello First! Output: " & std_logic'image(Y_tb);
    
  end process;
end architecture tb_arch;
