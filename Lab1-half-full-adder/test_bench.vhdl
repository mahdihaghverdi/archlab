library ieee;
use ieee.std_logic_1164.all;


entity full_adder_process_tb is
end full_adder_process_tb;

architecture tb of full_adder_process_tb is
    signal a, b, ci : std_logic;  -- inputs
    signal sum, carry : std_logic;  -- outputs
begin
    -- connecting testbench signals with full_adder.vhdl
    UUT : entity work.full_adder port map (a => a, b => b, ci => ci, s => sum, c => carry);
    tb1 : process
        constant period: time := 20 ns;
        begin
            -- a b  s c
            -- 0 0  0 0
            -- 0 1  1 0
            -- 1 0  1 0
            -- 1 1  0 1

            a <= '0';
            b <= '0';
            ci <= '0';
            wait for period;
            assert ((sum = '0') and (carry = '0'))  -- expected output
            -- error will be reported if sum or carry is not 0
            report "test failed for input combination 000" severity error;

            a <= '0';
            b <= '1';
            ci <= '0';
            wait for period;
            assert ((sum = '1') and (carry = '0'))
            report "test failed for input combination 001" severity error;

            a <= '1';
            b <= '0';
            ci <= '0';
            wait for period;
            assert ((sum = '1') and (carry = '0'))
            report "test failed for input combination 010" severity error;

            a <= '1';
            b <= '1';
            ci <= '0';
            wait for period;
            assert ((sum = '0') and (carry = '1'))
            report "test failed for input combination 011" severity error;


            a <= '0';
            b <= '0';
            ci <= '1';
            wait for period;
            assert ((sum = '1') and (carry = '0'))  -- expected output
            -- error will be reported if sum or carry is not 0
            report "test failed for input combination 100" severity error;

            a <= '0';
            b <= '1';
            ci <= '1';
            wait for period;
            assert ((sum = '0') and (carry = '1'))
            report "test failed for input combination 101" severity error;

            a <= '1';
            b <= '0';
            ci <= '1';
            wait for period;
            assert ((sum = '0') and (carry = '1'))
            report "test failed for input combination 110" severity error;

            a <= '1';
            b <= '1';
            ci <= '1';
            wait for period;
            assert ((sum = '1') and (carry = '1'))
            report "test failed for input combination 111" severity error;


            assert false report "all tests passed." severity note;
            wait; -- indefinitely suspend process
        end process;
end tb ;
