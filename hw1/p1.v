

module csa( 
  input a, b, sin, cin,
output wire cout, sout
);
  wire t;
  
  assign t = a&b;
  /* assign {cout, sout} = t + cin + sin; */

  full_adder add(.a(t), .b(sin), .c(cin), .cout(cout), .s(sout));

endmodule

module unsigned_parallel_multiplier
(
  input [3:0] x, y,
  output [7:0] p,
  output cout
);


  wire [3:0] carry[0:4];
  wire [3:0] sum[0:4];

  // assign first row of carry and sum need to be 0
  assign carry[0] = 4'b0;
  assign sum[0] = 4'b0;

  genvar i, j;
  generate
   for(i = 0; i < 4; i = i + 1) begin : csa_loop
     csa c [3:0] (
       .a(y), .b(x[i]), .cin(carry[i]), .sin({1'b0, sum[i][3:1]}),
       .sout(sum[i + 1]), .cout(carry[i + 1])
     );

     assign p[i] = sum[i + 1][0];
   end

 endgenerate

  prop_adder #(.WIDTH(4)) cpa(
    .a({1'b0, sum[4][3:1]}), .b(carry[4]), .cin(1'b0),
    .s(p[7:4]), .cout(cout)
  );

endmodule
