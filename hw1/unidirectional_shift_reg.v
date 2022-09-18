


module unidirectional_shift_reg
#(parameter W = 4)
(
  input clk, load, hold, shift_in,
  input [W-1:0] load_data,
  output shift_out,
  output reg [W-1:0] q
);

  assign shift_out = q[0];

  always @ (posedge clk) begin 
    if(load) begin 
      q <= load_data;
    end else if(hold) begin 
      q <= q; // is this ok?
    end else begin 
      q <= {shift_in, q[W-1:1]};
    end
  end

endmodule

