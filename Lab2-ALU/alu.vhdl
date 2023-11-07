library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
    port (
        a, b: in std_logic_vector(31 downto 0);
        m   : in std_logic_vector (3 downto 0);
        s   : out std_logic_vector(31 downto 0);
        z, c, ovf: out std_logic
    );
end ALU;

architecture arch of ALU is
    signal add, addu, sub, subu, slt, sltu, andx, orx, norx, xorx: std_logic_vector(31 downto 0);

begin
process(m, a, b) is
begin
    case m is
        when "0000" =>
            s <= std_logic_vector(signed(a) + signed(b));
        when "0010" =>
            s <= std_logic_vector(signed(a) - signed(b));
        when others => -- 'U', 'X', '-', etc.
            s <= (others => 'U');
    end case;
end process;
end arch;
