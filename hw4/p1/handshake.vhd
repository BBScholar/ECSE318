library IEEE;
use IEEE.std_logic_1164.all;

entity handshake is 
  port(
    clk, R, A : in std_ulogic;
    E : out std_ulogic;
  );
end entity handshake;

architecture behav of handshake is 
  type state_t is ();
begin

  proc : process(clk, R, A) begin 
    if rising_edge(clk) begin 

    end if;
  end process;


end architecture behav;
