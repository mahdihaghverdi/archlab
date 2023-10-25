library ieee;
use ieee.std_logic_1164.all;


entity full_adder_tb is
end full_adder_tb;

architecture tb of full_adder_tb is
    signal a, b, ci : std_logic;  -- inputs
    signal sum, carry : std_logic;  -- outputs
begin
    -- connecting testbench signals with full_adder.vhdl
    UUT : entity work.full_adder port map (a => a, b => b, ci => ci, s => sum, c => carry);

    -- inputs
    -- ci ba
    --  0 00 at   0 ns
    --  0 01 at  20 ns
    --  0 10 at  40 ns
    --  0 11 at  60 ns
    --  1 00 at  80 ns
    --  1 01 at 100 ns
    --  1 10 at 120 ns
    --  1 11 at 140 ns
    --  1 11 at 160 ns

    a <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns, '1' after 100 ns, '0' after 120 ns, '1' after 140 ns, '1' after 160 ns;
    b <= '0', '1' after 40 ns, '0' after 80 ns, '0' after 120 ns, '1' after 140 ns, '1' after 160 ns;
    ci <= '0', '1' after 80 ns, '1' after 120 ns, '1' after 160 ns;
end tb ;
