

module signed_multiplier
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
  wire [DW-1:0] carry[0:W], sum[0:W];
  
  assign negate = b[W - 1];
  assign carry[0] = {DW{1'b0}};
  assign sum[0] = {DW{1'b0}};

  conditional_complement #(.W(W)) cc [1:0] (
    .in({a, b}), .negate(negate), .out({a_comp, b_comp})
  );

  sign_extend #(.IW(W), .OW(DW)) sign_ext (
    .in(a_comp), .out(a_ext)
  );

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

      csa_module #(.W(ROW_WIDTH)) csa(
        .a(a_ext[ROW_WIDTH-1:0] & {(ROW_WIDTH){b_comp[i]}}), .b(carry[i][ROW_WIDTH-1:0]), .c(sin),
        .cout(carry[i + 1][ROW_WIDTH-1:0]), .sout(sum[i + 1][ROW_WIDTH-1:0])
      );

      assign p[i] = sum[i + 1][0];
    end
  
    prop_adder #(.W(W)) cpa(
      .a(sum[W][W:1]), .b(carry[W][W-1:0]), .cin(1'b0),
      .s(p[DW-1: W]), .cout()
    );

  endgenerate


endmodule

