
module RxTx(
  input pclk, pclear_b,
  
  // tx 
  input [7:0] tx_data,
  input tx_empty,
  output reg SSPOE_B, SSPCLKOUT,
  output SSPTXD, SSPFSSOUT,
  output tx_done,

  // rx
  output [7:0] rx_data,
  input SSPCLKIN, SSPFSSIN, SSPRXD,
  output rx_done
);
  
  // generate output clk
  always @ (posedge pclk, negedge pclear_b) begin 
    if(!pclear_b)  SSPCLKOUT = 0; 
    else SSPCLKOUT = ~SSPCLKOUT;
  end

  TX tx(
    .pclear_b(pclear_b), .SSPCLKOUT(SSPFSSOUT),
    .tx_empty(tx_empty),
    .tx_data(tx_data),
    .SSPTXD(SSPTXD), .SSPFSSOUT(SSPFSSOUT),
    .tx_done(tx_done)
  );

  RX rx(
    .pclear_b(pclear_b),
    .rx_data(rx_data),
    .SSPCLKIN(SSPCLKIN), .SSPFSSIN(SSPFSSIN), .SSPRXD(SSPRXD),
    .rx_done(rx_done)
  );
  
endmodule

