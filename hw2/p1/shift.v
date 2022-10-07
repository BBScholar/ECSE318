
// https://iverilog.fandom.com/wiki/Using_The_Verilog_%2795_Code_Generator

module mux2x1(
  a, b, sel, z
);
  
  input a, b, sel;
  output z;

  wire a, b, sel, z;

  assign z = (a & !sel) | (b & sel);

endmodule

module data_reverser(
  a, z
);

  input a;
  output z;

  wire [15:0] a, z;

  assign z[0] = a[15];
  assign z[1] = a[14];
  assign z[2] = a[13];
  assign z[3] = a[12];
  assign z[4] = a[11];
  assign z[5] = a[10];
  assign z[6] = a[9];
  assign z[7] = a[8];
  assign z[8] = a[7];
  assign z[9] = a[6];
  assign z[10] = a[5];
  assign z[11] = a[4];
  assign z[12] = a[3];
  assign z[13] = a[2];
  assign z[14] = a[1];
  assign z[15] = a[0];
  
endmodule

module conditional_data_reverser(
  a, rev, z
);

  input a, rev;
  output z;

  wire [15:0] a;
  reg [15:0] z;
  wire rev;

  // internal nets
  wire [15:0] rev_out;
  
  data_reverser rev_mod(
    .a(a), .z(rev_out)
  );

  always @ (rev_out or a or rev) begin 
    if(rev) z = rev_out;
    else z = a;
  end

endmodule

module shift16(
  a, b, op, s
);

  input a, b, op;
  output s;

  wire [15:0] a, b, s;
  wire [2:0] op;
  
  // internal nets
  wire left, logical;
  wire sign, fill_sign;
  wire [3:0] shamt;
  
  wire [15:0] shamt0, shamt1, shamt2, shamt3;
  wire [15:0] layer0, layer1, layer2, layer3, layer4;
  wire [15:0] layer0_shifted, layer1_shifted, layer2_shifted, layer3_shifted;

  assign left = !op[0];
  assign logical = !op[1];
  
  assign sign = a[15];
  assign fill_sign = !left & !logical & sign;

  assign shamt = b[3:0];

  conditional_data_reverser in_rev( 
    .a(a), .rev(!left), .z(layer0)
  );

  conditional_data_reverser out_rev(
    .a(layer4), .rev(!left), .z(s)
  );

  assign shamt0 = {16{shamt[0]}};
  assign shamt1 = {16{shamt[1]}};
  assign shamt2 = {16{shamt[2]}};
  assign shamt3 = {16{shamt[3]}};

  assign layer0_shifted = {layer0[15:1], {1{fill_sign}}};
  assign layer1_shifted = {layer1[15:2], {2{fill_sign}}};
  assign layer2_shifted = {layer2[15:4], {4{fill_sign}}};
  assign layer3_shifted = {layer3[15:8], {8{fill_sign}}};

  assign layer1 = (layer0_shifted & shamt0) | (layer0 & ~shamt0);
  assign layer2 = (layer1_shifted & shamt1) | (layer1 & ~shamt1);
  assign layer3 = (layer2_shifted & shamt2) | (layer2 & ~shamt2);
  assign layer4 = (layer3_shifted & shamt3) | (layer3 & ~shamt3);

endmodule
