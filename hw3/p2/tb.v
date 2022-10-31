

module tb;

  integer i;
  initial i = 0;


  reg clk;
  initial clk = 1'b0;
  always #10 clk = !clk;

  reg clear;
  reg [7:0] a,b;
  
  wire shift_out;
  reg [8:0] result;

  always @ (posedge clk) begin 
    a <= a >> 1;
    b <= b >> 1;
    result <= {shift_out, result[8:1]};
    i <= i + 1;
  end

  serial_adder #(.W(8)) adder(
    .clk(clk),  .a(a[0]), .b(b[0]), .result(shift_out)
  );

  task test;
    input [7:0] x, y;
    
    begin 
      a = x;
      b = y;
      #160;
      clear = 1'b1;
      #10;
      clear = 1'b0;
      #150;
      #160;
      #20;
      $display("%0d + %0d = %0d, cout=%0b", x, y, result[7:0], result[8]);
    end 
  endtask

  initial begin
    clear = 1'b0;
    a = 8'b0;
    b = 8'b0;
    #200;
    test(8'd3, 8'd7);
    test({8{1'b1}}, {8{1'b1}});
    test(8'd100, 8'd97);

    $finish();
  end


endmodule
