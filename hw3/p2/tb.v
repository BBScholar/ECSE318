

module tb;

  reg clk;

  initial clk = 1'b0;
  always #10 clk = !clk;


  reg [7:0] a, b;
  reg clear;

  reg [7:0] result;

  wire res_out, cout;

  serial_adder #(.W(8)) adder(
    .clk(clk),
    .a(a[0]), .b(b[0]), .clear(clear),
    .result(res_out)
  );

  task serial_adder_test;
    input [7:0] x, y;

    begin : do_the_thing
      a <= x;
      b <= y;
      clear = 1'b1;
      #1 
      clear = 1'b0;
      #160;
      #160;
      $display("%0d + %0d = %0d", x, y, result);
    end

  endtask

  always @ (posedge clk) begin 
    a <= a >> 1;
    b <= b >> 1;
    result <= {res_out, result[7:1]};
  end


  initial begin : testing
    // clear out the registers
    a <= 8'b0;
    b <= 8'b0;
    #1
    clear = 1'b1;
    #10
    clear = 1'b0;

    #200;

    serial_adder_test(8'd7, 8'd3);

    $finish();
  end

endmodule
