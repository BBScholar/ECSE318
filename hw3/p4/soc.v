`default_nettype none

module soc;

  reg clk;
  initial clk = 1'b0;

  always #10 clk = ~clk;


  // interconnects
  wire mem_write;
  wire [11:0] mem_addr;
  wire [31:0] cpu_to_mem_data, mem_to_cpu_data;

  cpu cpu(
    .clk(clk), .mem_addr(mem_addr), .mem_write(mem_write),
    .to_mem(cpu_to_mem_data), .from_mem(mem_to_cpu_data)
  );

  memory mem(
    .clk(clk), .addr(mem_addr), .write(mem_write), 
    .data_in(cpu_to_mem_data), .data_out(mem_to_cpu_data)
  );


endmodule
