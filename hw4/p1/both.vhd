library IEEE;
use IEEE.std_logic_1164.all;

entity both is 
  port(
    clk, R, A, RESET : in std_ulogic;
    E_s, E_b, diff: out std_ulogic
  );
end entity both;


architecture struct of both is
  
  signal E_s_int, E_b_int : std_ulogic;
begin 

  E_s <= E_s_int;
  E_b <= E_b_int;
  diff <= E_s_int xor E_b_int;

  struct_fsm : entity work.handshake(struct)
    port map(clk=>clk, R=>R, A=>A, RESET=>RESET, E=>E_s_int);

  behav_fsm : entity work.handshake(behav)
    port map(clk=>clk, R=>R, A=>A, RESET=>RESET, E=>E_b_int);

end architecture struct;
