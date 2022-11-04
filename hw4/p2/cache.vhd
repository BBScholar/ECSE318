library IEEE;
use IEEE.std_logic_1164.all;


entity cache is 
  port(
    clk : in std_ulogic;

    pstrobe, prw : in std_ulogic;
    paddress : in std_ulogic_vector(15 downto 0);
    pready : out std_ulogic;
    pdata : inout std_ulogic_vector(31 downto 0);
  
    sysstrobe, sysrw : out std_ulogic;
    sysaddress : out std_ulogic_vector(15 downto 0); 
    sysdata : inout std_ulogic_vector(31 downto 0)
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
  signal tag_rw, data_rw : std_ulogic;
  signal selected_tag : tag_t;
  signal selected_data : data_t;

  -- tag comparison 
  signal tags_eq : boolean;


  -- busses 
  signal addr_bus : addr_t;
  signal data_bus : data_t;

begin 
  input_tag <= paddress(15 downto 10);
  input_index <= paddress(9 downto 2);


  controller : entity work.cache_controller(behav)
    port map(
      clk=>clk, prw=>prw, pstrobe=>pstrobe, pready=>pready, sysrw=>sysrw, sysstrobe=>sysstrobe
    );

  proc : process(clk, pstrobe, paddress) begin 
  end process;

  tag_ram : entity work.ram(behav)
    generic map(W=>tag_t'length, SELECT_LINES=>index_t'length)
    port map(
      clk=>clk, rw=>tag_rw, data_io=>selected_tag, addr=>input_index
    );

  data_ram : entity work.ram(behav)
    generic map(W =>data_t'length, SELECT_LINES=>index_t'length)
    port map(
      clk=>clk, rw=>data_rw, data_io=>selected_data, addr=>input_index
    );


end architecture behav;
