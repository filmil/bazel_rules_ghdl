
-- Filename: my_module.vhd

library ieee;
use ieee.std_logic_1164.all;

package q is
  -- Define the record type for configuration data
  
  type config_data is record
    enable      : std_logic;
    operation   : std_logic_vector(1 downto 0);  -- 2-bit operation code
    threshold   : integer range 0 to 255;
  end record;

end package;

library ieee;
use ieee.std_logic_1164.all;
use work.q.all;

-- Entity declaration
entity my_module is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    config  : in  config_data;   -- Record input parameter
    data_in : in  std_logic_vector(7 downto 0);
    data_out: out std_logic_vector(7 downto 0)
  );
end entity my_module;

-- Architecture definition
architecture behavioral of my_module is
begin

  process(clk, reset)
  begin
    if reset = '1' then
      data_out <= (others => '0'); 
    elsif rising_edge(clk) then
      if config.enable = '1' then  -- Check if the module is enabled
        case config.operation is
          when "00" =>  -- Pass-through
            data_out <= data_in;
          when "01" =>  -- Increment
            data_out <= data_in;
          when "10" =>  -- Thresholding
              data_out <= (others => '0'); 
          when others =>  -- Default (do nothing)
            null;
        end case;
      else
        data_out <= (others => '0'); 
      end if;
    end if;
  end process;

end architecture behavioral;
