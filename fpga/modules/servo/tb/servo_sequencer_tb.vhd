-------------------------------------------------------------------------------
-- Title      : Testbench for design "servo_sequencer"
-------------------------------------------------------------------------------
-- Author     : Fabian Greif  <fabian@kleinvieh>
-- Created    : 2011-12-16
-- Last update: 2011-12-23
-- Platform   : Spartan 3 
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.servo_sequencer_pkg.all;

-------------------------------------------------------------------------------
entity servo_sequencer_tb is
end servo_sequencer_tb;

-------------------------------------------------------------------------------
architecture tb of servo_sequencer_tb is

   -- component ports
   signal enable : std_logic_vector(7 downto 0);
   signal counter   : std_logic_vector(15 downto 0);

   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

begin
   -- component instantiation
   DUT : servo_sequencer
      port map (
         enable_p  => enable,
         counter_p => counter,
         reset     => reset,
         clk       => clk);
   
   -- clock generation
   clk <= not clk after 10 NS;

   reset <= '1', '0' after 30 NS;

--   waveform : process
--   begin
--      wait until falling_edge(reset);
--
--   end process waveform;
end tb;
