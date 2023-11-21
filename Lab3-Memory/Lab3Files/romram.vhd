library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity romram is
   port(clk_100MHZ: in std_logic;
        switch: in std_logic;
        leds: out std_logic_vector(7 downto 0));
end romram;
architecture structural of romram is
   component rom8x8
      port(addr: in std_logic_vector(2 downto 0);
           dout: out std_logic_vector(7 downto 0));
   end component;
   component clock_divide
      port(clk_in: in std_logic;
           clk_out: out std_logic);
	end component;
   component bram8x8
      port(clka: in std_logic;
           wea: in std_logic_vector(0 downto 0);
           addra: in std_logic_vector(2 downto 0);
           dina: in std_logic_vector(7 downto 0);
           douta: out std_logic_vector(7 downto 0));
	end component;
   signal clk_1Hz: std_logic;
   signal addr_counter: std_logic_vector(2 downto 0) := "000";
   signal dout_rom,dout_bram: std_logic_vector(7 downto 0);
   signal dina_null: std_logic_vector(7 downto 0) := "00000000";
   signal wea_null: std_logic_vector(0 downto 0) := "0";
begin
   clock_divider: clock_divide port map(clk_100MHz,clk_1Hz);
   rom: rom8x8 port map(addr_counter,dout_rom);
   bram: bram8x8 port map(
      clka => clk_1Hz,
      wea => wea_null,
      addra => addr_counter,
      dina => dina_null,
      douta => dout_bram);
   process(clk_1Hz) is
   begin
      if(clk_1Hz'event and clk_1Hz = '1') then
         case switch is
	    when '0' =>
	       leds <= dout_rom;
	    when '1' =>
	       leds <= dout_bram;
	    when others => null;
         end case;
	 addr_counter <= std_logic_vector(unsigned(addr_counter) + 1);
      end if;
   end process;
end structural;

