

module conditional_complement
#(
  parameter W=8
)
( 
  input [W-1:0] in,
  input negate,
  output [W-1:0] out
);
  
  wire [W-1:0] negate_ext;
  wire [W-1:0] complement;

  assign negate_ext = {W{negate}};

  twos_complement #(.W(W)) comp(
    .in(in), .out(complement)
  );

  assign out = (in & ~negate_ext) | (complement & negate_ext);

endmodule

module signed_mult
#(
  parameter W=4
)
(
  input [W-1:0] a, b,
  output [2*W-1:0] p
);

  localparam DW=2*W;
  
  wire negate;
  wire [W-1:0] a_comp, b_comp;
  wire [DW-1:0] a_ext;


  conditional_complement #(.W(W)) cc [1:0] (
    .in({a, b}), .negate(b[W-1]), .out({a_comp, b_comp})
  );

  sign_extend #(.IW(W), .OW(DW)) sext (
    .in(a_comp), .out(a_ext)
  );

  wire [DW-1:0] carry[0:W], sum[0:W];

  assign carry[0] = {DW{1'b0}};
  assign sum[0] = {DW{1'b0}};

  genvar i;
  generate
    
    for(i = 0; i < W; i = i + 1) begin : row_loop
      localparam ROW_WIDTH = 2*W - i;

      wire [ROW_WIDTH-1:0] sin;

      if(i == 0) begin 
        assign sin = {DW{1'b0}};
      end else begin 
        assign sin = sum[i][ROW_WIDTH:1];
      end

      csa c [ROW_WIDTH-1:0] (
        .a(a_ext[ROW_WIDTH-1:0]), .b(b_comp[i]), .cin(carry[i][ROW_WIDTH-1:0]), .sin(sin),
        .cout(carry[i + 1][ROW_WIDTH-1:0]), .sout(sum[i + 1][ROW_WIDTH-1:0])
      );

      assign p[i] = sum[i + 1][0];
    end
  
    prop_adder #(.WIDTH(W)) cpa(
      .a(sum[W][W:1]), .b(carry[W][W-1:0]), .cin(1'b0),
      .s(p[DW-1: W])
    );

  endgenerate


endmodule

