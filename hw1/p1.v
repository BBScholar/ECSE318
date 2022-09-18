

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
    
     csa_module #(.W(W)) csa(
        .a(y & {W{x[i]}}), .b(carry[i]), .c({1'b0, sum[i][W-1:1]}),
        .sout(sum[i + 1]), .cout(carry[i + 1])
     );

     assign p[i] = sum[i + 1][0];
   end

 endgenerate

  prop_adder #(.W(W)) cpa(
    .a({1'b0, sum[W][W-1:1]}), .b(carry[W]), .cin(1'b0),
    .s(p[2*W-1:W]), .cout()
  );

endmodule
