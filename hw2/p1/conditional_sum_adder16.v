`define W 16

module full_adder( 
  a, b, c, s, cout
);
  input a, b, c;
  output s, cout;

  wire a, b, c, s, cout;

  assign s = a ^ b ^ c;
  assign cout = (a&b) | (a&c) | (b&c);

endmodule

module conditional_sum_adder1(
  a, b, s0, s1, c0, c1
);

  input a, b;
  output s0, s1, c0, c1;

  wire a, b, s0, s1, c0, c1;

  full_adder adder0(
    .a(a), .b(b), .c(1'b0),
    .s(s0), .cout(c0)
  );

  full_adder adder1(
    .a(a), .b(b), .c(1'b1),
    .s(s1), .cout(c1)
  );

endmodule

module conditional_sum_adder2(
  a, b, s0, s1, c0, c1
);

  input [1:0] a, b;
  output s0, s1;
  output c0, c1;
  
  wire [1:0] s0, s1;
  wire c0, c1;
  
  wire b0c0, b0c1;
  wire b1c0, b1c1;
  wire b1s0, b1s1;

  conditional_sum_adder1 csa_l(
    .a(a[0]), .b(b[0]),
    .s0(s0[0]), .c0(b0c0), .s1(s1[0]), .c1(b0c1)
  );

  conditional_sum_adder1 csa_h(
    .a(a[1]), .b(b[1]),
    .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
  );

  assign {c0, s0[1]} = b0c0 ? {b1c1, b1s1} : {b1c0, b1s0};
  assign {c1, s1[1]} = b0c1 ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule


module conditional_sum_adder2_with_cin(
  a, b, cin, cout, s
);

  input a, b, cin;
  output cout, s;

  wire [1:0] a, b;
  wire cin;
  wire cout;
  wire [1:0] s;

  wire b0c;
  wire b1s0, b1c0, b1s1, b1c1;

  full_adder zero_adder(
    .a(a[0]), .b(b[0]), .c(cin),
    .cout(b0c), .s(s[0])
  );

  conditional_sum_adder1 csa_h(
    .a(a[1]), .b(b[1]),
    .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
  );

  assign {cout, s[1]} = b0c ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule

module conditional_sum_adder4(
  a, b, c0, c1, s0, s1
);

  input a, b;
  output c0, c1, s0, s1;

  wire [3:0] a, b;
  wire c0, c1;
  wire [3:0] s0, s1;

  wire b0c0, b0c1;
  wire b1c0, b1c1;

  wire [1:0] b1s0, b1s1;

  conditional_sum_adder2 csa_l(
    .a(a[1:0]), .b(b[1:0]),
    .c0(b0c0), .s0(s0[1:0]), .c1(b0c1), .s1(s1[1:0])
  );

  conditional_sum_adder2 csa_h(
    .a(a[3:2]), .b(b[3:2]),
    .c0(b1c0), .s0(b1s0), .c1(b1c1), .s1(b1s1)
  );

  assign {c0, s0[3:2]} = b0c0 ? {b1c1, b1s1} : {b1c0, b1s0};
  assign {c1, s1[3:2]} = b0c1 ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule

module conditional_sum_adder4_with_cin(
  a, b, cin, cout, s
);

  input a, b, cin;
  output cout, s;

  wire [3:0] a, b;
  wire cin;
  wire cout;
  wire [3:0] s;

  wire b0c;
  wire b1c0, b1c1;
  wire [1:0] b1s0, b1s1;
  
  conditional_sum_adder2_with_cin csa_l(
    .a(a[1:0]), .b(b[1:0]), .cin(cin),
    .cout(b0c), .s(s[1:0])
  );
  
  conditional_sum_adder2 csa_h(
    .a(a[3:2]), .b(b[3:2]),
    .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
  );


  assign {cout, s[3:2]} = b0c ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule


module conditional_sum_adder8(
   a, b, c0, c1, s0, s1
);

  input a, b;
  output c0, c1, s0, s1;

  wire [7:0] a, b;
  wire c0, c1;
  wire [7:0] s0, s1;

  wire b0c0, b0c1;
  wire b1c0, b1c1;

  wire [3:0] b1s1, b1s0;

  conditional_sum_adder4 csa_l(
    .a(a[3:0]), .b(b[3:0]),
    .c0(b0c0), .s0(s0[3:0]), .c1(b0c1), .s1(s1[3:0])
  );

  conditional_sum_adder4 csa_h(
    .a(a[7:4]), .b(b[7:4]),
    .c0(b1c0), .s0(b1s0), .c1(b1c1), .s1(b1s1)
  );

  assign {c0, s0[7:4]} = b0c0 ? {b1c1, b1s1} : {b1c0, b1s0};
  assign {c1, s1[7:4]} = b0c1 ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule 

module conditional_sum_adder8_with_cin(
  a, b, cin, cout, s
);

  input a, b, cin;
  output cout, s;

  wire [7:0] a, b;
  wire cin;
  wire cout;
  wire [7:0] s;

  wire b0c;
  wire b1c0, b1c1;
  wire [3:0] b1s0, b1s1;
  
  conditional_sum_adder4_with_cin csa_l(
    .a(a[3:0]), .b(b[3:0]), .cin(cin),
    .cout(b0c), .s(s[3:0])
  );
  
  conditional_sum_adder4 csa_h(
    .a(a[7:4]), .b(b[7:4]),
    .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
  );

  assign {cout, s[7:4]} = b0c ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule

module conditional_sum_adder16_with_cin(
  a, b, cin, cout, s
);

  input a, b, cin;
  output cout, s;

  wire [15:0] a, b;
  wire cin;
  wire cout;
  wire [15:0] s;

  wire b0c;
  wire b1c0, b1c1;
  wire [7:0] b1s0, b1s1;
  
  conditional_sum_adder8_with_cin csa_l(
    .a(a[7:0]), .b(b[7:0]), .cin(cin),
    .cout(b0c), .s(s[7:0])
  );
  
  conditional_sum_adder8 csa_h(
    .a(a[15:8]), .b(b[15:8]),
    .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
  );

  assign {cout, s[15:8]} = b0c ? {b1c1, b1s1} : {b1c0, b1s0};

endmodule

