

module alu #(parameter W = 32)(
  a, b, s, op, cout;
);
  
  input a, b, op;
  output s, cout;

  wire [W-1:0] a, b;

  always @ (*) begin 
    casez(op)
      4'b000    endcase
  end
  

endmodule
