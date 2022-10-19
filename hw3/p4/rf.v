

module register_file(
  clk, write,
  src_sel, dest_sel, 
  dest_in,
  src_out, dest_out,
);
  localparam W = 32;
  localparam NUM_REG = 16;
  localparam SEL_SIZE = $clog2(NUM_REG);


  input clk, write;
  input [SEL_SIZE-1:0] src_sel, dest_sel;
  input [W-1:0] dest_in;
  output wire [W-1:0] dest_out, src_out;

  reg [W - 1:0] registers[0:NUM_REG - 1];

  set_regs: initial begin 
    integer i;
    for(i = 0; i < NUM_REG; i++) begin 
      registers[i] = {W{1'b0}};
    end
  end

  assign src_out = registers[src_sel];
  assign dest_out = registers[dest_sel];

  always @ (posedge clk) begin 
    if(write) begin 
      registers[dest_sel] <= dest_in;
    end
  end




endmodule;
