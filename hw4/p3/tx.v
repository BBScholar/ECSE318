
module TX(
  input pclear_b, SSPCLKOUT,
  input tx_empty,
  input [7:0] tx_data,
  output tx_done,
  output reg SSPFSSOUT, SSPTXD
);
  
  // module state
  reg [1:0] state, next_state;
  reg [4:0] cycle_counter;
  reg [6:0] send_data;
  
  // nets
  wire tx_has_data;

  // assignments
  assign tx_done = cycle_counter == 4'b0;
  /* assign SSPTXD = send_data[7]; */
  assign tx_has_data = !tx_empty;

  localparam STATE_IDLE = 2'd0;
  localparam STATE_FRAME = 2'd1;
  localparam STATE_TX = 2'd2;

  always @ (posedge SSPCLKOUT) begin 
    state <= next_state;
  end

  always @ (posedge SSPCLKOUT) begin 
    casez(state)
      STATE_IDLE : begin 
        cycle_counter <= 4'd7;
        SSPTXD <= 1'b0;
        /* send_data <= tx_data; */
        // some condition
        if(tx_has_data) SSPFSSOUT <= 1'b1;
        else SSPFSSOUT <= 1'b0;
      end
      STATE_FRAME : begin 
        SSPFSSOUT <= 1'b0;
        {SSPTXD, send_data} <= tx_data;
      end
      STATE_TX : begin 
        /* SSPTXD <= send_bit; */

        if(tx_done & tx_has_data) begin 
          {SSPTXD, send_data} <= tx_data;
          cycle_counter <= 4'd7;
        end else begin
          SSPTXD <= send_data[6];
          send_data <= send_data << 1;
          cycle_counter <= cycle_counter - 1;
        end

        // some condition
        if(tx_has_data & cycle_counter == 3'b1) begin 
          SSPFSSOUT <= 1'b1;
        end else begin 
          SSPFSSOUT <= 1'b0;
        end

      end
    endcase
  end

  always @ (state, tx_done, tx_has_data) begin 
    casez(state)
      STATE_IDLE: begin 
        if(tx_has_data) next_state  <= STATE_FRAME;
        else next_state <= STATE_IDLE;
      end
      STATE_FRAME : begin 
        next_state <= STATE_TX;
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

