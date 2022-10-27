

module barrel_tb;

  localparam W = 8;
  
  reg [W - 1:0] data_in;
  reg [$clog2(W) - 1:0] shamt;
  reg [2:0] op;


  wire [W-1:0] data_out;

  barrel_shift #(.W(W)) shifter(
    .data_in(data_in), .shamt(shamt), .op(op),
    .data_out(data_out)
  );

  initial begin 
    $monitor("%08b, %03b, %03b => %08b", data_in, shamt, op, data_out);

    // test sll
    data_in <= 8'b00000001;
    op <= 3'b000;
    shamt <= 3'b011;
    #10;

    // test sla
    op <= 3'b001;
    #10;
  
    // test srl
    data_in <= 8'b10000000;
    op <= 3'b010;
    shamt <= 3'b011;
    #10;

    // test sra
    op <= 3'b011;
    #10;


    // test rotate left
    data_in <= 8'b11110000;
    shamt <= 3'b010;
    op <= 3'b100;
    #10;

    // test rotate rightl
    data_in <= 8'b00001111;
    op <= 3'b110;
    #10;



    $finish();
  end



endmodule
