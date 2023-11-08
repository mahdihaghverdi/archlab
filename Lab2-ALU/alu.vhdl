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
begin
process(m, a, b) is
begin
    z <= '0';
    ovf <= '0';
    c <= '0';

    case m is
        when "0000" =>  -- add
            s <= std_logic_vector(signed(a) + signed(b));
        when "0001" =>  -- addu
            s <= std_logic_vector(unsigned(a) + unsigned(b));
        when "0010" =>  -- sub
            if signed(a) = signed(b) then
                z <= '1';
            else
                z <= '0';
            end if;
            s <= std_logic_vector(signed(a) - signed(b));
        when "0011" =>  -- subu
            s <= std_logic_vector(unsigned(a) - unsigned(b));
        when "0100" =>  -- slt
            if signed(a) < signed(b) then
                s <= (0 => '1', others => '0');
            else
                s <= (others => '0');
            end if;
        when "0101" =>  -- sltu
            if unsigned(a) < unsigned(b) then
                s <= (0 => '1', others => '0');
            else
                s <= (others => '0');
            end if;
        when "0110" =>  -- and
            s <= a and b;
        when "0111" =>  -- or
            s <= a or b;
        when "1000" =>  -- nor
            s <= a nor b;
        when "1001" =>  -- xor
            s <= a xor b;
        when others =>
            s <= (others => 'U');
    end case;
end process;
end arch;
