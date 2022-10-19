library IEEE;
use IEEE.std_logic_1164.all;

entity dff is 
  port(
    clk, d : in std_ulogic;
    q : out std_ulogic
  );
end entity dff;

architecture behav of dff is 
begin 

  dff_proc : process(clk) begin 
    if(rising_edge(clk)) then 
      q <= d;
    end if;
  end process;

end;
