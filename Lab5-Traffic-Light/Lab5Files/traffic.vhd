library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity traffic is
    port (
        clk_100MHZ: in std_logic;
        rst: in std_logic;
        LEDS: out std_logic_vector(7 downto 0)
    );
end traffic;

architecture traffic of traffic is
    component clock_divide
        port (
            clk_in: in std_logic;
            clk_out: out std_logic
        );
	end component;

    -- clock
    signal clk_1Hz: std_logic;

    -- states
    type state_type is (s0, s1, s2, s3, s4, s5, s6);
    signal state: state_type;

    -- state counter
    signal count: std_logic_vector(2 downto 0);

begin
clock_divider: clock_divide port map (clk_100MHZ, clk_1Hz);

process(clk_1Hz, rst)
-- needed variables
variable one_sec   : std_logic_vector(2 downto 0) := '001';
variable two_sec   : std_logic_vector(2 downto 0) := '010';
variable three_sec : std_logic_vector(2 downto 0) := '011';
variable four_sec  : std_logic_vector(2 downto 0) := '100';

begin
	if rst = '0' then
		if clk_1Hz'event and clk_1Hz = '1' then
			if state /= s5 and state /= s6 then
				state <= s5;
				count <= "000";
			end if;
			case state is
				when s5 =>
					if count < one_sec then
						state <= s5;
						count <= count + 1;
					else
						state <= s6;
						count <= "000";
					end if;
				when s6 =>
					if count < one_sec then
						state <= s6;
						count <= count + 1;
					else
						state <= s5;
						count <= "000";
					end if;
				when others =>
					state <= s5;
					count <= "000";
            end case;
			end if;
    else  -- rst = '1'
        if clk_1Hz'event and clk_1Hz = '1' then
            case state is
                when s0 =>
                    if count < four_sec then
                        state <= s0;
                        count <= count + 1;
                    else
                        state <= s1;
                        count <= "000";
                    end if;
                when s1 =>
                    if count < two_sec then
                        state <= s1;
                        count <= count + 1;
                    else
                        state <= s2;
                        count <= "000";
                    end if;
                when s2 =>
                    if count < three_sec then
                        state <= s2;
                        count <= count + 1;
                    else
                        state <= s3;
                        count <= "000";
                    end if;
                when s3 =>
                    if count < one_sec then
                        state <= s3;
                        count <= count + 1;
                    else
                        state <= s4;
                        count <= "000";
                    end if;
                when s4 =>
                    if count < two_sec then
                        state <= s4;
                        count <= count + 1;
                    else
                        state <= s5;
                        count <= "000";
                    end if;
                when s5 =>
                    if count < one_sec then
                        state <= s5;
                        count <= count + 1;
                    else
                        state <= s6;
                        count <= "000";
                    end if;
                when s6 =>
                    if count < one_sec then
                        state <= s6;
                        count <= count + 1;
                    else
                        state <= s0;
                        count <= "000";
                    end if;
                when others =>
                    state <= s0;
                    count <= "000";
            end case;
        end if;
    end if;
end process;

process(state)
begin
case state is
		-- Red Yellow Green, Red Yellow Green, Red Green
		when s0 => LEDS <= "00110010"; -- Ga = 1, Rb = 1, Rw = 1
		when s1 => LEDS <= "01010010"; -- Ya = 1, Rb = 1, Rw = 1
		when s2 => LEDS <= "10000110"; -- Ra = 1, Gb = 1, Rw = 1
		when s3 => LEDS <= "10001010"; -- Ra = 1, Yb = 1, Rw = 1
		when s4 => LEDS <= "10010001"; -- Ra = 1, Rb = 1, Gw = 1
		when s5 => LEDS <= "10010010"; -- Ra = 1, Rb = 1, Rw = 1
		when s6 => LEDS <= "00000000"; -- All LEDs are off
		when others => LEDS <= "00110010"; -- Ga = 1, Rb = 1, Rw = 1
end case;
end process;
end traffic;
