

module full_adder( 
  input a, b, c,
  output s, cout
);

  assign s = a ^ b ^ c;
  assign cout = (a&b) | (a&c) | (b&c);

endmodule


