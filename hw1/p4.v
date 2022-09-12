

module csa_module
#(parameter W = 8)
(
  input [W-1:0] a, b, c, 
  output wire [W-1:0] cout, sout
);

  
  full_adder adders [W-1:0] (
    .a(a), .b(b), .c(c),
    .s(sout), .cout(cout)
  );

endmodule

module csa8x10(
  input [8 * 10 - 1:0] data,
  output [12:0] out
);

  wire [7:0] s1_cout[0:2], s1_sout[0:2];
  wire [8:0] s2_cout[0:1], s2_sout[0:1];
  wire [9:0] s3_cout[0:1], s3_sout[0:1];
  wire [10:0] s4_cout, s4_sout;
  wire [11:0] s5_cout, s5_sout;

  // stage 1 
  csa_module #(.W(8)) s1m1( 
    .a(data[0 +: 8]), .b(data[8 +: 8]), .c(data[16 +: 8]),
    .cout(s1_cout[0]), .sout(s1_sout[0])
  );

  csa_module #(.W(8)) s1m2(
    .a(data[24 +: 8]), .b(data[32 +: 8]), .c(data[40 +: 8]),
    .cout(s1_cout[1]), .sout(s1_sout[1])
  );

  csa_module #(.W(8)) s1m3(
    .a(data[48 +: 8]), .b(data[56 +: 8]), .c(data[64 +: 8]),
    .cout(s1_cout[2]), .sout(s1_sout[2])
  );


  // stage 2
  csa_module #(.W(9)) s2m1 (
    .a({s1_cout[0], 1'b0}), .b({1'b0, s1_sout[0]}), .c({s1_cout[1], 1'b0}),
    .cout(s2_cout[0]), .sout(s2_sout[0])
  );

  csa_module #(.W(9)) s2m2 (
    .a({1'b0, s1_sout[1]}), .b({s1_cout[2], 1'b0}), .c({1'b0, s1_sout[2]}),
    .cout(s2_cout[1]), .sout(s2_sout[1])
  );


  // stage 3
  csa_module #(.W(10)) s3m1(
    .a({s2_cout[0], 1'b0}), .b({1'b0, s2_sout[0]}), .c({s2_cout[1], 1'b0}), 
    .cout(s3_cout[0]), .sout(s3_sout[0])
  );

  csa_module #(.W(10)) s3m2 (
    .a({1'b0, s2_sout[1]}), .b({2'b0, data[72 +: 8]}), .c(10'b0),
    .cout(s3_cout[1]), .sout(s3_sout[1])
  );

  // stage 4
  csa_module #(.W(11)) s4m1 (
    .a({s3_cout[0], 1'b0}), .b({1'b0, s3_sout[0]}), .c({s3_cout[1], 1'b0}),
    .cout(s4_cout), .sout(s4_sout)
  );

  // stage 5
  csa_module #(.W(12)) s5m1 (
    .a({s4_cout, 1'b0}), .b({1'b0, s4_sout}), .c({2'b0, s3_sout[1]}),
    .cout(s5_cout), .sout(s5_sout)
  );

  // final adder 
  assign out = {s5_cout, 1'b0} + {1'b0, s5_sout};

endmodule


