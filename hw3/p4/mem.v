

module memory #(
  parameter W = 32,
  parameter A = 12
)(
  addr, write, data_in, data_out
);
  
  input addr, data_in, write;
  output data_out;
  
  wire write;
  wire [A-1:0] addr;
  wire [W-1:0] data_in;
  reg [W-1:0] data_out;


  
  reg [W-1:0] data[0:2**A - 1];


endmodule
