library IEEE;
use IEEE.std_logic_1164.all;


entity shift_register is 
  generic (
    W : integer := 8
  );
  port(
    clk, shift_in: in std_ulogic;
    shift_out : out std_ulogic
  );

end shift_register;

architecture rtl of shift_register is 
  signal internal_reg : std_ulogic_vector(W - 1 downto 0) := (others => '0');
begin
  shift_out <= internal_reg(0);

  shift_proc : process(clk, shift_in)
  begin
    if rising_edge(clk) then
      internal_reg <= shift_in & internal_reg(W - 1 downto 1);
    end if;
  end process;

end architecture rtl;

architecture struct of shift_register is 
  signal internal_reg : std_ulogic_vector(W downto 0);
begin
  internal_reg(0) <= shift_in;
  shift_out <= internal_reg(W);

  reg_gen : for i in 0 to W - 1 generate
    dff : entity work.reg1(struct)
      port map(clk=>clk, clear=>'0', d=>internal_reg(i), q=>internal_reg(i + 1));
  end generate;

end architecture struct;
