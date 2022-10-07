


module freecellPlayer2(clock, source, dest, win);
  
  input clk;
  input [3:0] source, dest;
  output win;

  localparam CW = 6; // card width

  reg [CW:0] tableau[0:19][0:7];
  integer tab_num_cards[0:7];

  reg [CW:0] free_cells[0:3];
  reg [CW:0] home_cells[0:3];

endmodule
