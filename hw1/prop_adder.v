
module prop_adder
#(parameter WIDTH=8)
( 
  input [WIDTH-1:0] a, b,
  input cin,
  output [WIDTH-1:0] s,
  output cout
);

  wire [WIDTH:0] carry;

  assign carry[0] = cin;
  assign carry[WIDTH] = cout;

  full_adder adders [WIDTH - 1:0] (
    .a(a), .b(b), .c(carry[WIDTH-1:0]),
    .s(s), .cout(carry[WIDTH:1])
  );

endmodule
