
module full_adder( 
  a, b, c, s, cout
);
  input a, b, c;
  output s, cout;

  wire a, b, c, s, cout;

  assign s = a ^ b ^ c;
  assign cout = (a&b) | (a&c) | (b&c);

endmodule
