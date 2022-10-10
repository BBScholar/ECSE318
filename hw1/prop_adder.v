
module prop_adder
(
  a, b, s, cin, cout
);
    parameter W=8;

  input [W-1:0] a, b;
  input cin;
  output [W-1:0] s;
  output cout;

  wire [W:0] carry;

  assign carry[0] = cin;
  assign cout = carry[W];

  full_adder adders [ W - 1:0] (
    .a(a), .b(b), .c(carry[W-1:0]),
    .s(s), .cout(carry[W:1])
  );

endmodule
