`timescale 10ns/1ns

module p3_tb;
  
  parameter W = 5;

  // inputs 
  reg [W-1:0] a, b;

  // outputs
  wire [2*W-1:0] p;


  // modules

  signed_mult #(.W(W)) mult(
    .a(a), .b(b), .p(p)
  );


  initial begin 
    $monitor("a=%05d, b=%05d => p=%05h", a, b, p);

    a <= -5'd10;
    b <= 5'd4;
    #10


    a <= 5'd11;
    b <= -5'd3;
    #10


    a <= -5'd10;
    b <= -5'd11;
    #10


    a <= -5'd15;
    b <= 5'd14;
    #10

    $finish();
  end

endmodule
