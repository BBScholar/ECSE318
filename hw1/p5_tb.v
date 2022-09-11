
module p5_tb();

  reg clk;

  initial clk = 0;
  always #10 clk = ~clk;
  
  reg w, e;
  reg out1, out2;

  p5_struct s1(
    .clk, .w, .e, .out1
  );

  p5_behav s2(
    .clk, .w, .e, .out2
  );


  initial begin 
    

  end

endmodule;
