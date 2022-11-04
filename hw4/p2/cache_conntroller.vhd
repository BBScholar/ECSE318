library IEEE;
use IEEE.std_logic_1164.all;

entity cache_controller is 
  port(
    clk : in std_ulogic;
    pstrobe, prw : in std_ulogic;
    pready, systrobe, sysrw: out std_ulogic;
    sysstrobe : out std_ulogic
  );
end entity cache_controller;


architecture behav of cache_controller is
  constant WAIT_CYCLES : integer := 4;

  type state_t is (idle, cache_read, mem_read, write);
  
  signal current_state : state_t := idle;
  signal next_state : state_t;
begin 

  fsm : process(clk, next_state) begin 
    if rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;

  fsm_next : process(clk, current_state) begin 
    if current_state = idle then 
      
    end if;
  end process;

  fsm_logic : process(clk, next_state) begin 
    

    end process;


end architecture;
