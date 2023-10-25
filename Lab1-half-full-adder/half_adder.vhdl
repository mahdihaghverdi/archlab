library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        i, ii : in std_logic;
        sum, carry : out std_logic
    );
end half_adder;

architecture arch of half_adder is
begin
    sum <= i xor ii;
    carry <= i and ii;
end arch;
