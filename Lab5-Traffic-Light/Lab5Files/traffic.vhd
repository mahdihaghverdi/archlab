library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity traffic is
    port (
        clk_100MHZ: in STD_LOGIC;
        rst: in STD_LOGIC;
        lights: out STD_LOGIC_VECTOR(7 downto 0)
    );
end traffic;

architecture traffic of traffic is
    component clock_divide
        port (
            clk_in: in std_logic;
            clk_out: out std_logic
        );
	end component;

    type state_type is (s0, s1, s2, s3, s4, s5, s6);
    signal state: state_type;
    signal count: STD_LOGIC_VECTOR(2 downto 0);
    signal clk_1Hz: std_logic;
    constant SEC4: STD_LOGIC_VECTOR(2 downto 0) := "100";
    constant SEC3: STD_LOGIC_VECTOR(2 downto 0) := "011";
    constant SEC2: STD_LOGIC_VECTOR(2 downto 0) := "010";
    constant SEC1: STD_LOGIC_VECTOR(2 downto 0) := "001";

begin
clock_divider: clock_divide port map (clk_100MHZ,clk_1Hz);

process(clk_1Hz, rst)
begin
	if rst = '0' then
		if clk_1Hz'event and clk_1Hz = '1' then
			if state /= s5 and state /=s6 then
				state <= s5;
				count <= "000";
			end if;
			case state is 
				when s5 =>
					if count < SEC1 then
						state <= s5;
						count <= count + 1;
					else
						state <= s6;
						count <= "000";
					end if;
				when s6 =>
					if count < SEC1 then
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
    else
        if clk_1Hz'event and clk_1Hz = '1' then
            case state is
                when s0 =>
                    if count < SEC4 then
                        state <= s0;
                        count <= count + 1;
                    else
                        state <= s1;
                        count <= "000";
                    end if;
                when s1 =>
                    if count < SEC2 then
                        state <= s1;
                        count <= count + 1;
                    else
                        state <= s2;
                        count <= "000";
                    end if;
                when s2 =>
                    if count < SEC3 then
                        state <= s2;
                        count <= count + 1;
                    else
                        state <= s3;
                        count <= "000";
                    end if;
                when s3 =>
                    if count < SEC1 then
                        state <= s3;
                        count <= count + 1;
                    else
                        state <= s4;
                        count <= "000";
                    end if;
                when s4 =>
                    if count < SEC2 then
                        state <= s4;
                        count <= count + 1;
                    else
                        state <= s5;
                        count <= "000";
                    end if;
                when s5 =>
                    if count < SEC1 then
                        state <= s5;
                        count <= count + 1;
                    else
                        state <= s6;
                        count <= "000";
                    end if;
                when s6 =>
                    if count < SEC1 then
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
		when s0 =>
            lights <= "00110010"; -- Ga = 1, Rb = 1, Rw = 1
		when s1 =>
            lights <= "01010010"; -- Ya = 1, Rb = 1, Rw = 1
		when s2 =>
            lights <= "10000110"; -- Ra = 1, Gb = 1, Rw = 1
		when s3 =>
            lights <= "10001010"; -- Ra = 1, Yb = 1, Rw = 1
		when s4 =>
            lights <= "10010001"; -- Ra = 1, Rb = 1, Gw = 1
		when s5 =>
            lights <= "10010010"; -- Ra = 1, Rb = 1, Rw = 1
		when s6 =>
            lights <= "00000000"; -- All LEDs are off
		when others =>
            lights <= "00110010"; -- Ga = 1, Rb = 1, Rw = 1
end case;
end process;
end traffic; 
