
module TX(
  input pclear_b, SSPCLKOUT,
  input tx_empty,
  input [7:0] tx_data,
  output reg SSPTXD, SSPFSSOUT,
  output tx_done
);
  
  // module state
  reg [1:0] state, next_state;
  reg [4:0] cycle_counter;
  reg [7:0] send_data;
  
  // nets
  wire send_bit;
  wire load_next;
  wire tx_has_data;

  // assignments
  assign load_next = (cycle_counter == 4'd1) & tx_has_data;
  assign tx_done = cycle_counter == 4'b0;
  assign send_bit = send_data[7];
  assign tx_has_data = !tx_empty;

  localparam STATE_IDLE = 2'd0;
  localparam STATE_BEGIN = 2'd1;
  localparam STATE_TX = 2'd2;

  always @ (posedge SSPCLKOUT) begin 
    state <= next_state;
  end

  always @ (posedge SSPCLKOUT) begin 
    casez(state)
      STATE_IDLE : begin 
        cycle_counter <= 4'd7;
        SSPTXD <= 1'b0;
        send_data <= tx_data;
        // some condition
        if(tx_has_data) SSPFSSOUT <= 1'b1;
        else SSPFSSOUT <= 1'b0;
      end
      STATE_TX : begin 
        cycle_counter <= cycle_counter - 1;
        SSPTXD <= send_bit;
        send_data <= send_data << 1;
        // some condition
        /* if(tx_has_data & tx_done) SSPFSSOUT <= 1'b1; */
        /* else SSPFSSOUT <= 1'b0; */
      end
    endcase
  end

  always @ (state, tx_done, tx_has_data) begin 
    casez(state)
      STATE_IDLE: begin 
        if(tx_has_data) next_state  <= STATE_TX;
        else next_state <= STATE_IDLE;
      end
      STATE_TX : begin 
        if(!tx_done) next_state <= STATE_TX; 
        else if(tx_done & tx_has_data) next_state <= STATE_TX;
        else next_state <= STATE_IDLE;
      end
      default : next_state <= STATE_IDLE;
    endcase
  end

endmodule

