


module cpu(
  input clk
);
  
  localparam A = 12;
  localparam W = 32;

  localparam CARRY_BIT = 0;
  localparam PARITY_BIT = 1;
  localparam EVEN_BIT = 2;
  localparam NEGATIVE_BIT = 3;
  localparam ZERO_BIT = 4;

  // CPU State
  reg [W - 1:0] pc; 
  reg [4:0] PSR;
  reg halt;
  reg [W - 1:0] instruction;

  // state initialization
  initial begin 
    pc <= 32'b0;
    halt <= 1'b0;
  end

  // program counter nets
  wire [W - 1:0] branch_destination;
  wire selected_branch_vector;
  
  // status register nets
  wire [7:0] PSR_branch_vector;

  // instruction decode nets
  wire [3:0] opcode, CC;
  wire src_type, dest_type;
  wire [11:0] src_addr, dest_addr, shamt;

  // control lines
  wire mem_write, rf_write;
  wire alu_use_imm, output_sel;
  wire set_psr, clear_psr, clear_psr_carry;
  wire load_imm;
  wire branch_op; 

  // branch logic nets
  wire branch_vector_sel;
  wire should_branch;


  // program counter process
  always @ (posedge clk) begin
    pc <= pc + 1;
  end
  
  // status registers
  assign PSR_branch_vector[0] = 1'b1;
  assign PSR_branch_vector[1] = PSR[1];
  assign PSR_branch_vector[2] = PSR[2];
  assign PSR_branch_vector[3] = PSR[0];
  assign PSR_branch_vector[4] = PSR[3];
  assign PSR_branch_vector[5] = PSR[4];
  assign PSR_branch_vector[6] = !PSR[0];
  assign PSR_branch_vector[7] = !PSR[3];

  always @ (posedge clk) begin 
    if(set_psr) begin 
    
    end

  end


  // memory manager 
  wire [A - 1:0] mem_addr, mem_addr_ls;
  wire [W - 1:0] mem_in;
  always @ (clk, pc, mem_addr_ls) begin 
    if(clk) begin 
      mem_addr <= pc;
    end else begin 
      mem_addr <= mem_addr_ls;
    end
  end
  
  // IR latch
  always @ (clk, mem_data) begin 
    if(clk) instruction <= mem_data;
  end

  // instruction decode

  assign {opcode, CC, src_type, dest_type, src_addr, shamt, } = instruction;

  always @ (opcode) begin 
    casez(opcode)
      4'b0000: begin 
        
      end
      4'b0001: begin 


      end
      4'b0010: begin 


      end
    endcase
  end




  // register file logic
  register_file rf( 
    .clk(clk), .write(), .src_sel(src_addr[3:0]), .dest_sel(dest_addr[3:0]),
    .dest_in(),
    .src_out(), .dest_out()
  );

  // ALU logic
  // NOP -- 
  // ADD 
  // XOR
  // ROTATE
  // SHIFT
  // CMP
  wire [W-1:0] alu_out, alu_cout;

  always @ (*) begin 
    casez()
        
    endcase
  end

  always @ (alu_out) begin 
    
  end


endmodule
