



module test_tb;

  
  reg [15:0] a, b;
  reg cin;

  wire [15:0] s;
  wire cout;



  cond_sum_with_cin #(.W(16)) adder(
    .a(a), .b(b), .cin(1'b0),
    .s(s), .cout(cout)
  );


  initial begin 
    $monitor("a=%0d, b=%0d => s=%0d, cout=%0b", a, b, s, cout);

    a = 16'd5;
    b = 16'd5;

    #10
    a = 16'd420;
    b = 16'd69;
    #10


    $display("Done");

  end


endmodule
