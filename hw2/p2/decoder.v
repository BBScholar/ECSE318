

module decoder2to4(
  input [1:0] a,
  output reg [3:0] b
);
  
  always @ (a) begin
    casez(a)
      2'b00: b = 4'b0001;
      2'b01: b = 4'b0010;
      2'b10: b = 4'b0100;
      2'b11: b = 4'b1000;
      default: b = 4'b0000;
    endcase
  end
  
endmodule


module decoder3to8(
  input [2:0] a,
  output reg [7:0] b
);

  always @ (a) begin
    casez(a)
      3'b000: b = 8'b0000_0001;
      3'b001: b = 8'b0000_0010;
      3'b010: b = 8'b0000_0100;
      3'b011: b = 8'b0000_1000;
      3'b100: b = 8'b0001_0000;
      3'b101: b = 8'b0010_0000;
      3'b110: b = 8'b0100_0000;
      3'b111: b = 8'b1000_0000;
      default: b = 8'b0;
    endcase
  end

endmodule
