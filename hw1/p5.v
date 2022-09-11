
  module dff(
    input clk, d,
    output reg q
    // output wire qb
  );
    /*
    wire t1, t2, 

    nand nand1(clk, d, t1);
    nand nand2(clk, !d, t2);

    nand nand3(t1, qb, q);
    nand nand4(t2, q, qb);
    */

    assign qb = !q;

    always @ (posedge clk)
      q <= d;

endmodule

module p5_struct(
  input clk, e, w,
  output wire out
);


  
  wire a, b;
  wire t1, t2;

  assign t1 = (a & !b) | (a & w) | e;
  assign t2 = (!a & b) | (b & e) | w;


  dff dffA(
    .clk(clk), .d(t1),
    .q(a)
  );


  dff dffB(
    .clk(clk), .d(t2),
    .q(b)
  );

  assign out = !a & !b;

endmodule


module p5_behav(
  input clk, e, w,
  output wire out
);
  reg A, B;
  
  // DO I NEED TO USE THE ALWAYS * block?
  assign out = !A & !B;

  // this also works, does the same thing
  // always @ (*) begin */
  // out <= !A & !B; */
  // end */

  always @ (posedge clk) begin 
    A <= e | (A & !B) | (A & w);
    B <= w | (!A & B) | (B & e);
  end


endmodule

