library IEEE;
use IEEE.std_logic_1164.all;

entity prop_adder is 
  generic(W : integer := 8);
  port(
    a, b : in std_ulogic_vector(W - 1 downto 0);
    cin : in std_ulogic;
    s : out std_ulogic_vector(W - 1 downto 0);
    cout : out std_ulogic
  );
end entity prop_adder;


architecture rtl of prop_adder is 
  signal carry : std_ulogic_vector(W downto 0);
begin 
  carry(0) <= cin;
  cout <= carry(W);

  fa_gen : for i in 0 to W - 1 generate
    fa : entity work.full_adder
      port map(a=>a(i), b=>b(i), c=>carry(i), s=>s(i), cout=>carry(i + 1));
  end generate;


end;
