

module memory #(
  parameter W = 32,
  parameter A = 12
)(
  clk, addr, write, data_in, data_out
);

  localparam MAX_MEM = 2**A;

  input clk, write;
  input [W-1:0] data_in;
  input [A - 1:0] addr;

  output wire [W-1:0] data_out;
  
  // internal register
  reg [W-1:0] data[0:MAX_MEM - 1];

  assign data_out = data[addr];

  always @ (clk) begin 
    if(write)
      data[addr] <= data_in;
  end

  initial begin : init 
    integer i;
    $readmemb("")
    for(i = 0; i < MAX_MEM; i = i + 1) begin 
      data[i] <= 32'b0;
    end

  end


endmodule
