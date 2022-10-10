

module stack_tb;
  reg clk, push, pop;
  reg [5:0] card_in;

  wire [5:0] top_card;
  wire [$clog2(6):0] num_cards;
  wire empty, full;


  card_stack #(5, 2, {`SA, `SK}) stack(
    .clk(clk), .push(push), .pop(pop),
    .top_card(top_card), .num_cards(num_cards), .empty(empty), .full(full)
  );

  initial begin  
    clk = 0;
  end

  always
    #10 clk = !clk;

endmodule
