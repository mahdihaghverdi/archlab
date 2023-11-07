library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
    port (
        a, b: in std_logic_vector(31 downto 0);
        s   : out std_logic_vector(31 downto 0);
        z, c, ovf: out std_logic;
        m   : in std_logic_vector (3 downto 0)
    );
end ALU;

architecture arch of ALU is
    signal add, addu, sub, subu, slt, sltu, and, or, nor, xor: std_logic_vector(31 downto 0);

begin
    plus  <= std_logic_vector(unsigned(a) + unsigned(b));
    minus <= std_logic_vector(unsigned(a) - unsigned(b));
    mul   <= std_logic_vector((unsigned(a(3 downto 0))) * (unsigned(b(3 downto 0))));
    mand  <= a and b;
    mor   <= a or b;
    mnor  <= a nor b;
    mnand <= a nand b;

    inner_mux : entity work.mux8x1 port map (
        i0 => "11111111",
        i1 => plus,
        i2 => minus,
        i3 => mul,
        i4 => mand,
        i5 => mor,
        i6 => mnor,
        i7 => mnand,
        sel => sel,
        s => s
    );
end arch;
