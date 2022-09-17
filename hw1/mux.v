

module mux(
  input a, b, sel,
  output o
);

  assign o = a & ~sel | b & sel;

endmodule
