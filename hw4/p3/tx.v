
module TX(
  input pclear_b, SSPCLKOUT,
  input tx_empty, tx_has_one,
  input [7:0] tx_data,
  output tx_done, SSPOE_B,
  output reg SSPFSSOUT, SSPTXD
);

  localparam STATE_IDLE = 2'd0;
  localparam STATE_FRAME = 2'd1;
  localparam STATE_TX = 2'd2;
  
  // module state
  reg [1:0] state, next_state;
  reg [2:0] cycle_counter;
  reg [7:0] send_data;
  
  // nets
  wire tx_has_data;

  // assignments
  assign tx_done = cycle_counter == 4'b0;
  assign tx_has_data = !tx_empty;

  assign SSPOE_B = !(state == STATE_TX);

  always @ (posedge SSPCLKOUT) begin 
    state <= next_state;
  end

  always @ (state, cycle_counter) begin 
    if(state == STATE_TX && cycle_counter == 3'b111) begin 
      SSPFSSOUT <= 1'b1; 
    end else begin 
      SSPFSSOUT <= 1'b0;
    end
  end

  always @ (posedge SSPCLKOUT) begin 
    casez(state) 
      STATE_IDLE: begin 
        send_data <= tx_data;
        cycle_counter <= 3'b111;
        SSPFSSOUT <= 1'b0;
      end 
      STATE_TX : begin 
        SSPTXD <= send_data[7];
        cycle_counter <= cycle_counter - 1;
        if(!tx_done) begin 
          send_data <= send_data << 1;
        end else begin 
          send_data <= tx_data; 
        end
      end
    endcase
  end

  always @ (state, tx_done, tx_has_data, tx_has_one, pclear_b) begin 
    if(!pclear_b) begin 
      next_state <= STATE_IDLE; 
    end else begin
      casez(state)
        STATE_IDLE: begin 
          if(tx_has_data) next_state <= STATE_TX;
          else next_state <= STATE_IDLE;
        end
        STATE_TX : begin 
          if(!tx_done) begin 
            next_state <= STATE_TX;
          end else if(tx_done & tx_has_data) begin // !tx_has_one
            next_state <= STATE_TX;
          end else begin // tx_done & (!tx_has_data | tx_has_one)
            next_state <= STATE_IDLE;
          end
        end
      endcase
    end
  end

endmodule

