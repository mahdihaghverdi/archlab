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
         "0000" after 20 ns,
         "0010" after 40 ns;
    a <= "00000000000000000000000000000000",
         "00000000000000000000000000000010" after 20 ns,
         "00000000000000000000000000000010" after 40 ns,
         "00000000000000000000000000000010" after 60 ns;

    b <= "00000000000000000000000000000000",
         "00000000000000000000000000000001" after 20 ns,
         "00000000000000000000000000000011" after 40 ns,
         "00000000000000000000000000000011" after 60 ns;

end tb;
