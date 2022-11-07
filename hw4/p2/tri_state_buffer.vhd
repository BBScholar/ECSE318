library IEEE;
use IEEE.std_logic_1164.all;

entity tri_state_buffer is 
  generic(W : integer := 8);
  port(
    io_data : inout std_logic_vector(W - 1 downto 0);
    write_data : in std_ulogic_vector(W - 1 downto 0);
    write : in std_ulogic;
    read_data : out std_ulogic_vector(W - 1 downto 0)
  );
end entity tri_state_buffer;

architecture behav of tri_state_buffer is 
  signal output_sel : std_ulogic_vector(W - 1 downto 0);
begin 

  tri_proc : process(write, write_data) begin 
    if write = '1' then 
      io_data <= std_logic_vector(write_data);
    else 
      io_data <= (others=>'Z');
    end if;

  end process;
  
  read_data <= std_ulogic_vector(io_data);

end architecture behav;
