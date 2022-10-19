library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is 
  port(
    clk, e, w : in std_ulogic;
    o : out std_ulogic
  );
end entity state_machine;

architecture struct of state_machine is 
  
  signal out_a, out_b : std_ulogic;
  signal in_a, in_b : std_ulogic;
begin 
  o <= out_a nor out_b;

  in_a <= e or (out_a and not out_b) or (w and out_a);
  in_b <= w or (out_b and not out_a) or (e and out_b);

  dff_a : entity work.dff(behav)
    port map(clk=>clk, d=>in_a, q=>out_a);

  dff_b : entity work.dff(behav)
    port map(clk=>clk, d=>in_b, q=>out_b);

end architecture struct;

architecture behav of state_machine is 
  signal out_a, out_b : std_ulogic;
begin 

  
  output : process(out_a, out_b) begin 
    o <= out_a nor out_b;
  end process;

  reg : process(clk) begin
    if(rising_edge(clk)) then
      out_a <= e or (out_a and not out_b) or (w and out_a);
      out_b <= w or (out_b and not out_a) or (e and out_b);
    end if;
  end process;

end architecture behav;
