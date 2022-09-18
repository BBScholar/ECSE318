

module register
#(parameter W = 4)
(
  input clk, load,
  input [W-1:0] d,
  output reg [W-1:0] q
);

  always @ (posedge clk) begin 
    if(load) begin 
      q <= d;
    end else begin 
      q <= q;
    end
  end

endmodule
