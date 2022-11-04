
module RX(
  input pclear_b,
  input SSPCLKIN, SSPFSSIN, SSPRXD,
  output [7:0] rx_data,
  output rx_done
);

  localparam STATE_IDLE = 2'd0;
  localparam STATE_FRAME = 2'd1;
  localparam STATE_RX = 2'd2;
  
  // module state
  reg [1:0] state, next_state;
  reg [2:0] cycle_counter;
  reg [7:0] rx_data_int;

  // assignments
  assign rx_done = cycle_counter == 0;
  assign rx_data = rx_data_int;

  always @ (posedge SSPCLKIN) begin 
    state <= next_state;
  end

  always @ (state, SSPFSSIN, rx_done) begin 
    if(state == STATE_IDLE) begin 
      if(SSPFSSIN) begin 
        next_state <= STATE_RX;
      end else begin 
        next_state <= STATE_IDLE;
      end
    end else if(state == STATE_RX) begin 
      if(!rx_done) next_state <= STATE_RX;
      else if(rx_done & !SSPFSSIN) next_state <= STATE_IDLE;
      else next_state <= STATE_RX;
    end else next_state <= STATE_IDLE;
  end

  always @ (posedge SSPCLKIN, negedge pclear_b) begin 
    if(!pclear_b) begin 
      rx_data_int <= 'b0;
    end else begin 
      casez(state)
        STATE_IDLE: begin 
          cycle_counter <= 3'b111;
          rx_data_int <= rx_data_int;
          /* rx_data_int <= 'b0; */
          /* rx_data_int <= rx_data_int; */
        end 
        STATE_RX: begin 
          cycle_counter <= cycle_counter - 1; 
          rx_data_int <= {rx_data_int[6:0], SSPRXD};
        end
      endcase
    end
  end

endmodule
