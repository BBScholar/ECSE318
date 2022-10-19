library IEEE;

use IEEE.std_logic_1164.all;

entity full_adder is 
port(
  a, b, c : in std_ulogic;
  s, cout : out std_ulogic
);
end full_adder;


architecture rtl of full_adder is 
begin
  s <= a XOR b XOR c;
  cout <= (a AND b) OR (a AND c) OR (b and C);
end rtl;
