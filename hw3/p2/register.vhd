
library IEEE;
use IEEE.std_logic_1164.all;

entity reg1 is 
  generic(W : integer := 8);
  port(
    clk, clear, d : in std_ulogic;
    q : out std_ulogic
  );

end reg1;

architecture rtl of reg1 is 
begin 

  dff : process(clk, clear, d) begin 
    if rising_edge(clk) then 
      if clear = '1' then 
        q <= '0';
      else
        q <= d; 
      end if;
    end if;
  end process;

end;


