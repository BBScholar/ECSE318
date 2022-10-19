library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity multiplier is 
  generic(W : integer := 8);
  port(
    x, y : in std_ulogic_vector(W - 1 downto 0);
    p : out std_ulogic_vector(2 * W - 1 downto 0)
  );
end entity multiplier;

architecture rtl of multiplier is 

  type arr is array (0 to W) of std_ulogic_vector(W - 1 downto 0);

  signal carry, sum : arr;
  signal final_sum_in : std_ulogic_vector(W - 1 downto 0);
  signal final_carry : std_ulogic_vector(W downto 0);
begin
  carry(0) <= std_ulogic_vector(to_unsigned(0, W));
  sum(0) <= std_ulogic_vector(to_unsigned(0, W));
  final_sum_in <= '0' & sum(W)(W-1 downto 1);
  final_carry(0) <= '0';

  gen: for i in 0 to W - 1 generate
    gen_block: block 
      signal a, c : std_ulogic_vector(W - 1 downto 0);
    begin 
      a <= y and (W - 1 downto 0 => x(i));
      c <= '0' & sum(i + 1)(W - 1 downto 1);

      csa : entity work.csa_module(rtl)
        generic map(W=>W)
        port map(a=>a, b=>carry(i), c=>c, sout=>sum(i + 1), cout=>carry(i + 1));

      fa : entity work.full_adder(rtl)
        port map(a=>final_sum_in(i), b=>carry(W)(i), c=>final_carry(i), s=>p(W + i), cout=>final_carry(i + 1));

    end block gen_block;
  
    p(i) <= sum(i + 1)(0);

  end generate;
  


end architecture rtl;
