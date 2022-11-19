module ssp_test1;
	reg clock, clear_b, pwrite, psel, sspclkin, sspfssin, ssprxd;
	reg [7:0] data_in;
	
	wire sspoe_b, ssptxintr, ssprxintr;
	wire [7:0] data_out;

  wire tx, rx;
  wire clk_out, clk_in;
  wire fss_out, fss_in;

  buf(rx, tx);
  buf(clk_in, clk_out);
  buf(fss_in, fss_out);

	initial 
	begin
    $monitor("%0b", data_out);
		clock = 1'b0;
		clear_b = 1'b0;
		psel = 1'b0;
		sspclkin = 1'b0;
		sspfssin = 1'b0;
		ssprxd = 1'b0;
		@(posedge clock);
		#1;
		@(posedge clock);
    			data_in = 8'b11111111; //8'hFF, dummy data. should not enter into SSP.
		#1;
				clear_b = 1'b1;

		#100 psel = 1'b1;
				pwrite = 1'b1;
				data_in = 8'b00110101; //8'h35
		#40 	data_in = 8'b10101110; //8'hAE
		#30 	psel = 1'b0;
		#200   	data_in = 8'b00100110; //8'h26
		#10 	psel = 1'b1;
		#40 	data_in = 8'b00111001; //8'h39
		#40 	data_in = 8'b10011101; //8'h9D
		#40 	data_in = 8'b01110100; //8'h74
		#40 	data_in = 8'b10001111; //8'h8F
		#40 	data_in = 8'b10110001; //8'bB1
		#40 	data_in = 8'b01010101; //8'b55
    psel = 1'b1;
    pwrite = 1'b0;
  
    #2000;
    /* $finish(); */
    $stop();
	end
	
	always 
		#20 clock = ~clock;

  always @ (posedge clock) begin 
  end

// serial output from SSP is looped back to the serial input.

	SSP ssp1 (
  .PCLK(clock), .CLEAR_B(clear_b), .PSEL(psel), .PWRITE(pwrite), .SSPCLKIN(clk_in),
  .SSPFSSIN(fss_in), .SSPRXD(rx), .PWDATA(data_in), .PRDATA(data_out), .SSPCLKOUT(clk_out),
  .SSPFSSOUT(fss_out), .SSPTXD(tx), .SSPOE_B(sspoe_b), .SSPTXINTR(ssptxintr), .SSPRXINTR(ssprxintr)
  );

  initial $monitor("%0h", data_out);

endmodule

module ssp_test2;
	reg clock, clear_b, pwrite, psel;
	reg [7:0] data_in;
	wire [7:0] data_out;
	wire ssptxintr, ssprxintr, oe_b;

  wire tx, rx;
  wire clk_out, clk_in;
  wire fss_out, fss_in;

  buf(rx, tx);
  buf(clk_in, clk_out);
  buf(fss_in, fss_out);

	initial 
	begin
		//$monitor($time," clock = %b, data_in = %b, data_out = %b", clock, data_in, data_out);
		clock = 1'b0;
		clear_b = 1'b0;
		psel = 1'b1;
		@(posedge clock);
		#1;
		@(posedge clock);
    			data_in = 8'b11111111; //8'hFF, dummy data. should not enter into SSP.
		#1;
				clear_b = 1'b1;
		#15 	pwrite = 1'b1;
				data_in = 8'b10010100; //8'h94
		#40 	data_in = 8'b00001111; //8'h0F
		#40 	data_in = 8'b01010001; //8'h51
		#40 	data_in = 8'b00100100; //8'h24
		#40 	data_in = 8'b01100111; //8'h67
		#40 	data_in = 8'b11110011; //8'hF3
		#40 	data_in = 8'b10110110; //8'hB6
		#40 	data_in = 8'b10000100; //8'b84
		#30 	psel = 1'b0;
		#870 	psel = 1'b1;
				pwrite = 1'b0;
		#80 	pwrite = 1'b1;
		#40 	psel = 1'b0;
		#3600 	pwrite = 1'b0;
    			psel = 1'b1;
    	/* #40 $finish(); */

    $stop();
	end

  always @ (posedge clock) begin 
    if(psel & !pwrite) begin 
      $display("Reading %02h", data_out);
    end
  end
	
	always 
		#20	clock = ~clock;

// serial output from SSP is looped back to the serial input.

	SSP ssp2 (
    .PCLK(clock), .CLEAR_B(clear_b), .PSEL(psel), .PWRITE(pwrite), .SSPCLKIN(clk_in),
    .SSPFSSIN(fss_in), .SSPRXD(rx), .PWDATA(data_in), .PRDATA(data_out), .SSPCLKOUT(clk_out),
    .SSPFSSOUT(fss_out), .SSPTXD(tx), .SSPOE_B(oe_b), .SSPTXINTR(ssptxintr), .SSPRXINTR(ssprxintr)
  );

endmodule



module ssp_test3;
	reg clock, clear_b, pwrite, psel;
	reg [7:0] data_in;
	wire [7:0] data_out;
	wire ssptxintr, ssprxintr, oe_b;

  wire tx, rx;
  wire clk_out, clk_in;
  wire fss_out, fss_in;

  buf(rx, tx);
  buf(clk_in, clk_out);
  buf(fss_in, fss_out);

	initial 
	begin
		//$monitor($time," clock = %b, data_in = %b, data_out = %b", clock, data_in, data_out);
		clock = 1'b0;
		clear_b = 1'b0;
		psel = 1'b1;
		@(posedge clock);
		#1;
		@(posedge clock);
    			data_in = 8'b11111111; //8'hFF, dummy data. should not enter into SSP.
		#1;
				clear_b = 1'b1;
		#15 	pwrite = 1'b1;
				data_in = 8'b10010100; //8'h94
		#40 	data_in = 8'b00001111; //8'h0F
		#40 	data_in = 8'b01010001; //8'h51
		#40 	data_in = 8'b00100100; //8'h24

    #40;

    psel = 1'b0;
    pwrite = 1'b0;

    /* #1000; */
    @(posedge ssprxintr);

    psel = 1'b1;
    #200;
    
    pwrite = 1'b1;

		#40 	data_in = 8'b01100111; //8'h67
		#40 	data_in = 8'b11110011; //8'hF3
    
    #40;
    psel = 1'b0;
    #40;
    data_in = 8'b11111111;

    #40;
    psel = 1'b1;    

		data_in = 8'b10110110; //8'hB6
		#40 	data_in = 8'b10000100; //8'b84

    psel = 1'b0;
    
    @(posedge ssprxintr);
    /* #1000; */
    pwrite = 1'b0;
    psel = 1'b1;

    #200;

    $stop();
	end

  /* always @ (posedge clock) begin  */
  /*   if(psel & !pwrite) begin  */
  /*     $display("Reading %02h", data_out); */
  /*   end */
  /* end */
	
	always 
		#20	clock = ~clock;

// serial output from SSP is looped back to the serial input.

	SSP ssp3 (
    .PCLK(clock), .CLEAR_B(clear_b), .PSEL(psel), .PWRITE(pwrite), .SSPCLKIN(clk_in),
    .SSPFSSIN(fss_in), .SSPRXD(rx), .PWDATA(data_in), .PRDATA(data_out), .SSPCLKOUT(clk_out),
    .SSPFSSOUT(fss_out), .SSPTXD(tx), .SSPOE_B(oe_b), .SSPTXINTR(ssptxintr), .SSPRXINTR(ssprxintr)
  );

endmodule

