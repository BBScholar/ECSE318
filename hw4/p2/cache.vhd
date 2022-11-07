library IEEE;
use IEEE.std_logic_1164.all;

use work.all;


entity cache is 
  port(
    clk : in std_ulogic;

    pstrobe, prw : in std_ulogic;
    paddress : in std_ulogic_vector(15 downto 0);
    pready : out std_ulogic;
    pdata : inout std_logic_vector(31 downto 0);
  
    sysstrobe, sysrw : out std_ulogic;
    sysaddress : out std_ulogic_vector(15 downto 0); 
    sysdata : inout std_logic_vector(31 downto 0)
  );
end entity cache;

architecture behav of cache is 
  subtype addr_t is std_ulogic_vector(15 downto 0);
  subtype data_t is std_ulogic_vector(31 downto 0);
  subtype tag_t is std_ulogic_vector(5 downto 0);
  subtype index_t is std_ulogic_vector(7 downto 0);

  type block_t is record
    valid : std_ulogic;
    tag : tag_t;
    data : data_t;
  end record;
  type cache_blocks_t is array (0 to 2 ** index_t'length - 1 ) of block_t;

  signal cache_blocks : cache_blocks_t;

  -- input derivatives
  signal input_addr : addr_t;
  signal input_index : index_t;
  signal input_tag : tag_t;
  
  -- ram control signals
  signal current_tag: tag_t;
  signal current_data : data_t;

  -- tag ram 
  signal tag_write : std_ulogic;

  -- tag comparison 
  signal tag_match : std_ulogic;

  -- data lines and write flags
  signal p_tx, p_rx, sys_tx, sys_rx, dram_in, dram_out: data_t;
  signal p_write, sys_write, dram_write: std_ulogic;
  signal pdata_sel, dram_sel : std_ulogic;

  -- control ku

begin 
  input_tag <= paddress(15 downto 10);
  input_index <= paddress(9 downto 2);
  
  -- forward address to system 
  sysaddress <= paddress;

  -- pdata tx mux
  with pdata_sel select 
    p_tx <= sys_rx when '1',
            dram_out when others;

  -- dram in mux 
  with dram_sel select 
    dram_in <= sys_rx when '1',
               p_rx when others;

  -- tristate buffers
  p_tristate_buf : entity work.tri_state_buffer(behav)
    generic map(W=>32)
    port map(
      io_data=>pdata, write_data=>p_tx, 
      write=>p_write, read_data=>p_rx
    );

  sys_trisate_buf : entity work.tri_state_buffer(behav)
    generic map(W=>32)
    port map(
      io_data=>sysdata, write_data=>sys_tx,
      write=>sys_write, read_data=>sys_rx
    );

  -- state machine 
  controller : entity work.cache_controller(behav)
    port map(
      clk=>clk, prw=>prw, pstrobe=>pstrobe, pready=>pready,
      sysrw=>sysrw, sysstrobe=>sysstrobe,
      tag_match=>tag_match,
      pdata_sel=>pdata_sel, p_write=>p_write,
      sys_write => sys_write,
      dram_sel =>dram_sel, dram_write=>dram_write,
      tag_write=>tag_write
    );
  
  -- tag ram entity
  tag_ram : entity work.ram(behav)
    generic map(W=>tag_t'length, SELECT_LINES=>index_t'length)
    port map(
      clk=>clk, write=>tag_write, addr=>input_index, data_in=>input_tag,
      data_out=>current_tag
    );

  -- tag comparator
  tag_compare : process(current_tag, input_tag) begin 
    if current_tag = input_tag then 
      tag_match <= '1';
    else 
      tag_match <= '0';
    end if;
  end process;
  
  -- data ram
  data_ram : entity work.ram(behav)
    generic map(W =>data_t'length, SELECT_LINES=>index_t'length)
    port map(
      clk=>clk, write=>dram_write, addr=>input_index,
      data_in=>dram_in, data_out=>dram_out
    );

end architecture behav;
