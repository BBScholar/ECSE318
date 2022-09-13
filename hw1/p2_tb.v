


module p2_tb;

  localparam N = 4;
  
  // inputs
  reg clk, load;
  reg [N-1:0] a, b;
  
  // outputs
  wire [2*N - 1:0] p;
  wire co, valid;

  // modules
  mult2v2 mult(
    .clk(clk), .load(load),
    .a(a), .b(b),
    .p(p), .cout(co),
    .valid(valid)
  );


  initial clk = 0;
  always #10 clk = !clk;

  initial begin 
    $monitor("a=%0d, b=%0d => p=%0d, co=%0b", a, b, p, co);

    a = 4'd2;
    b = 4'd4;
    load = 1'b1;
    #20
    load = 1'b0;

    #100

    a <= 4'd3;
    b <= 4'd15;
    load <= 1'b1;
    #20
    load <=1'b0;

    #100

    a = 4'd15;
    b = 4'd15;
    load <= 1'b1;
    #20
    load <= 1'b0;

    #100

    $finish();
  end







endmodule
