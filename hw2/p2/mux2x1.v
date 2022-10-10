

module mux2x1(
  input a, b, sel,
  output z
);

  assign z = a & ~sel | b & sel;

endmodule
