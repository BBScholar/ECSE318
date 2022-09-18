

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
