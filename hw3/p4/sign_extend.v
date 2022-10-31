
module sign_extend #(
  parameter IW = 12,
  parameter OW = 32
)(
  input [IW - 1:0] data_in,
  output wire [OW - 1:0] data_out
);
  localparam DIFF = OW - IW;
  
  assign data_out = {{DIFF{data_in[IW - 1]}}, data_in};

endmodule
