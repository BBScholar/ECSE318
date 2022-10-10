

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
  always @ (a or b or op) begin 
    casez(op) 
      3'b000: s = a & b;
      3'b001: s = a | b;
      3'b010: s = a ^ b;
      3'b100: s = ~a;
      default: s = 16'b0;
    endcase
  end

endmodule
