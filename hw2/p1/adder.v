
// questions:
// should increment and decrement be signed?

module adder16(
  A, B, CODE, cin, coe,
  C, cout, vout
);

  input A, B, CODE, cin, coe;
  output C, cout, vout;

  wire [15:0] A, B, C;
  wire [2:0] CODE;
  wire cin, coe, cout, vout;
  
  // TODO: check this
  // assign cout = vout & !coe;

  // internal nets
  wire [15:0] one;
  wire [15:0] b_source, b_selected;
  wire addition, subtraction;
  wire signed_op;
  wire inc, dec, inc_dec;
  wire cout_int, cin_int;

  assign cout = cout_int & !coe;
  assign one = 16'b01;
  
  // decode code
  assign inc = (CODE == 3'b100);
  assign dec = (CODE == 3'b101);
  assign inc_dec = inc | dec;

  assign addition = (CODE[2:1] == 2'b00) | inc;
  assign subtraction = !addition;

  assign signed_op = !CODE[0] | CODE[2];


  // signed overflow detection
  // TOOO: possbile to base off of xored b?
  wire a_sign, b_sign, c_sign;

  assign a_sign = A[15];
  /* assign b_sign = B[15]; */
  assign b_sign = b_source[15];
  assign c_sign = C[15];

  // overflow occurs when:
  /* assign a_b_sign_compare = a_sign ^ b_sign; */
  /* assign vout = signed_op & (a_sign ^ c_sign) & ((addition & a_b_sign_compare) | (subtraction & !a_b_sign_compare)); */
  assign vout = signed_op & !(a_sign ^ b_sign) & (a_sign ^ c_sign);


  // B source mux
  assign b_selected = inc_dec ? one : B;
  assign b_source = b_selected ^ {16{subtraction}};

  // calculate carry in
  /* assign cin_int = cin ^ subtraction; */
  assign cin_int = cin | subtraction;

  conditional_sum_adder16_with_cin adder (
    .a(A), .b(b_source), .cin(cin_int),
    .cout(cout_int), .s(C)
  );

  


endmodule
