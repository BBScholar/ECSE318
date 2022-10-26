

module alu #(parameter W = 32)(
  a, b, shamt, s, op, cout
);

  input [W-1:0] a, b;
  input [1:0] op;

  output reg [W-1:0] s;
  output reg cout;
  
  always @ (*) begin 
    casez(op)
      2'b00: begin  // xor
        s <= a ^ b;
        cout <= 1'b0;
      end 
      2'b01 : begin  // add
        {cout, s} <= a + b;
      end 
      2'b10 : begin  // complement
        cout <= 1'b0;
        s <= ~b;
      end
      default: {cout, s} <={(W + 1){1'b0}};
    endcase
  end
  

endmodule
