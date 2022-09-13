

module sign_extend
#(
  parameter IW=8,
  parameter OW=16
)
(
  input [IW-1:0] in,
  output [OW-1:0] out
);
  localparam DIFF = OW - IW;

  wire sign;
  assign sign = in[IW-1];

  assign out = {{DIFF{sign}}, in};


endmodule
