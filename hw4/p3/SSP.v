
module SSP(
  input PCLK, CLEAR_B, PSEL, PWRITE, SSPCLKIN, SSPFSSIN, SSPRXD,
  input [7:0] PWDATA,
  output SSPOE_B, SSPTXD, SSPCLKOUT, SSPFSSOUT, SSPTXINTR, SSPRXINTR,
  output [7:0] PRDATA
);

  wire tx_done, rx_done;
  wire tx_done_sync, rx_done_sync;
  wire [7:0] fifo_to_tx, rx_to_fifo;

  wire tx_full, tx_empty;
  wire rx_full, rx_empty;
  wire tx_fifo_push, rx_fifo_pop;

  assign SSPTXINTR = tx_full;
  assign SSPRXINTR = rx_full;

  assign tx_fifo_push = PSEL & !tx_full & PWRITE;
  assign rx_fifo_pop  = PSEL & !rx_empty & !PWRITE;

  fifo tx_fifo(
    .clk(PCLK), .clear_b(CLEAR_B),
    .push(tx_fifo_push), .pop(tx_done_sync), 
    .data_in(PWDATA), .data_out(fifo_to_tx),
    .full(tx_full), .empty(tx_empty)
  );

  fifo rx_fifo(
    .clk(PCLK), .clear_b(CLEAR_B),
    .push(rx_done_sync), .pop(rx_fifo_pop), 
    .data_in(rx_to_fifo), .data_out(PRDATA),
    .full(rx_full), .empty(rx_empty)
  );

  sync rx_sync(
    .d(rx_done), .clk(PCLK), .q(rx_done_sync)
  );

  sync tx_sync(
    .d(tx_done), .clk(PCLK), .q(tx_done_sync)
  );

  RxTx rxtx(
      .pclk(PCLK), .pclear_b(CLEAR_B),
      .tx_data(fifo_to_tx), .rx_data(rx_to_fifo),
      .tx_done(tx_done), .rx_done(rx_done),
      .tx_empty(tx_empty),

      .SSPOE_B(SSPOE_B), .SSPCLKOUT(SSPCLKOUT),
      .SSPTXD(SSPTXD), .SSPFSSOUT(SSPFSSOUT),
      .SSPCLKIN(SSPCLKIN), .SSPFSSIN(SSPFSSIN), .SSPRXD(SSPRXD)
  );

endmodule
