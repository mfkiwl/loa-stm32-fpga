-------------------------------------------------------------------------------
-- Title      : Testbench for design "encoder_module"
-------------------------------------------------------------------------------
-- Author     : Fabian Greif  <fabian@kleinvieh>
-- Created    : 2011-12-16
-- Last update: 2011-12-31
-- Platform   : Spartan 3 
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.servo_module_pkg.all;
use work.bus_pkg.all;

-------------------------------------------------------------------------------
entity servo_module_tb is
end servo_module_tb;

-------------------------------------------------------------------------------
architecture tb of servo_module_tb is

   -- component generics
   constant BASE_ADDRESS : positive := 16#0100#;
   constant SERVO_COUNT  : positive := 11;

   -- component ports
   signal servo : std_logic_vector(SERVO_COUNT-1 downto 0);

   signal bus_o : busdevice_out_type;
   signal bus_i : busdevice_in_type :=
      (addr => (others => '0'),
       data => (others => '0'),
       we   => '0',
       re   => '0');
   signal reset : std_logic := '1';
   signal clk   : std_logic := '0';

begin
   -- component instantiation
   DUT : servo_module
      generic map (
         BASE_ADDRESS => BASE_ADDRESS,
         SERVO_COUNT  => SERVO_COUNT)
      port map (
         servo_p => servo,
         bus_o   => bus_o,
         bus_i   => bus_i,
         reset   => reset,
         clk     => clk);

   -- clock generation
   clk <= not clk after 10 NS;

   -- reset generation
   reset <= '1', '0' after 50 NS;

   waveform : process
   begin
      wait until falling_edge(reset);
      wait for 20 NS;

      wait until rising_edge(clk);
      bus_i.addr <= std_logic_vector(
         unsigned'(resize(x"0100", bus_i.addr'length)));
      bus_i.data <= x"0000";
      bus_i.we   <= '1';
      wait until rising_edge(clk);
      bus_i.we   <= '0';

      wait for 30 NS;

      wait until rising_edge(clk);
      bus_i.addr <= std_logic_vector(
         unsigned'(resize(x"0101", bus_i.addr'length)));
      bus_i.data <= x"7fff";
      bus_i.we   <= '1';
      wait until rising_edge(clk);
      bus_i.we   <= '0';
      wait until rising_edge(clk);
      
      bus_i.addr <= std_logic_vector(
         unsigned'(resize(x"0102", bus_i.addr'length)));
      bus_i.data <= x"ffff";
      bus_i.we   <= '1';
      wait until rising_edge(clk);
      bus_i.we   <= '0';
      wait until rising_edge(clk);

      bus_i.addr <= std_logic_vector(
         unsigned'(resize(x"0103", bus_i.addr'length)));
      bus_i.data <= x"0002";
      bus_i.we   <= '1';
      wait until rising_edge(clk);
      bus_i.we   <= '0';
      wait until rising_edge(clk);
      
   end process waveform;
end tb;