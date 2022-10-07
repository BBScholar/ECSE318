

module freecellPlayer(clock, source, dest, win);
  
  input clock;
  input [3:0] source, dest;
  output win;

  wire src_tab, src_free, src_home;
  wire dest_tab, dest_free, dest_home;

  wire [7:0] tab_src_decoded, tab_dest_decoded;
  wire [3:0] free_src_decoded, free_dest_decoded;
  wire [3:0] home_dest_decoded;

  reg [5:0] src_card, dest_card;

  assign src_tab = !source[3];
  assign src_free = !src_tab & !source[2];
  assign src_home = !src_tab & source[2];

  assign dest_tab = !dest[3];
  assign dest_free = !dest_tab & !dest[2];
  assign dest_home = !dest_tab & dest[2];

  decoder2to4 free_src_dec(
    .a(source[1:0]), .b(free_src_decoded)
  );

  decoder2to4 free_dest_dec(
    .a(dest[1:0]), .b(free_dest_decoded)
  );

  decoder2to4 home_dest_dec(
    .a(src_card[5:4]), .b(home_dest_decoded)
  );


  decoder3to8 tab_src_dec(
    .a(source[2:0]), .b(tab_decoded)
  );

  decoder3to8 tab_dest_dec(
    .a(dest[2:0]), .b(tab_decoded)
  );

  wire invalid, valid;
  reg src_empty, dest_full;


  freecell_logic invalid_detect(
    .source(source), .dest(dest),
    .src_empty(src_empty), .dest_full(dest_full),
    .src_card(src_card), .dest_card(dest_card),
    .invalid(invalid), .valid(valid)
  );

  wire [5:0] tab_src_card, free_src_card;
  wire tab_src_empty, free_src_empty;
  
  wire [5:0] tab_dest_card, free_dest_card, home_dest_card;
  wire tab_dest_full, free_dest_full, home_dest_full;

  reg [5:0][7:0] tab_top_cards;
  wire [7:0] tab_push, tab_pop, tab_empty, tab_full;
  wire [34:0] tab_num_cards[0:7];

  reg [5:0] free_top_cards[0:3];
  wire [3:0] free_push, free_pop, free_empty, free_full;
  wire [34:0] free_num_cards[0:3];

  reg [5:0] home_top_cards[0:3];
  wire [3:0] home_push, home_empty, home_full;
  wire [34:0] home_num_cards[0:3];

  assign win = &home_full;

  assign tab_src_card = tab_top_cards[source[2:0]];
  assign free_src_card = free_top_cards[source[1:0]];

  assign tab_src_empty = tab_empty[source[2:0]];
  assign free_src_empty = free_empty[source[1:0]];

  assign tab_dest_full = tab_full[source[2:0]];
  assign free_dest_full = free_full[source[1:0]];
  assign home_dest_full = home_full[src_card[5:4]];

  assign tab_dest_card = tab_top_cards[source[2:0]];
  assign free_dest_card = free_top_cards[source[1:0]];
  assign home_dest_card = home_top_cards[src_card[5:4]];

  assign tab_push = {8{valid}} & {8{dest_tab}} & tab_dest_decoded;
  assign free_push = {4{valid}} & {4{dest_free}} & free_dest_decoded;
  // assign home_push = {4{valid}} & {4{src_home}} & free_home_dest_decoded;
  assign home_push = {4{valid}} & {4{dest_home}} & home_dest_decoded;

  assign tab_pop = {8{valid}} & {8{src_tab}} & tab_src_decoded;
  assign free_pop = {4{valid}} & {4{src_free}} & free_src_decoded;


  // source mux (invalid will be handled elsewhere)
  // not sure if these should be blocking or non-blocking assigns
  always @ (tab_src_card or tab_src_empty or free_src_card or free_src_empty or source) begin 
    casez(source[3])
      1'b0: begin
        src_card <= tab_src_card;
        src_empty <= tab_src_empty;
      end
      default: begin 
        src_card <= free_src_card;
        src_empty <= free_src_empty;
      end
    endcase
  end

  // dest mux
  // not sure if these should be blocking or non-blocking assigns
  always @ (tab_dest_card or tab_dest_full or free_dest_card or free_dest_full or home_dest_card or home_dest_full or dest) begin
    casez(dest[3:2])
      2'b0z: begin
        dest_card <= tab_dest_card;
        dest_full <= tab_dest_full;
      end
      2'b10: begin
        dest_card <= free_dest_card;
        dest_full <= free_dest_full;
      end
      default: begin
        dest_card <= home_dest_card;
        dest_full <= home_dest_full;
      end
    endcase
  end


  card_stack #(.MAX_SIZE(13)) tableau [7:0] (
      .clk(clk), .push(tab_push), .pop(tab_pop), .card_in(src_card), 
      .top_card(tab_top_cards), .num_cards(tab_num_cards), .empty(tab_empty), .full(tab_full)
  );
  
  card_stack #(.MAX_SIZE(1)) free [3:0] (
      .clk(clk), .push(free_push), .pop(free_pop), .card_in(src_card), 
      .top_card(free_top_cards), .num_cards(free_num_cards), .empty(free_empty), .full(free_full)
  );

  card_stack #(.MAX_SIZE(12)) home [3:0] (
      .clk(clk), .push(home_push), .pop(1'b0), .card_in(src_card), 
      .top_card(tab_top_cards), .num_cards(home_num_cards), .empty(home_empty), .full(home_full)
  );
  

endmodule

module freecell_logic(
  input [3:0] source, dest,
  input src_empty, dest_full,
  input [5:0] src_card, dest_card,
  output wire valid, invalid
);

  wire illegal_source, order_valid, order_invalid, src_dest_eq;


  assign illegal_source = (source[3:2] == 2'b11);
  assign order_invalid = !order_valid;
  assign src_dest_eq = source == dest; // not really invalid, just a convinience thing


  assign invalid = illegal_source | order_invalid | src_empty | dest_full | src_dest_eq;
  assign valid = !invalid;

  order_validator ord(
    .top(dest_card), .future_top(src_card),
    .valid(order_valid)
  );

endmodule


module card_stack #(parameter MAX_SIZE=13) (
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
    if(push && !full) begin
      num_cards <= num_cards + 1;
      all_cards[num_cards + 1] <= card_in;
    end else if(pop & !empty) begin
      num_cards <= num_cards - 1;
    end

  end

  always @ (*) begin
    if(empty)
      top_card = 6'b0;
    else
      top_card = all_cards[num_cards - 1];
  end

endmodule


module order_validator(
  input [4:0] dest,
  input [5:0] top, future_top,
  output wire valid
);

  wire [1:0] top_suit, future_suit;
  wire [3:0] top_value, future_value, top_value_p1;

  wire correct_value, opposite_color, to_home;

  assign {top_suit, top_value} = top;
  assign {future_suit, future_value} = future_top;

  // suites [diamonds, clubs, hearts, spades] = [00, 01, 10, 11]
  assign top_value_p1 = top_value + 4'b0001;
  assign correct_value = (future_value == top_value_p1);

  assign opposite_color = top_suit[0] ^ future_suit[0];
  
  assign to_home = (dest[3:2] == 2'b11);

  mux2x2 out_mux(
    .a(correct_value & opposite_color), .b(correct_value & !opposite_color),
    .sel(to_home),
    .z(valid)
  );

endmodule
