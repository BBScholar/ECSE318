
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
    if rising_edge(clear) then
      q <= '0';
    elsif rising_edge(clk) then 
      q <= d;
    end if;
  end process;

end;


