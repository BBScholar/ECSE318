

module mult2
#(parameter N=4)
(
    input clk, load,
    input [N-1:0] a, b,
    output wire valid,
    output reg [2*N-1:0] p
); 
  // questions:
  // can i use an enable/load lines?
  // how to correct 15 * 15

  localparam counter_bits = $clog2(N);

  reg running;
  reg [counter_bits-1:0] counter;
  reg [N-1:0] b_int;
  
  wire [N-1:0] anded_b;
  wire [N:0] adder_out;

  assign anded_b = {N{p[0]}} & b_int;
  assign adder_out = anded_b + p[N +: N];

  assign valid = !running;

  always @ (posedge clk) begin 
    if(load) begin 
      b_int <= b;
      counter <= $unsigned(N - 1); // used to be $unsigned(N - 1)
      p <= {{N{1'b0}}, a};
      running <= 1'b1;
    end else if(running) begin
      counter <= counter - 1'b1;
      p <= {adder_out, p[N-1:1]};
      running <= !(counter == {N{1'b0}});
    end 
  end
    

endmodule
