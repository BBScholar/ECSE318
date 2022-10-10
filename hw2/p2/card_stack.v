`include "freecell_notation.v"

module card_stack #(parameter MAX_SIZE=13, parameter INITIAL_N = 0, parameter [6 * INITIAL_N - 1:0] INITIAL_CARDS = {(6 * INITIAL_N + 1){1'b0}}) (
  clk, push, pop, card_in, top_card, num_cards, empty, full
);

    localparam CNT_BITS = $clog2(MAX_SIZE) + 1;
  
  // io decl
  input clk, push, pop, card_in;
  output top_card, num_cards, empty, full;

  wire clk, push, pop, empty, full;
  wire [5:0] card_in;
  reg [5:0] top_card;
  reg [CNT_BITS-1:0] num_cards;

  // internal nets
  reg [5:0] all_cards[0:MAX_SIZE-1];

  // in/out assignments
  assign empty = num_cards == 0;
  assign full = num_cards == $unsigned(MAX_SIZE);

  always @ (posedge clk) begin
    if(push & !full) begin
      num_cards <= num_cards + 1;
      all_cards[num_cards] <= card_in;
    end else if(pop & !empty) begin
      num_cards <= num_cards - 1;
      all_cards[num_cards - 1] <= `INVALID_CARD;
    end

  end

  always @ (*) begin
    if(empty)
      top_card = `INVALID_CARD;
    else
      top_card = all_cards[num_cards - 1];
  end

  // initial block
  initial begin : init
    integer i;
    
    num_cards = INITIAL_N;
    for(i = 0; i < MAX_SIZE; i = i + 1) begin 
      if(i < INITIAL_N) begin
        all_cards[INITIAL_N - 1 - i] = INITIAL_CARDS[6 * i +: 6];
      end else begin 
        all_cards[i] = `INVALID_CARD;
      end
    end
  end

endmodule

