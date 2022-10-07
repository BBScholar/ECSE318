

module logic16(
  a, b, op,
  s
);

  input a, b, op;
  output s;

  wire [15:0] a, b;
  reg [15:0] s;
  wire [2:0] op;
  
  // internal nets 
  wire [15:0] inv_a, a_and_b, a_or_b, a_xor_b;

  assign inv_a = ~a;
  assign a_and_b = a & b;
  assign a_or_b = a | b;
  assign a_xor_b = a ^ b;

  always @ (a or b or op) begin 
    casez(op) 
      3'b000: s = a_and_b;
      3'bzz1: s = a_or_b;
      3'bz10: s = a_xor_b;
      3'b100: s = inv_a;
    endcase
  end

endmodule
