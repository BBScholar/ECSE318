
module RX(
  input pclear_b,
  input SSPCLKIN, SSPFSSIN, SSPRXD,
  output [7:0] rx_data,
  output reg rx_done
);

  localparam STATE_IDLE = 2'd0;
  localparam STATE_FRAME = 2'd1;
  localparam STATE_RX = 2'd2;
  
  // module state
  reg [1:0] state, next_state;
  reg [2:0] cycle_counter;
  reg [7:0] rx_data_int;

  // nets 
  wire cycle_counter_zero;

  // assignments
  assign  cycle_counter_zero = cycle_counter == 0;
  assign rx_data = rx_data_int;

  always @ (posedge SSPCLKIN) begin 
    if(!pclear_b) state <= STATE_IDLE;
    else state <= next_state;
  end

  always @ (state, SSPFSSIN, cycle_counter_zero) begin 
    case(state)
      STATE_IDLE: begin 
        if(SSPFSSIN) next_state <= STATE_RX;
        else next_state <= STATE_IDLE;
      end
      STATE_RX : begin 
        if(!cycle_counter_zero) begin 
          next_state <= STATE_RX;
        end else if(SSPFSSIN & cycle_counter_zero) begin 
          next_state <= STATE_RX;
        end else if(!SSPFSSIN & cycle_counter_zero) begin 
          next_state <= STATE_IDLE;
        end
      end 
      default: next_state <= STATE_IDLE;
    endcase
  end

  always @ (posedge SSPCLKIN) begin 
    case(state) 
      STATE_IDLE: begin 
        cycle_counter <= 3'b111;
        rx_data_int <= 8'b0;
        rx_done <= 1'b0;
      end
      STATE_RX : begin 
        cycle_counter <= cycle_counter - 1;
        rx_data_int <= {rx_data_int[6:0], SSPRXD};

        if(cycle_counter_zero) rx_done <= 1'b1;
        else rx_done <= 1'b0;
      end
    endcase
  end

endmodule
