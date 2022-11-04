

module tx_tb;

  reg clk, pclear_b;
  reg [7:0] tx_data;

  reg [7:0] rx_data;

  wire txd, sout;
  wire tx_done;

  TX tx(
    .pclear_b(pclear_b), .SSPCLKOUT(clk),
    .tx_empty(1'b0), .tx_data(tx_data),
    .SSPTXD(txd), .SSPFSSOUT(sout),
    .tx_done(tx_done)
  );

  initial clk = 0;
  always #10 clk = ~clk;

  initial rx_data = 8'b0;
  always @ (posedge clk) begin 
    rx_data <= {rx_data[6:0], txd};
  end

  initial begin 
    pclear_b = 1'b0;
    tx_data = 8'd32;
    #20;
    pclear_b = 1'b1;
    $monitor("$0b => $0b", tx_data, rx_data);

    #160;

    $finish();
  end

endmodule;
