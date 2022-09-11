



module mult2
#(parameter N=4)
(
    input clk, load, en,
    input [N-1:0] a, b,
    output reg cout, valid,
    output reg [N-1:0] p
); 
  // questions:
  // can i use an enable/load lines?

  localparam counter_bits = $log2(N) + 1;
  localparam shift_reg_size = 2*N + 1;
  
  /* reg running; */
  reg [counter_bits-1:0] counter;
  reg [N-1:0] a_int, b_int, p_int;
  reg c_int;
  
  wire shifted, running;
  wire [N-1:0] anded_b;
  wire [N:0] adder_out;
  wire [2*N:0] next_reg, shifted_next_reg, selected_next_reg;

  assign anded_b = N{a_int[0]} & b_int;
  assign adder_out = anded_b + int_p;
  assign next_reg = {adder_out, a_int};
  assign next_reg_shifted = next_reg >> 1;
  assign shifted = !(|counter); // checks if counter is equal to 0

  always @ (posedge clk) begin 
    if(load) begin 
      counter <= $unsigned(N - 1);
      b_int <= b;
      {c_int, p_int, a_int} <= {1'b0, N{1'b0}, a};
    end else if(running) begin 
      counter <= counter - 1;
      b_int <= b_int;

      if(shifted)
        {c_int, p_int, a_int} <= next_reg_shifted;
      else
        {c_int, p_int, a_int} <= next_reg;
    end else begin 
      
    end
  end
    

endmodule
