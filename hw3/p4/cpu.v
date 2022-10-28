
// Questions:
// for branch instruction, where is mem address stored(dest or source addr?)?
// logical or arithmetic shift

module cpu #(
  parameter PC_INITIAL = 12'h10
)
(
  input clk, 
  output reg mem_write,
  output reg [31:0] to_mem,
  output reg [11:0] mem_addr,
  input [31:0] from_mem
);
  
  localparam A = 12;
  localparam W = 32;

  localparam CARRY_BIT = 0;
  localparam PARITY_BIT = 1;
  localparam EVEN_BIT = 2;
  localparam NEGATIVE_BIT = 3;
  localparam ZERO_BIT = 4;

  // CPU State
  reg [A - 1:0] pc; 
  reg [4:0] PSR;
  reg halt;
  reg [W - 1:0] instruction;

  // program counter nets
  wire [A - 1:0] branch_destination;
  wire selected_branch_vector;
  
  // status register nets
  wire [7:0] PSR_branch_vector;

  // instruction decode nets
  wire [3:0] opcode, CC;
  wire src_type, dest_type;
  wire [11:0] src_addr, dest_addr, shamt;

  // control lines
  wire alu_use_imm;
  reg rf_write;
  reg [1:0] writeback_sel;
  reg set_psr, clear_psr, clear_psr_carry;
  reg load_imm;
  reg branch_op; 
  reg shift_right;
  reg shift_rotate;
  reg [1:0] alu_op;

  // branch logic nets
  wire branch_vector_sel;

  // program counter process
  always @ (posedge clk) begin
    if(!halt) begin
      if(branch_op & branch_vector_sel) begin 
        pc <= branch_destination;
      end else begin 
        pc <= pc + 12'b1;
      end
    end
  end  // state initialization

  assign branch_vector_sel = PSR_branch_vector[CC];
  assign branch_destination = dest_addr;

  initial begin 
    pc = PC_INITIAL;
    halt = 1'b0;
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

  wire [A-1:0] immediate;
  wire [W-1:0] immediate_ext;

  wire [W - 1:0] alu_b_selected;

  // memory manager 
  reg store_op;

  always @ (clk, pc, dest_addr, src_addr, store_op, alu_b_selected) begin 
    if(clk) begin 
      mem_addr <= pc;
      to_mem <= 32'b0;
      mem_write <= 1'b0;
    end else begin 
      if(store_op) begin // store op
        mem_addr <= dest_addr;
        to_mem <= alu_b_selected;
        mem_write <= 1'b1;
      end else begin // load op
        mem_addr <= src_addr;
        to_mem <= 32'b0;
        mem_write <= 1'b0;
      end
    end
  end
  
  // IR latch
  always @ (clk, from_mem) begin 
    if(clk) instruction <= from_mem;
  end

  // instruction decode

  assign {opcode, CC, src_type, dest_type, src_addr, dest_addr} = instruction;
  assign shamt = src_addr[5:0];
  assign immediate = src_addr;
  assign immediate_ext = {20'b0, src_addr};

  always @ (opcode) begin 
    casez(opcode)
      4'b0000: begin // NOP
        halt <= 1'b0;
        rf_write <= 1'b0;
        set_psr <= 1'b0;
        clear_psr_carry <= 1'b0;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b00;
      end
      4'b0001: begin // LD
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b1;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        if(src_type) begin 
          writeback_sel <= 2'b10;
        end else begin 
          writeback_sel <= 2'b11;
        end
        alu_op <= 2'b00;
      end
      4'b0010: begin // STR
        halt <= 1'b0;
        rf_write <= 1'b0;
        set_psr <= 1'b0;
        clear_psr_carry <= 1'b0;
        clear_psr <= 1'b1;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b1;
        writeback_sel <= 2'b00;
        alu_op <= 2'b00;
      end
      4'b0011: begin // BRA
        halt <= 1'b0;
        rf_write <= 1'b0;
        set_psr <= 1'b0;
        clear_psr_carry <= 1'b0;
        clear_psr <= 1'b0;
        branch_op <= 1'b1;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b00;
      end
      4'b0100: begin // XOR
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b1;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b00;// XOR
      end 
      4'b0101: begin // ADD 
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b0;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b01;
      end
      4'b0110 : begin // ROT
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b1;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b1;
        store_op <= 1'b0;
        writeback_sel <= 2'b01;
        alu_op <= 2'b00;
      end
      4'b0111 : begin // SHF
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b1;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0; // TODO: set passively?
        shift_rotate <= 1'b0;
        store_op <= 1'b1;
        writeback_sel <= 2'b01; //from barrel
        alu_op <= 2'b00;
      end
      4'b1001 : begin  // COMP
        halt <= 1'b0;
        rf_write <= 1'b1;
        set_psr <= 1'b1;
        clear_psr_carry <= 1'b1;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b10; // complement operation
      end
      default: begin // HLT and everything else
        halt <= 1'b1;
        rf_write <= 1'b0;
        set_psr <= 1'b0;
        clear_psr_carry <= 1'b0;
        clear_psr <= 1'b0;
        branch_op <= 1'b0;
        shift_right <= 1'b0;
        shift_rotate <= 1'b0;
        store_op <= 1'b0;
        writeback_sel <= 2'b00;
        alu_op <= 2'b00;
      end
    endcase
  end

  wire [W-1:0] src_out, dest_out;
  reg [W-1:0] writeback_selected;

  // register file logic
  register_file rf( 
    .clk(clk), .write(rf_write), .src_sel(src_addr[3:0]), .dest_sel(dest_addr[3:0]),
    .dest_in(writeback_selected),
    .src_out(src_out), .dest_out(dest_out)
  );

  wire [W-1:0] alu_out, shift_out;
  wire alu_cout;

  assign alu_use_imm = src_type;
  assign alu_b_selected = alu_use_imm ? immediate_ext: src_out;

  alu #(.W(W)) alu(
    .a(dest_out), .b(alu_b_selected), .op(alu_op),
    .cout(alu_cout), .s(alu_out)
  );

  barrel_shift #(.W(W)) shifter(
    .data_in(dest_out), .shamt(shamt), .op({shift_rotate, shift_right, 1'b0}),
    .data_out(shift_out)
  );

  always @ (alu_out, shift_out, from_mem, writeback_sel, immediate_ext) begin
    casez(writeback_sel)
      2'b00: writeback_selected <= alu_out;
      2'b01: writeback_selected <= shift_out;
      2'b10: writeback_selected <= immediate_ext;
      2'b11: writeback_selected <= from_mem;
    endcase
  end

  always @ (posedge clk) begin 
    if(set_psr) begin 
      if(clear_psr_carry) begin 
        PSR[CARRY_BIT] <= 1'b0;
      end else begin 
        PSR[CARRY_BIT] <= alu_cout;
      end
      PSR[PARITY_BIT] <= ^writeback_selected;
      PSR[EVEN_BIT] <= !writeback_selected[0];
      PSR[NEGATIVE_BIT] <= writeback_selected[W - 1];
      PSR[ZERO_BIT] <= (writeback_selected == {W{1'b0}});
    end else if(clear_psr) begin 
      PSR <= 5'b0; 
    end
  end


endmodule
