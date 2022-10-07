
module cond_sum #(parameter W = 8) (
  input [W-1:0] a, b,
  output c0, c1,
  output [W-1:0] s0, s1
);
  localparam HALF = W / 2;

  generate 
    if(W == 1) begin : cond_sum_if
      full_adder adder0(
        .a(a), .b(b), .c(1'b0),
        .s(s0), .cout(c0)
      );

      full_adder adder1(
        .a(a), .b(b), .c(1'b1),
        .s(s1), .cout(c1)
      );
    end else begin 

      wire b0c0, b0c1;
      wire b1c0, b1c1;
    
      wire [HALF - 1:0] b1s0, b1s1;

      cond_sum #(.W(HALF)) csa_l(
        .a(a[HALF-1:0]), .b(b[HALF-1:0]),
        .s0(s0[HALF-1:0]), .c0(b0c0), .s1(s1[HALF-1:0]), .c1(b0c1)
      );

      cond_sum #(.W(HALF)) csa_h (
        .a(a[W-1:HALF]), .b(b[W-1:HALF]),
        .s0(b1s0), .c0(b1c0), .s1(b1s1), .c1(b1c1)
      );

      assign {c1, s1[W-1:HALF]} = b0c1 ? {b1c1, b1s1} : {b1c0, b1s0};
      assign {c0, s0[W-1:HALF]} = b0c0 ? {b1c1, b1s1} : {b1c0, b1s0};

    end
  endgenerate


endmodule

module cond_sum_with_cin #(
  parameter W=16
) (
  input [W-1:0] a, b,
  input cin,
  output [W-1:0] s,
  output cout
);
  localparam HALF = W / 2;

  generate  
    if(W == 1) begin : cond_sum_cin_if 

      full_adder adder(
        .a(a), .b(b), .c(cin),
        .s(s), .cout(cout)
      );
      
    end else begin

      wire b0c;

      wire b1c0, b1c1;
      wire [HALF-1:0] b1s0, b1s1;
      
      cond_sum_with_cin #(.W(HALF)) csa_l (
        .a(a[HALF-1:0]), .b(b[HALF-1:0]), .cin(cin),
        .cout(b0c), .s(s[HALF-1:0])
      );

      cond_sum #(.W(HALF)) csa_h (
        .a(a[W - 1: HALF]), .b(b[W - 1:HALF]),
        .c0(b1c0), .c1(b1c1), .s0(b1s0), .s1(b1s1)
      );

      assign {cout, s[W-1:HALF]} = b0c ? {b1c1, b1s1} : {b1c0, b1s0};

    end
  endgenerate

endmodule
