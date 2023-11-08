library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture tb of alu_tb is
    signal a, b: std_logic_vector(31 downto 0);
    signal m   : std_logic_vector (3 downto 0);
    signal s   : std_logic_vector(31 downto 0);
    signal z, c, ovf: std_logic;

begin
    UUT : entity work.alu port map (
        a => a,
        b => b,
        m => m,
        s => s,
        z => z,
        c => c,
        ovf => ovf
    );

    m <= "0000",
         "0001" after 20 ns,
         "0010" after 40 ns,
         "0011" after 60 ns,
         "0100" after 80 ns,
         "0101" after 100 ns,
         "0110" after 120 ns,
         "0111" after 140 ns,
         "1000" after 160 ns,
         "1001" after 180 ns,
         "1001" after 200 ns;

    a <= "00000000000000000000000000000000",
         "00000000000000000000000000000011" after 20 ns,  -- add
         "00000000000000000000000000000011" after 40 ns,  -- addu
         "00000000000000000000000000000011" after 60 ns,  -- sub
         "00000000000000000000000000000011" after 80 ns,  -- subu
         "00000000000000000000000000000011" after 100 ns, -- slt
         "00000000000000000000000000000011" after 120 ns, -- sltu
         "00000000000000000000000000000011" after 140 ns, -- and
         "00000000000000000000000000000011" after 160 ns, -- or
         "00000000000000000000000000000011" after 180 ns, -- nor
         "00000000000000000000000000000011" after 200 ns; -- xor


    b <= "00000000000000000000000000000000",
         "00000000000000000000000000000011" after 20 ns,
         "00000000000000000000000000000011" after 40 ns,
         "00000000000000000000000000000010" after 60 ns,
         "00000000000000000000000000000010" after 80 ns,
         "00000000000000000000000000000010" after 100 ns,
         "00000000000000000000000000000010" after 120 ns,
         "00000000000000000000000000000010" after 140 ns,
         "00000000000000000000000000000010" after 160 ns,
         "00000000000000000000000000000010" after 180 ns,
         "00000000000000000000000000000010" after 200 ns;
end tb;
