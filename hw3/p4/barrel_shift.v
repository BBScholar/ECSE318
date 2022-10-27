
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
    assign y[W - 1 - i] = x[i];
  end

endgenerate

endmodule

module conditional_data_reverser #(parameter W = 32) (
  input [W-1:0] x,
  input rev,
  output wire [W-1:0] y
);

  wire [W-1:0] reversed;

  data_reverser #(.W(W)) rev_mod(
    .x(x), .y(reversed)
  );

  assign y = rev ? reversed : x;

endmodule

module barrel_shift #(parameter W = 32)(
  data_in, data_out, shamt, op 
);
  localparam SHAMT_W = $clog2(W);

  input [W-1:0] data_in;
  input [SHAMT_W-1:0] shamt;
  input [2:0] op;

  output wire [W-1:0] data_out;
  
  // internal nets
  wire [W - 1:0] layers[0:SHAMT_W];

  wire rotate, right, arithmetic;
  wire sign, fill_sign;

  assign {rotate, right, arithmetic} = op;
  assign sign = data_in[W - 1];
  assign fill_sign = arithmetic & right & sign;

  conditional_data_reverser #(.W(W)) reverser1(
    .x(data_in), .rev(right), .y(layers[0])
  );

  conditional_data_reverser #(.W(W)) reverser2(
    .x(layers[SHAMT_W]), .rev(right), .y(data_out)
  );

  genvar i, j;
  generate
    for(i = 0; i < SHAMT_W; i = i + 1) begin : layer_gen
      for(j = 0; j < W; j = j + 1) begin : mux_gen 
        localparam LAYER_SHIFT = 2 ** i;
        localparam NORMAL_IDX = j - LAYER_SHIFT;
        localparam ROTATE_IDX = W + NORMAL_IDX;

        wire temp;

        if(j >= LAYER_SHIFT) begin 
          assign temp = layers[i][j - LAYER_SHIFT];
        end else begin 
          assign temp = rotate ? layers[i][W + NORMAL_IDX] : fill_sign;
        end

        assign layers[i + 1][j] = shamt[i] ? temp : layers[i][j];

      end
    end

  endgenerate


endmodule
