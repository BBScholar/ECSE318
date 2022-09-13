

module mult2_old
#(parameter N=4)
(
    input clk, load,
    input [N-1:0] a, b,
    output cout, valid,
    output [2*N-1:0] p
); 
  // questions:
  // can i use an enable/load lines?

  localparam counter_bits = $clog2(N) + 1;
  localparam shift_reg_size = 2*N + 1;

  reg running;
  reg [counter_bits-1:0] counter;
  reg [N-1:0] a_int, b_int, p_int;
  reg c_int;
  
  wire shifted;
  wire [N-1:0] anded_b;
  wire [N:0] adder_out;
  wire [2*N:0] next_reg, shifted_next_reg, selected_next_reg;

  assign anded_b = {N{a_int[0]}} & b_int;
  assign adder_out = anded_b + p_int;
  assign next_reg = {adder_out, a_int};
  assign shifted_next_reg = next_reg >> 1;
  assign shifted = (|counter); // checks if counter is equal to 0

  assign p = {p_int, b_int};
  assign cout = c_int;
  assign valid = !running;

  /*
  always @ (posedge clk) begin 
    if(load) begin 
      b_int <= b;
      a_int <= a;
      p_int <= {N{1'b0}};
    end
  end
  

  always @ (negedge clk) begin 

  end

  */

  always @ (posedge clk) begin 
    if(load) begin 
      counter <= $unsigned(N - 1);
      b_int <= b;
      {c_int, p_int, a_int} <= {1'b0, {N{1'b0}}, a};
      running <= 1'b1;
    end else if(running) begin
      counter <= counter - 1;
      b_int <= b_int;

      if(shifted) begin
        {c_int, p_int, a_int} <= shifted_next_reg;
        running <= 1'b1;
      end else begin
        {c_int, p_int, a_int} <= next_reg;
        running <= 1'b0;
      end
    end 
  end
    

endmodule
