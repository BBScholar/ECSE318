

module alu_tb;
  
  reg [15:0] a, b;
  reg [4:0] op;
  
  wire [15:0] c;
  wire overflow;


  alu alu( 
    .A(a), .B(b), .alu_code(op),
    .C(c), .overflow(overflow)
  );

  initial begin 
    $display("A\tB\top | \tc\tv");
    $monitor("%04h\t%04h\t%05b | %04h\t%01b", a, b, op, c, overflow);

    // adder/subtractor is already tested in adder_tb.v
    
    // test shift
    // sll
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
    
    $display("");
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
    $display("");



    $finish();
  end

endmodule
