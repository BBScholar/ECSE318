

module dff(
    input clk, d,
    output reg q,
    output wire qb
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
