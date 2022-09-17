
module register
#(parameter W = 4)
(
  input clk, load,
  input [W-1:0] d,
  output reg [W-1:0] q
);

  always @ (posedge clk) begin 
    if(load) begin 
      q <= d;
    end else begin 
      q <= q;
    end
  end

endmodule

module uni_shift_reg
#(parameter W = 4)
(
  input clk, load, hold, shift_in,
  input [W-1:0] load_data,
  output shift_out,
  output reg [W-1:0] q
);

  assign shift_out = q[0];

  always @ (posedge clk) begin 
    if(load) begin 
      q <= load_data;
    end else if(hold) begin 
      q <= q; // is this ok?
    end else begin 
      q <= {shift_in, q[W-1:1]};
    end
  end

endmodule

module cyc_control
#( 
  parameter W=4
)
( 
  clk, load_in,
  valid, load_out, calc, done,
  state
);

  localparam state_bits = $clog2(W) + 1;

  input wire clk, load_in;
  
  output reg [state_bits-1:0] state;
  output wire valid, load_out, calc, done;

  // wires
  wire max;
  wire [state_bits-1:0] next_state, adder_out, one;


  // assignments
  assign valid = !(|state);
  assign load_out = (state == one); // make this bitwise operation?
  assign calc = !valid & !load_in;

  assign one = {{{state_bits-1}{1'b0}}, 1'b1};
  assign done = (state == $unsigned(W));
  /* assign next_state = ({state_bits{load}} & one) | ({state_bits{valid}} & {state_bits{1'b0}}) | ({state_bits{!valid & !load}} & adder_out); */

  // modules
  prop_adder #(.WIDTH(state_bits)) adder (
    .a(state), .b(one), .cin(1'b0),
    .s(adder_out)
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

module cyc_mult
#(
  parameter W=4
)
(
  input clk, load,
  input [W-1:0] a, b,
  output [2*W-1:0] p,
  output valid
);

localparam counter_bits = $clog2(W);

wire adder_co, and_bit, p_reg_so;
wire [W-1:0] p_reg_q, a_reg_q, b_reg_q;
wire [W-1:0] anded_b, adder_sout, p_reg_in;

wire state_load, state_valid, state_calc ,done;


// assignments
assign anded_b = b_reg_q & {W{and_bit}};

assign valid = state_valid;
assign p = {p_reg_q, a_reg_q};


// modules

cyc_control ctl(
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

uni_shift_reg #(.W(W)) a_reg(
  .clk(clk), .load(load), .hold(state_valid),
  .shift_in(adder_sout[0]), .load_data(a),
  .q(a_reg_q), .shift_out(and_bit)
);

register #(.W(W)) b_reg(
  .clk(clk), .load(load),
  .d(b), 
  .q(b_reg_q)
);

prop_adder #(.WIDTH(W)) adder(
  .a(p_reg_q), .b(anded_b), .cin(1'b0),
  .s(adder_sout), .cout(adder_co)
);

  

  

endmodule
