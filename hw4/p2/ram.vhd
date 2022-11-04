library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ram is 
  generic(
    W : integer := 32;
    SELECT_LINES : integer := 8
  );
  port(
    clk, rw : in std_ulogic;
    addr : in std_ulogic_vector(SELECT_LINES - 1 downto 0);
    data_io : inout std_ulogic_vector(W - 1 downto 0)
  );
end entity ram;


architecture behav of ram is 
  type data_t is array (0 to 2**SELECT_LINES - 1) of std_ulogic_vector(W - 1 downto 0);

  signal data : data_t;
begin 

  proc : process(clk, rw, addr, data_io) 
    constant hiz : std_ulogic_vector(W - 1 downto 0) := (others=>'Z');
  begin 
    if rw = '1' then -- reading
      data_io <= data(to_integer(unsigned(addr)));
    elsif rw = '0' then 
      data_io <= hiz;
      data(to_integer(unsigned(addr))) <= data_io after 1 ns;
    end if;
  end process;
  
end architecture;
