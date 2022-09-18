
module conditional_complement
#(
  parameter W=8
)
( 
  input [W-1:0] in,
  input negate,
  output [W-1:0] out
);
  
  wire [W-1:0] negate_ext;
  wire [W-1:0] complement;

  assign negate_ext = {W{negate}};

  twos_complement #(.W(W)) comp(
    .in(in), .out(complement)
  );

  assign out = (in & ~negate_ext) | (complement & negate_ext);

endmodule
