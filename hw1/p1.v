

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
#(
  parameter W=4
)
(
  input [W-1:0] x, y,
  output [2*W - 1:0] p
);


  wire [W-1:0] carry[0:W];
  wire [W-1:0] sum[0:W];

  // assign first row of carry and sum need to be 0
  assign carry[0] = {W{1'b0}};
  assign sum[0] = {W{1'b0}};

  genvar i;
  generate
   for(i = 0; i < W; i = i + 1) begin : row_loop 
     csa c [W-1:0] (
       .a(y), .b(x[i]), .cin(carry[i]), .sin({1'b0, sum[i][W-1:1]}),
       .sout(sum[i + 1]), .cout(carry[i + 1])
     );

     assign p[i] = sum[i + 1][0];
   end

 endgenerate

  prop_adder #(.WIDTH(W)) cpa(
    .a({1'b0, sum[W][W-1:1]}), .b(carry[W]), .cin(1'b0),
    .s(p[2*W-1:W])
  );

endmodule
