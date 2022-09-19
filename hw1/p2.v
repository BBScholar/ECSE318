
module cyclic_control
#( 
  parameter W=4
)
( 
  clk, load_in,
  valid, load_out, calc,
  state
);

  localparam state_bits = $clog2(W) + 1;

  input wire clk, load_in;
  
  output reg [state_bits-1:0] state;
  output wire valid, load_out, calc;


  // wires
  wire done;
  wire [state_bits-1:0] next_state, adder_out, one;

  // assignments
  assign valid = !(|state);
  assign load_out = (state == one); // make this bitwise operation?
  assign calc = !valid & !load_in;

  assign one = {{{state_bits-1}{1'b0}}, 1'b1};
  assign done = (state == $unsigned(W));

  // modules
  prop_adder #(.W(state_bits)) adder (
    .a(state), .b(one), .cin(1'b0),
    .s(adder_out), .cout()
  );

  always @ (posedge clk) begin 
    if(load_in) 
      state <= one;
    else if(valid | done)
      state <= {W{1'b0}};
    else
      state <= adder_out;
  end
  

endmodule

module cyclic_multiplier
#(
  parameter W=4
)
(
  input clk, load,
  input [W-1:0] a, b,
  output [2*W-1:0] p,
  output valid
);

wire adder_co, and_bit;
wire [W-1:0] p_reg_q, a_reg_q, b_reg_q;
wire [W-1:0] anded_b, adder_sout, p_reg_in;

wire state_load, state_valid, state_calc;


// assignments
assign anded_b = b_reg_q & {W{and_bit}};

assign valid = state_valid;
assign p = {p_reg_q, a_reg_q};


// modules

cyclic_control ctl(
  .clk(clk), .load_in(load),
  .state(),
  .load_out(state_load), .valid(state_valid), .calc(state_calc) 
);

mux p_input_mux [W-1:0] (
  .a({adder_co, adder_sout[W-1:1]}), .b({W{1'b0}}), .sel(load),
  .o(p_reg_in)
);

register#(.W(W)) p_reg(
  .clk(clk), .load(load | state_calc),
  .d(p_reg_in),
  .q(p_reg_q)
);

unidirectional_shift_reg #(.W(W)) a_reg(
  .clk(clk), .load(load), .hold(state_valid),
  .shift_in(adder_sout[0]), .load_data(a),
  .q(a_reg_q), .shift_out(and_bit)
);

register #(.W(W)) b_reg(
  .clk(clk), .load(load),
  .d(b), 
  .q(b_reg_q)
);

prop_adder #(.W(W)) adder(
  .a(p_reg_q), .b(anded_b), .cin(1'b0),
  .s(adder_sout), .cout(adder_co)
);

endmodule
