library IEEE;
use IEEE.std_logic_1164.all;

entity handshake is 
  port(
    clk, R, A, RESET: in std_ulogic;
    E : out std_ulogic
  );
end entity handshake;

architecture struct of handshake is 
  subtype state_t is std_ulogic_vector(2 downto 0);

  constant IDLE : state_t := "000";
  constant S1 : state_t := "010";
  constant S2 : state_t := "011";
  constant S3 : state_t := "001";
  constant ERR : state_t := "100";

  signal state: state_t := IDLE;
  signal next_state: state_t;
  signal RA : std_ulogic_vector(1 downto 0);
begin 
  RA <= (R, A);

  state_dff : entity work.DFF 
    generic map(W=>state_t'length)
    port map(clk=>clk, d=>next_state, clear=>RESET, q=>state);

end architecture struct;

architecture behav of handshake is 
  type state_t is (idle, S1, S2, S3, err);

  signal state, next_state : state_t;
begin

  next_state_proc : process(state, R, A) 
    variable RA: std_ulogic_vector(1 downto 0);
  begin 
    RA := (R, A);
    case state is 
      when idle =>
        if RA = "00" then 
          next_state <= idle;
        elsif RA = "10" then 
          next_state <= S1;
        else
          next_state <= err;
        end if;
      when S1 => 
        if RA = "10" then 
          next_state <= S1;
        elsif RA = "11" then 
          next_state <= S2;
        else 
          next_state <= err;
        end if;
      when S2 =>
        if RA = "11" then 
          next_state <= S2;
        elsif RA = "01" then 
          next_state <= S3;
        else 
          next_state <= err;
        end if;
      when S3 =>
        if RA = "01" then 
          next_state <= S3;
        elsif RA = "00" then 
          next_state <= idle;
        else 
          next_state <= err;
        end if;
      when err =>
        next_state <= err;
    end case;
  end process;

  proc : process(clk, next_state, RESET) begin 
    if rising_edge(RESET) then 
      state <= idle;
    elsif rising_edge(clk) then
      state <= next_state;
    end if;
  end process;

  output_proc : process(state) begin 
    if state = err then 
      E <= '1';
    else 
      E <= '0';
    end if;
  end process;


end architecture behav;

