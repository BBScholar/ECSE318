

module test_prop(
  a, b, cin, s, cout
);
  input [15:0] a, b;
  input cin;
  output [15:0] s;
  output cout;


  prop_adder #(16) adder(
    .a(a), .b(b), .cin(cin),
    .s(s), .cout(cout)
  );



endmodule
