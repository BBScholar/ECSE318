

module mult2v2
#(parameter N=4)
(
    input clk, load,
    input [N-1:0] a, b,
    output wire valid,
    output reg cout,
    output reg [2*N-1:0] p
); 
  // questions:
  // can i use an enable/load lines?
  // how to correct 15 * 15

  localparam counter_bits = $clog2(N);

  reg running;
  reg [counter_bits-1:0] counter;
  reg [N-1:0] b_int;
  
  wire shifted;
  wire [N-1:0] anded_b;
  wire [N:0] adder_out;
  wire [2*N:0] next_reg, shifted_next_reg, selected_next_reg;

  assign anded_b = {N{p[0]}} & b_int;
  assign adder_out = anded_b + p[N +: N];
  assign next_reg = {adder_out, p[N-1:1]};
  assign shifted_next_reg = next_reg >> 1;
  assign shifted = (|counter); // checks if counter is equal to 0

  assign valid = !running;

  always @ (posedge clk) begin 
    if(load) begin 
      counter <= $unsigned(N - 1);
      b_int <= b;
      {cout, p} <= {1'b0, {N{1'b0}}, a};
      running <= 1'b1;
    end else if(running) begin
      counter <= counter - 1;
      
      {cout, p} <= {adder_out, p[N-1:0]} >> 1;

      if(counter == 0) 
        running <= 1'b0;
      else 
        running <= 1'b1;
    end 
  end
    

endmodule
