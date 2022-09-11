`timescale 1ns/1ns

module p4_tb;

  // inputs
  reg [8*10 - 1:0] data;
  /* reg [7:0] data[0:9]; */
  
  // outputs
  wire [12:0] out;

  // modules
  csa8x10 csa(
    .data(data), .out(out)
  );


  // misc vars
  integer i;

  /* data[((i + 1) * 8) - 1: 8 * i] <= 0; */
  initial begin
    $monitor("out=%0d", out);

    for(i = 0; i < 10; i = i + 1) begin 
      data[8*i +: 8] <= $unsigned(i + 1);
    end

    #10 

    for(i = 0; i < 10; i = i + 1) begin 
      if(i < 3)
        data[8*i +: 8] <= 0;
      else
        data[8*i +: 8] <= $unsigned(i + 1);
    end

    #10

    $finish();
  end


endmodule
