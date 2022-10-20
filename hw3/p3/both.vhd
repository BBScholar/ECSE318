
library IEEE;
use IEEE.std_logic_1164.all;


entity both_fsm is 
  port(
    clk, e, w : in std_ulogic;
    out_s, out_b, out_diff : out std_ulogic
  );
end entity both_fsm;

architecture rtl of both_fsm is 
  signal out_s_int, out_b_int : std_ulogic;
begin 
  out_diff <= out_s_int xor out_b_int;
  out_s <= out_s_int;
  out_b <= out_b_int;
  
  fsm1 : entity work.state_machine(struct)
    port map(clk=>clk, e=>e, w=>w, o=>out_s_int);

  fsm2 : entity work.state_machine(behav)
    port map(clk=>clk, e=>e, w=>w, o=>out_b_int);

end architecture rtl;
