

// this module generates the complement of the input in twos complement reporesentation
module twos_complement
#(
  parameter W = 8
)
(
  input [W-1:0] in,
  output [W-1:0] out
);

  assign out = (~in) + 1'b1;

endmodule
