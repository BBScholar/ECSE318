`timescale 10ns/1ns

module tb;

  // inputs
  reg [3:0] x, y;

  //outputs
  wire [7:0] p;

  // modules 
  multiplier #(.W(4)) mult(
    .x(x), .y(y), .p(p)
  );

  initial begin 
    $monitor("x=%0d, y=%0d => p=%0d", x, y, p);
    x <= 4'd2;
    y <= 4'd4;
    #10

    x <= 4'd15;
    y <= 4'd3;
    #10

    x <= 4'd15;
    y <= 4'd15;

    #10

    $finish();
  end


endmodule
