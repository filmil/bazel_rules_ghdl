library ieee; use ieee.std_logic_1164.all;

-- clkgen generates a clock with the supplied clock period.
entity clkgen is
    generic(
        -- The clock period to use.
        clock_period: time
    );
    port(
        -- When reset is asserted, the clock generator keeps the
        -- `clk` signal at '0'.
        rst: in std_logic
        -- Clock signal with the requested `clock_period`.
        ; clk: out std_logic
    );
end entity;

-- Intended for driving simulation.
architecture sim of clkgen is

begin

    gen: process is
    begin
        clk <= '0' when rst = '1'
               else '0' after clock_period / 2, '1' after clock_period;
        wait for clock_period;
    end process;

end architecture;
