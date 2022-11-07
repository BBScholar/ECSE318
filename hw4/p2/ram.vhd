library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ram is 
  generic(
    W : integer := 32;
    SELECT_LINES : integer := 8
  );
  port(
    clk, write : in std_ulogic;
    addr : in std_ulogic_vector(SELECT_LINES - 1 downto 0);
    data_in : in std_ulogic_vector(W - 1 downto 0);
    data_out : out std_ulogic_vector(W - 1 downto 0)
  );
end entity ram;


architecture behav of ram is 
  type data_t is array (0 to 2**SELECT_LINES - 1) of std_ulogic_vector(W - 1 downto 0);

  signal data : data_t;
begin 

  proc : process(clk, write, addr, data_in, data) begin 
    data_out <= data(to_integer(unsigned(addr)));
    if rising_edge(clk) and write = '1' then 
      data(to_integer(unsigned(addr))) <= data_in;
    end if;
  end process;

end architecture;
