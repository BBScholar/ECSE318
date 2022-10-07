

module adder_tb;
  
  reg [15:0] a, b;
  reg [2:0] code;
  reg cin, coe;


  reg [16 + 16 + 3 + 1 + 1 - 1:0] mem[0:1023];

  wire [15:0] c;
  wire vout, cout;

  adder16 adder(
    .A(a), .B(b), .CODE(code), .cin(cin), .coe(coe),
    .C(c), .vout(vout), .cout(cout)
  );


  initial begin 
    $display("A\tB\tcin\tcoe\t  f | C   \tv\tcout");
    $monitor("%04h\t%04h\t%0b\t%0b\t%03b | %04h\t%0b\t%0b", a, b, cin, coe, code, c, vout, cout);
    
    for(code = 3'b000;code <= 3'b101; code = code + 1) begin
      a <= 16'h0000;
      b <= 16'h0001;
      cin <= 1'b0;
      coe <= 1'b0;
      #10;
      a <= 16'h000F;
      b <= 16'h000F;
      cin <= 1'b1;
      coe <= 1'b0;
      #10;
      a <= 16'h7F00;
      b <= 16'h0300;
      cin <= 1'b0;
      coe <= 1'b0;
      #10;
      a <= 16'hFF00;
      b <= 16'h0100;
      cin <= 1'b1;
      coe <= 1'b0;
      #10;
      a <= 16'h8100;
      b <= 16'h8000;
      cin <= 1'b1;
      coe <= 1'b1;
      #10;
      $display("");
    end
    $finish();

  end


endmodule
