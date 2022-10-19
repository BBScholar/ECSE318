library IEEE;
use IEEE.std_logic_1164.all;

entity csa_module is 
  generic(W : integer := 8);
  port(
    a, b, c : in std_ulogic_vector(W - 1 downto 0);
    cout, sout : out std_ulogic_vector(W - 1 downto 0)
  );
end entity csa_module;

architecture rtl of csa_module is 

begin 

  gen : for i in 0 to W - 1 generate
    fa : entity work.full_adder
      port map(a=>a(i), b=>b(i), c=>c(i), s=>sout(i), cout=>cout(i));
  end generate;

end architecture;


