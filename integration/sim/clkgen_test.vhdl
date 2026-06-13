-- Example of how to run multiple tests from a single testbench.
-- The key is to use multiple architectures with config.

library ieee; use ieee.std_logic_1164.all;
library sim; use sim.all;

entity tb is
end entity;


-- Here's the first architecture
-- There is another one below!
architecture tb of tb is
    -- 1GHz clock.
    constant clock_period: time := 1 ns;
    -- Run the simulation for this long.
    constant sim_run_length: time := 30 * clock_period;
    -- Top level signals.
    signal clk, rst: std_logic;
begin
    reset: entity resetgen(sim) port map(rst);
    uut: entity clkgen(sim) generic map (clock_period) port map (rst, clk);
    -- Terminates the simulation after `sim_run_length` time has elapsed.
    sim_end: process
    begin
       wait for sim_run_length;
       std.env.finish; -- VHDL-2008.
    end process;
end architecture;


-- This is a second architecture, and the appropriate configuration is just
-- below.
architecture tb2 of tb is
begin
    sim_end: process
    begin
       std.env.finish; -- VHDL-2008.
    end process;
end architecture;

configuration config_tb2 of tb is
    for tb2
    end for;
end configuration;
