
module prop_adder2
(
  a, b, s, cin, cout
);

  input [1:0] a, b;
  input cin;
  output [1:0] s;
  output cout;

  wire [2:0] carry;

  assign carry[0] = cin;
  assign cout = carry[2];

  full_adder add1(
    .a(a[0]), .b(b[0]), .c(carry[0]),
    .s(s[0]), .cout(carry[1])
  );

  full_adder add2(
    .a(a[1]), .b(b[1]), .c(carry[1]),
    .s(s[1]), .cout(carry[2])
  );

endmodule


module prop_adder4
(
  a, b, s, cin, cout
);

  input [3:0] a, b;
  input cin;
  output [3:0] s;
  output cout;
  
  wire carry;

  prop_adder2 add1(
    .a(a[1:0]), .b(b[1:0]), .cin(cin),
    .s(s[1:0]), .cout(carry)
  );

  prop_adder2 add2(
    .a(a[3:2]), .b(b[3:2]), .cin(carry),
    .s(s[3:2]), .cout(cout)
  );

endmodule


module prop_adder8
(
  a, b, s, cin, cout
);

  input [7:0] a, b;
  input cin;
  output [7:0] s;
  output cout;
  
  wire carry;

  prop_adder4 add1(
    .a(a[3:0]), .b(b[3:0]), .cin(cin),
    .s(s[3:0]), .cout(carry)
  );

  prop_adder4 add2(
    .a(a[7:4]), .b(b[7:4]), .cin(carry),
    .s(s[7:4]), .cout(cout)
  );

endmodule


module prop_adder16
(
  a, b, s, cin, cout
);

  input [15:0] a, b;
  input cin;
  output [15:0] s;
  output cout;
  
  wire carry;

  prop_adder8 add1(
    .a(a[7:0]), .b(b[7:0]), .cin(cin),
    .s(s[7:0]), .cout(carry)
  );

  prop_adder8 add2(
    .a(a[15:8]), .b(b[15:8]), .cin(carry),
    .s(s[15:8]), .cout(cout)
  );

endmodule
