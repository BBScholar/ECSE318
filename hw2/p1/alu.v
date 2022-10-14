
module alu( 
  A, B, alu_code, C, overflow
);

  input A, B, alu_code;
  output C, overflow;

  wire [15:0] A, B;
  wire [4:0] alu_code;
  reg [15:0] C;
  wire overflow;

  // internal nets 
  wire [1:0] mod_sel;
  wire [2:0] mod_op;
  wire [15:0] shift_out, add_out, logic_out, compare_out;

  wire add_vout, add_cout;
  
  assign {mod_sel, mod_op} = alu_code;
  assign overflow = (mod_sel == 2'b00) & add_vout;

  adder16 adder(
    .A(A), .B(B), .CODE(mod_op), .cin(1'b0), .coe(1'b1),
    .C(add_out), .vout(add_vout), .cout(add_cout)
  );


  shift16 shift(
    .a(A), .b(B), .op(mod_op),
    .s(shift_out)
  );

  logic16 logic(
    .a(A), .b(B), .op(mod_op),
    .s(logic_out)
  );

  comparator16 compare(
    .a(A), .b(B), .op(mod_op),
    .s(compare_out)
  );


  always @ (mod_sel or shift_out or add_out or logic_out or compare_out) begin 
    casez(mod_sel)
      2'b00: C <= add_out;
      2'b01: C <= logic_out;
      2'b10: C <= shift_out;
      2'b11: C <= compare_out;
    endcase
  end

endmodule
