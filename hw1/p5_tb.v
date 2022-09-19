
module p5_tb;

  reg clk;

  initial clk = 0;
  always #10 clk = ~clk;
  
  reg w, e;
  wire out1, out2;

  p5_struct s1(
    .clk, .w, .e, .out(out1)
  );

  p5_behav s2(
    .clk, .w, .e, .out(out2)
  );


  initial begin 
    $monitor("w=%0b, e=%0b => out1=%0b, out2=%0b", w, e, out1, out2);
    
    w <= 1'b1; 
    e <= 1'b1;
    #20

    w <= 1'b0;
    e <= 1'b0;
    #20
  
    w <= 1'b0;
    e <= 1'b1;
    #20

    w <= 1'b0;
    e <= 1'b0;
    #20

    e <= 1'b1;
    #20

    e <= 1'b0;
    #10
  
    $finish();
  end

endmodule

