

module alu_tb;
  
  reg [15:0] a, b;
  reg [4:0] op;
  
  wire [15:0] c;
  wire overflow;


  alu alu( 
    .A(a), .B(b), .alu_code(op),
    .C(c), .overflow(overflow)
  );
    
  integer i;

  initial begin 
    $display("A\tB\top | \tc\tv");
    $monitor("%04h\t%04h\t%05b | %04h\t%01b", a, b, op, c, overflow);

    // adder/subtractor is already tested in adder_tb.v
    // test getting overflow flag
    $display("Testing overflow flag of add/subtract");
    a <= {1'b0, {15{1'b1}}};
    b <= {1'b0, {15{1'b1}}};
    op <= 5'b0;
    #10;

    a <= {1'b0, {15{1'b1}}};
    b <= 16'b0;
    op <= 5'b0;
    #10;
    
    // test shift
    // sll
    $display("Testing shifter");
    op <= 5'b10000;
    a <= 16'b01;
    b <= 16'd3;
    #10;
    op <= 5'b10010;
    #10;
    a <= {1'b1, 15'b0};
    op <= 5'b10001;
    #10;
    op <= 5'b10011;
    #10;
    a <= {2'b01, 14'b0};
    #10
    
    $display("Testing logical operations");
    // logical 
    a <= 16'hFF00;
    b <= 16'h00FF;
    op <= 5'b01000;
    #10;
    op <= 5'b01001;
    #10;
    op <= 5'b01010;
    #10;
    op <= 5'b01100;
    #10;
    $display("Testing comparator");
    a <= 16'd200;
    b <= 16'd100;
    op <= 5'b11000;

    for(i = 0; i < 5; i = i + 1) begin 
      #10;
      op <= op + 1'b1;
    end
      #10;
    $display("");

    a <= -16'd33;
    b <= 16'd15;
    op <= 5'b11000;
    for(i = 0; i < 5; i = i + 1) begin 
      #10
      op <= op + 1'b1;
    end
    #10;
    $display("");


    a <= 16'd100;
    b <= 16'd100;
    op <= 5'b11000;
    for(i = 0; i < 5; i = i + 1) begin 
      #10
      op <= op + 1'b1;
    end
    #10;
    $display("");

    a <= -16'd33;
    b <= -16'd44;
    op <= 5'b11000;
    for(i = 0; i < 5; i = i + 1) begin 
      #10;
      op <= op + 1;
    end
    #10;
    $display("");

    $finish();
  end

endmodule
