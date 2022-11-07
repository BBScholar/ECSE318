library IEEE;
use IEEE.std_logic_1164.all;

entity cache_controller is 
  port(
    clk : in std_ulogic;
    pstrobe, prw : in std_ulogic;
    pready : out std_ulogic;
    sysstrobe, sysrw : out std_ulogic;

    -- input signals 
    tag_match : in std_ulogic;

    -- output signals
    pdata_sel, p_write : out std_ulogic;
    sys_write : out std_ulogic;
    dram_sel, dram_write : out std_ulogic;
    tag_write : out std_logic
  );
end entity cache_controller;


architecture behav of cache_controller is

  constant wait_cycles : integer := 4;

  type state_t is (idle, write_begin, write_wait, write_done, read_hit, read_begin, read_wait, read_done);
  
  signal state : state_t := idle;
  signal next_state : state_t;
  signal counter : integer;
  signal wait_done : std_ulogic;
begin 

  wait_done <= '1' when counter = 0 else '0';

  switch_state_proc : process(clk, next_state) begin 
    if rising_edge(clk) then 
      state <= next_state;   
    end if;
  end process;

  counter_proc : process(clk, state, counter) begin 
    if rising_edge(clk) then 
      case state is 
        when write_wait | read_wait =>
          counter <= counter - 1;
        when others =>
          counter <= wait_cycles - 1;
      end case;
    end if;
  end process;

  next_state_proc : process(state, pstrobe, prw, tag_match, wait_done) begin 

    case state is 
      when idle =>
        if pstrobe = '1' then 
          if prw = '0' then 
            next_state <= write_begin;
          elsif prw = '1' and tag_match = '1' then
            next_state <= read_hit;
          else 
            next_state <= read_begin;
          end if;
        else 
          next_state <= idle;
        end if;
      when write_begin =>
        next_state <= write_wait;
      when write_wait =>
        if wait_done = '1' then 
          next_state <= write_done;
        else 
          next_state <= write_wait;
        end if;
      when read_begin => 
        next_state <= read_wait;
      when read_wait =>
        if wait_done = '1' then 
          next_state <= read_done;
        else 
          next_state <= read_wait;
        end if;
      when write_done | read_done | read_hit =>
        next_state <= idle;
    end case;
  
  end process;

  state_proc : process(state) begin 
    case state is 
      when idle =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '0';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '0';
        sysrw <= '0';
        pready <= '0';
      when read_hit =>
        pdata_sel <= '0';
        p_write <= '1';
        sys_write <= '0';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '0';
        sysrw <= '0';
        pready <= '1';
      when read_begin =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '0';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '1';
        sysrw <= '1';
        pready <= '0';
      when read_wait =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '0';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '0';
        sysrw <= '1';
        pready <= '0';
      when read_done =>
        pdata_sel <= '1';
        p_write <= '1';
        sys_write <= '0';
        dram_sel <= '1';
        dram_write <= '1';
        tag_write <= '1';

        sysstrobe <= '0';
        sysrw <= '1';
        pready <= '1';
      when write_begin =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '1';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '1';
        sysrw <= '0';
        pready <= '0';
      when write_wait =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '1';
        dram_sel <= '0';
        dram_write <= '0';
        tag_write <= '0';

        sysstrobe <= '0';
        sysrw <= '0';
        pready <= '0';
      when write_done =>
        pdata_sel <= '0';
        p_write <= '0';
        sys_write <= '1';
        dram_sel <= '0';
        dram_write <= '1';
        tag_write <= '1';

        sysstrobe <= '0';
        sysrw <= '0';
        pready <= '1';
    end case;
  end process;



end architecture;
