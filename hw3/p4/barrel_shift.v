/*

module data_reverser #(parameter W = 32)(
  input [W-1:0] x, 
  output wire [W-1:0] y
);


genvar i;
generate 
  if(W % 2)
    assign y[(W / 2) + 1] = x[(W / 2) + 1];

  for(i = 0; i < W/2; i = i + 1) begin : gen
    assign y[i] = x[W - 1 - i];
    assign y[W - 1 - i] = y[i];
  end

endgenerate

endmodule

module conditional_data_reverser #(parameter W = 32) (
  input [W-1:0] x,
  input rev,
  output wire [W-1:0] y
);

  wire [W-1:0] reversed;
  data_reverser rev_mod(
    .x(x), .y(reversed)
  );

  assign y = rev ? reversed : x;

endmodule



module barrel_shifter #(
  parameter W = 32
)(
  data, shamt, op, z
);

  localparam SHAMT_W = $clog2(W);
  
  input [W - 1:0] data;
  input [SHAMT_W-1:0] shamt;
  input [2:0] op;

  output wire [W - 1:0] z;

  wire [W-1:0] layers[0:SHAMT_W];

  wire sign, fill_sign;
  wire right, rotate, arithmetic;

  assign {rotate, right, arithmetic} = op;
  assign sign = data[W - 1];
  assign fill_sign = (arithmetic & right & sign);


  conditional_data_reverser #(.W(W)) rev_in(
    .x(data), .rev(right), .y(layers[0])
  );

  conditional_data_reverser #(.W(W)) rev_out(
    .x(layers[SHAMT_W]), .rev(right), .y(z)
  );

  genvar i, j;
  generate
    for(i = 0; i < SHAMT_W; i = i + 1) begin : gen_outer
      for(j = 0; j < W; j = j + 1) begin : gen_inner
        wire temp;


        localparam V = j - 2**i;

        if(j >= 2**i) begin 
          assign temp = layers[i][V];
        end else begin
          assign temp = rotate ? layers[i][W + V] : fill_sign;
        end


        assign layers[i + 1][j] = shamt[i] ? temp : layers[i][j];
      end
    end
  endgenerate


endmodule
*/
