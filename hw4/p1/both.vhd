library IEEE;
use IEEE.std_logic_1164.all;

entity both is
  port(
    clk, R, A, RESET : in std_ulogic;
    E_S, E_B, E_DIFF: out std_ulogic
  );
end entity both;

architecture struct of both is 
  signal E_S_INT, E_B_INT : std_ulogic;
begin 
  E_S <= E_S_INT;
  E_B <= E_B_INT;
  E_DIFF <= E_S_INT xor E_B_INT;

  struct_fsm : entity work.handshake(struct)
    port map(clk=>clk, R=>R, A=>A, RESET=>RESET, E=>E_S_INT);

  behav_fsm : entity work.handshake(behav)
    port map(clk=>clk, R=>R, A=>A, RESET=>RESET, E=>E_B_INT);

end architecture;
