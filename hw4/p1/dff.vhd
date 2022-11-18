library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is 
  generic(W : integer := 8);
  port(
    clk, clear: in std_ulogic;
    d : in std_ulogic_vector(W - 1 downto 0);
    q : out std_ulogic_vector(W - 1 downto 0)
  );
end entity DFF;

architecture struct of DFF is 
begin 
  
  d_proc : process(clk, clear, d) begin 
    if falling_edge(clear) then 
      q <= (others=>'0');
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;

end architecture struct;
