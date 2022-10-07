

module comparator16(
  a, b, op, s
);

  input a, b, op;
  output s;

  wire [15:0] a, b, s;
  wire [2:0] op;
  
  // internal nets
  wire eq, neq;
  wire gt, gte;
  wire lt, lte;

  reg result;

  assign eq = (a == b);
  assign neq = !eq;
  
  // TODO: check this
  assign gt = ($signed(a) > $signed(b)); 
  assign gte = gt | eq;

  assign lt = !gte;
  assign lte = !gt;

  assign s = {15'b0, result};

  always @ (a or b or op) begin 
    casez(op)
      3'b000: result = lte;
      3'b001: result = lt;
      3'b010: result = gte;
      3'b011: result = gt;
      3'b100: result = eq;
      3'b101: result = neq;
      default: result = 1'b0;
    endcase
  end

endmodule

