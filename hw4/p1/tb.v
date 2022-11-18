
module tb;
  
  reg clk;
  initial clk = 'b0;

  always #10 clk = ~clk;

  reg R, A, reset;

  wire E_b, E_s, E_diff;

  both both(
    .clk(clk), .R(R), .A(A), .RESET(reset),
    .E_b(E_b), .E_s(E_s), .diff(E_diff)
  );


  initial begin 
    R = 1'b0;
    A = 1'b0;
    reset = 1'b1;

    $monitor("Time = %0d | R=%01b, A=%01b, RESET=%01b => E_s=%01b, E_b=%0b, diff=%0b", $realtime, R, A, reset, E_s, E_b, E_diff);
    
    #1;
    reset = 1'b0;
    #1;
    reset = 1'b1;

    #7;
  
    // correct usage
    #50
    R = 1'b1;
    #20
    A = 1'b1;
    #20
    R = 1'b0;
    #20
    A = 1'b0;


    #30;
  
    // error
    A = 1'b1;
    #20;
    R = 1'b1;
    #20;
    A = 1'b0;
    R = 1'b0;
    #20;

    #20;
  
    // should remain error high
    R = 1'b1;
    #20;
    A = 1'b1;
    #20;
    R = 1'b0;
    #20;
    A = 1'b0;
  

    // reset error
    #40
    reset = 1'b0;
    #20;
    reset = 1'b1;
    #20;

    // correct usage again
    #50
    R = 1'b1;
    #20;
    A = 1'b1;
    #20;
    R = 1'b0;
    #20;
    A = 1'b0;

    #40;
  

    // high at same time = error
    R = 1'b1;
    A = 1'b1;

    #20
    R = 1'b0;
    A = 1'b0;
  
    #20

    reset = 1'b0;
    #20;
    reset = 1'b1;

    #20;

    // request high then low == error
    R = 1'b1;
    #20;
    R = 1'b0;
    #40

    $stop();
  end

endmodule
