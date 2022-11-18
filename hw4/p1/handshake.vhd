library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity handshake is 
  port( 
    clk, R, A, RESET : in std_ulogic;
    E : out std_ulogic
  );
end entity handshake;


architecture behav of handshake is 
  type state_t is (Idle, S1, S2, S3, Err);

  signal current_state : state_t := idle;
  signal next_state : state_t;
begin 
  
  -- on negative edge of reset, set state back to idle
  state_update_proc: process(RESET, clk) begin 
    if falling_edge(RESET) then 
      current_state <= idle;
    elsif rising_edge(clk) then 
      current_state <= next_state;
    end if;
  end process;

  next_state_proc : process(R, A, current_state) 
    variable RA : std_ulogic_vector(1 downto 0);
  begin 
    RA := (R, A);
    case current_state is 
      when idle =>
        if RA = "00" then 
          next_state <= Idle;
        elsif RA = "10" then 
          next_state <= S1;
        else 
          next_state <= Err;
        end if;
      when S1 =>
        if RA = "10" then 
          next_state <= S1;
        elsif RA = "11" then 
          next_state <= S2;
        else 
          next_state <= Err;
        end if;
      when S2 =>
        if RA = "11" then 
          next_state <= S2;
        elsif RA = "01" then 
          next_state <= S3;
        else 
          next_state <= Err;
        end if;
      when S3 =>
        if RA = "01" then 
          next_state <= S3;
        elsif RA = "00" then 
          next_state <= Idle;
        else 
          next_state <= Err;
        end if;
      when Err => next_state <= Err;
    end case;
  end process;

  output_proc : process(current_state) begin 
    if current_state = Err then 
      E <= '1';
    else 
      E <= '0';
    end if;
  end process;

end architecture behav;



architecture struct of handshake is 
  subtype state_t is std_ulogic_vector(2 downto 0);

  signal state, next_state : state_t;
  
  signal s0, s1, s2 : std_ulogic;
begin 

  s0 <= state(0);
  s1 <= state(1);
  s2 <= state(2);

  E <= s2;

  next_state(0) <= not s2 and ((not s1 and not A and R) or (s0 and A and R)); 
  next_state(1) <= not s2 and ((s0 and A and R) or (s1 and A and not R));
  next_state(2) <= s2 or (not s1 and not s0 and A) or (not s1 and s0 and not R) or (s1 and s0 and not A) or (s1 and not s0 and R);

  dff : entity work.dff 
    generic map(W => 3)
    port map(clk=>clk, clear=>RESET, d=>next_state, q=>state);
  
end architecture struct;
