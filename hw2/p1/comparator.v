

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

  wire result;
  wire [7:0] values;

  assign eq = (a == b);
  assign neq = !eq;
  
  assign gt = ($signed(a) > $signed(b)); // I think this ensures signed comparison
  assign gte = gt | eq;

  assign lt = !gte; // !gt & !eq
  assign lte = !gt; // !(a > b) = a <= b

  assign s = {15'b0, result};

  assign result = values[op];
  assign values = {2'b00, neq, eq, gt, gte, lt, lte};

  /* always @ (a or b or op or lte or lt or gte or gt or eq or neq) begin  */
  /*   casez(op) */
  /*     3'b000: result = lte; */
  /*     3'b001: result = lt; */
  /*     3'b010: result = gte; */
  /*     3'b011: result = gt; */
  /*     3'b100: result = eq; */
  /*     3'b101: result = neq; */
  /*     default: result = 1'b0; */
  /*   endcase */
  /* end */

endmodule

