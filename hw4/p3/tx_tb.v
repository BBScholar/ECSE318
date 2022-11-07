

module tx_tb;

  reg clk, pclear_b, tx_empty;
  reg [7:0] tx_data;
  integer i;

  reg [7:0] rx_data;

  wire txd, sout;
  wire tx_done;

  TX tx(
    .pclear_b(pclear_b), .SSPCLKOUT(clk),
    .tx_empty(tx_empty), .tx_data(tx_data),
    .SSPTXD(txd), .SSPFSSOUT(sout),
    .tx_done(tx_done)
  );

  initial clk = 0;
  always #10 clk = ~clk;

  initial rx_data = 8'b0;
  initial i = 0;
  always @ (posedge clk) begin 
    rx_data <= {rx_data[6:0], txd};
    i <= i + 1;
  end

  initial begin 
    tx_empty = 1'b0;
    pclear_b = 1'b0;
    tx_data = 8'd33;
    #20;
    pclear_b = 1'b1;
    $monitor("%0b => %0b", tx_data, rx_data);

    #160;
    tx_data = 8'b10101010;
    tx_empty = 1'b0;
    #100;
    tx_empty = 1'b1;
    /* $finish(); */
  end

endmodule

