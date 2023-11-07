library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
    port (
        A, B: in std_logic_vector(31 downto 0);
        S   : out std_logic_vector(31 downto 0);
        z, c, ovf: out std_logic;
        m   : in std_logic_vector (3 downto 0)
    );
end ALU;

architecture arch of ALU is
    component mux8x1 is
        port (
            i0, i1, i2, i3,
            i4, i5, i6, i7 : in std_logic_vector (7 downto 0);
            sel            : in std_logic_vector (2 downto 0);
            S         : out std_logic_vector (7 downto 0)
        );
    end component;

    signal plus, minus, mul, mand, mor, mnor, mnand : std_logic_vector(7 downto 0);
begin
    plus  <= std_logic_vector(unsigned(A) + unsigned(B));
    minus <= std_logic_vector(unsigned(A) - unsigned(B));
    mul   <= std_logic_vector((unsigned(A(3 downto 0))) * (unsigned(B(3 downto 0))));
    mand  <= A and B;
    mor   <= A or B;
    mnor  <= A nor B;
    mnand <= A nand B;

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
        S => S
    );
end arch;
