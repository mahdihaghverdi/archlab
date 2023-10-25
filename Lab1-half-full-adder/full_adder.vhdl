-- one bit full adder

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a, b, ci : in std_logic;
        s, c : out std_logic
    );
end full_adder;


architecture arch of full_adder is
    component half_adder
        port (
            i, ii : in std_logic;
            sum, carry : out std_logic
        );
    end component;

    for half_adder_0: half_adder use entity work.half_adder;
    for half_adder_1: half_adder use entity work.half_adder;
    signal asb, aab, asbco: std_logic;

    -- Instantiation
begin
    half_adder_0: half_adder port map(
        -- entity-signal-name => local-signal-name
        i => a,
        ii => b,
        sum => asb,
        carry => aab
    );
    half_adder_1: half_adder port map(
        i => asb,
        ii => ci,
        sum => s,
        carry => asbco
    );

    c <= aab or asbco;
end arch;
