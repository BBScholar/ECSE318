
module p5_tb;

  reg clk;

  initial clk = 0;

  always #10 clk = ~clk;
  
  reg w, e;
  reg out1, out2;

  p5_struct s1(
    .clk, .w, .e, .out(out1)
  );

  p5_behav s2(
    .clk, .w, .e, .out(out2)
  );


  initial begin 
    $monitor("w=%0b, e=%0b => out1=%0b, out2=%0b", w, e, out1, out2);

  end

endmodule

