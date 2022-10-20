
module tb; 

  reg clk;

  initial clk = 0;
  always #10 clk = ~clk;
  
  reg w, e;
  wire out1, out2, out_diff;

  both_fsm both_fsm(
    .clk(clk),
    .w(w), .e(e),
    .out_s(out1), .out_b(out2), .out_diff(out_diff)
  );

  initial begin 
    $monitor("w=%0b, e=%0b => out1=%0b, out2=%0b | out_diff=%0b", w, e, out1, out2, out_diff);
    
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

