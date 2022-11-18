

module tb;
  
  reg clk;
  initial clk = 0;
  always #10 clk = ~clk;

  reg pstrobe, prw;
  reg [15:0] paddress;
  wire [31:0] pdata;
  wire pready;

  wire sysstrobe, sysrw;
  wire [15:0] sysaddress;
  wire [31:0] sysdata;

  cache cache(
    .clk(clk),

    .pstrobe(pstrobe), .prw(prw),
    .paddress(paddress), .pready(pready),
    .pdata(pdata),

    .sysstrobe(sysstrobe), .sysrw(sysrw),
    .sysaddress(sysaddress), .sysdata(sysdata)
  );

  reg [31:0] sysdata_write, pdata_write;

  bufif1 pdata_buffer [31:0] (pdata, pdata_write, !prw);
  bufif1 sysdata_buffer [31:0] (sysdata, sysdata_write, sysrw);

  task read_op;
    input [15:0] addr;
    input [31:0] sys_read_data;
    begin 
      paddress = addr;
      sysdata_write = sys_read_data;
      @(negedge clk);
      prw = 1'b1;
      pstrobe = 1'b1;
      @(posedge clk);
      pstrobe = 1'b0;
      @(negedge pready);
      $display("data %0d read from address 0x%04h", pdata, addr);
      sysdata_write = 32'bX;
    end
  endtask

  task write_op;
    input [15:0] addr;
    input [31:0] input_data;
    begin 
      paddress = addr;
      pdata_write = input_data;
      @(negedge clk);
      prw = 1'b0;
      pstrobe=1'b1;
      @(posedge clk);
      pstrobe=1'b0;
      @(negedge pready);
      $display("data %0d wrote to address 0x%04h", pdata, addr);
      pdata_write = 32'bX;
    end
  endtask

  initial begin 
    pstrobe = 1'b0;
    prw = 1'b0;
    paddress = 16'b0;
    pdata_write = 32'bX;
    sysdata_write = 32'bX;

    #100;
    
    read_op(16'h12, 32'd1);
    write_op(16'h12, 32'd69);
  
    write_op(16'h15, 32'd42);
    
    #20;

    read_op(16'h12, 32'bX);

    #20;
  
    write_op(16'h55, 32'd6);

    #20;

    read_op(16'h22, 32'd37);

    #20;

    write_op(16'h75, 32'd66);

    #20;

    read_op(16'd66, 32'd1999995);

    #20;

    read_op(16'h75, 32'bX);

    #20;

    read_op(16'h59, 32'b1000);

    #20;

    read_op(16'h22, 32'bX);

    $stop();
  end

  // print out stuff
  integer i;
  initial begin 
    i = 0;
    /* $display("pstrobe | prw | paddress | pdata | pready | sysstrobe | sysrw | sysaddress | sysdata"); */
    /* $monitor("%0b %0b %04h %08h %0b %0b %0b %04h %08h", pstrobe, prw, paddress, pdata, pready, sysstrobe, sysrw, sysaddress, sysdata); */
  end

  always @ (posedge clk) i = i + 1;


endmodule
