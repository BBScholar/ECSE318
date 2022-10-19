library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;

entity serial_adder is 
  
  generic (W : integer := 8);
  port(
    clk, clear: in std_ulogic;
    a, b : in std_ulogic;
    result, cout : out std_ulogic
  );
end serial_adder;

architecture rtl of serial_adder is 
  signal fa_a, fa_b, fa_c, fa_cout, fa_s : std_ulogic;
begin

  sr_a : entity work.shift_register
    generic map(W => W)
    port map(clk=>clk, shift_in=>a, shift_out=>fa_a);

  sr_b: entity work.shift_register
    generic map(W => W)
    port map(clk=>clk, shift_in=>b, shift_out=>fa_b);

  sr_c: entity work.shift_register
    generic map(W => W)
    port map(clk=>clk, shift_in=>fa_s, shift_out=>result);

  fa : entity work.full_adder
    port map(a=>fa_a, b=>fa_b, c=>fa_c, s=>fa_s, cout=>fa_cout);

  carry_reg : entity work.reg1
    port map(clk=>clk, d=>fa_cout, clear=>clear,  q=>fa_c);


end rtl;
