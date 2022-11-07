

module sync(
  input d, clk,
  output q
);

  reg ff;

  always @ (posedge clk) begin 
    ff <= d;
  end

  assign q = d & !ff;

endmodule
