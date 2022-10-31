

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
    if(write) begin
      data[addr] <= data_in;
      $display("Wrote %0d to memory location %0d",  $signed(data_in), addr);
    end
  end

  initial begin : init 
    integer i;
    // uncomment for problem 4
    /* $readmemb("p4.txt", data); */
    /* data[0] = 32'd6; */
  
    // uncomment for problem 5
    /* $readmemb("p5.txt", data); */
    /* data[0] = {{30{1'b1}}, 2'b0}; */

    // uncommend for problem 6
    $readmemb("p6.txt",data);
    data[0] = 32'd4;
    data[1] = 32'd12;

  end


endmodule
