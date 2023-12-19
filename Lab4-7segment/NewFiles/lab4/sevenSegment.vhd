library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ssegment is
   port(clk_100MHz: in std_logic;
        reset: in std_logic;
        an: out std_logic_vector(3 downto 0);
        sseg: out std_logic_vector(6 downto 0));
end ssegment;
architecture behave of ssegment is
component clock_divide
   port(clk_in: in std_logic;
	     clk_out: out std_logic);
end component;
component decodeSevenSeg
   port(din: in std_logic_vector(3 downto 0);
        dout: out std_logic_vector(6 downto 0));
end component;
   signal clk_100Hz: std_logic;
   signal s_reg: unsigned(1 downto 0) ;
	signal s_next: unsigned(1 downto 0);
   signal myNum: std_logic_vector(15 downto 0):=
	"0000010100000001";
   signal snum: std_logic_vector(3 downto 0);
begin
   clock_divider: clock_divide port map(clk_100MHz,clk_100Hz);
-- register
	process(clk_100Hz,reset)
   begin
	   if(reset = '0') then s_reg <= (others => '0');
      elsif(clk_100Hz'event and clk_100Hz = '1') then
         s_reg <= s_next;
      end if;
    end process;
-- next state logic
	 process(s_reg)
	 begin
       s_next <= s_reg + 1;
	 end process;
-- output logic
	 process(s_reg)
	 begin
	    if(s_reg = "00") then
		    an <= "1110";
			 snum <= myNum(3 downto 0);
	    elsif(s_reg = "01") then
		    an <= "1101";
			 snum <= myNum(7 downto 4);
		 elsif(s_reg = "10") then
			 an <= "1011";
			 snum <= myNum(11 downto 8);
		 else
		    an <= "0111";
			 snum <= myNum(15 downto 12);
		 end if;
    end process;
    decode_seven: decodesevenseg port map(snum,sseg);	 
 end behave;