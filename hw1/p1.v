

module csa( 
  input a, b, sin, cin,
  output wire cout, sout
);
  wire t;
  
  assign t = a&b;
  /* assign {cout, sout} = t + cin + sin; */

  cpa c(.a(t), .b(sin), .cin(cin), .cout(cout), .sout(sout));

endmodule

module cpa(
  input a, b, cin,
  output cout, sout
);

  assign sout = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) & (b & cin);

  /* assign {cout, sout} = a + b + cin; */

endmodule


module unsigned_parallel_multiplier(
  input [3:0] x, y,
  output wire [7:0] p
);


  wire [3:0] carry[0:4];
  wire [3:0] sum[0:4];

  // assign first row of carry and sum to  be 0
  assign carry[0] = 4'b0;
  assign sum[0] = 4'b0;

  genvar i, j;
  generate
    for(i = 0; i < 4; i = i + 1) begin : x_loop
      for(j = 0; j < 4; j = j + 1) begin : y_loop

        wire sin;

        if(i == 0) begin 
          assign sin = 1'b0;
        end else begin 
          assign sin = sum[j][i - 1];
        end

        csa csa(
          .a(x[3 - j]), .b(y[3 - i]), .cin(carry[j][i]), .sin(sin),
          .cout(carry[j + 1][i]), .sout(sum[j + 1][i])
        );

      end
   end

   for(i = 0; i < 4; i = i + 1) begin : p_loop
      assign p[i] = sum[i + 1][0];
   end
  
 endgenerate


  wire [4:0] cpa_cin;

  assign cpa_cin[0] = 1'b0;

  cpa cpas[3:0] (
    .a({1'b0, sum[4][2:0]}), .b(carry[4]), .cin(cpa_cin[3:0]),
    .cout(cpa_cin[4:1]), .sout(p[7:4])
  );

endmodule

/*
module p1v2(
  input [3:0] x, y,
  output reg [7:0] p
);

  wire [3:0] carry[0:4];
  wire [3:0] sout[0:4];

// row1
csa [3:0] row1(
  .a(y), .b(x), .cin(4'b0), .sin(4'b0),
  .cout(carry[3:0][0]), .sout(sout[3:0][0])
);

csa [3:0] row2(
  .a(y), .b(x), .cin(carry[3:0][0]), .sin({1'b0, }),
  .cout(carry)
);

endmodule
*/
