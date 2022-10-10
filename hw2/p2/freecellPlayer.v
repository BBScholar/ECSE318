`include "freecell_notation.v"

module freecellPlayer(clock, source, dest, win);

  localparam CARD_SIZE = 6; 
  localparam TAB_MAX_SIZE = 26;
  localparam TAB_COUNT_BITS = $clog2(TAB_MAX_SIZE) + 1;
  localparam HOME_COUNT_BITS = $clog2(13) + 1;
  
  input clock;
  input [3:0] source, dest;
  output win;

  // set initial starting state

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
    .a(source[2:0]), .b(tab_src_decoded)
  );

  decoder3to8 tab_dest_dec(
    .a(dest[2:0]), .b(tab_dest_decoded)
  );

  wire invalid, valid;
  reg src_empty, dest_full, dest_empty;


  freecell_logic invalid_detect(
    .source(source), .dest(dest),
    .src_empty(src_empty), .dest_full(dest_full), .dest_empty(dest_empty),
    .src_card(src_card), .dest_card(dest_card),
    .invalid(invalid), .valid(valid)
  );

  wire [5:0] tab_src_card, free_src_card;
  wire tab_src_empty, free_src_empty;
  
  wire [5:0] tab_dest_card, free_dest_card, home_dest_card;
  wire tab_dest_full, free_dest_full, home_dest_full;
  wire tab_dest_empty, free_dest_empty, home_dest_empty;

  wire [5:0] tab_top_cards [0:7];
  wire [7:0] tab_push, tab_pop, tab_empty, tab_full;
  wire [TAB_COUNT_BITS - 1:0] tab_num_cards[0:7];

  wire [5:0] free_top_cards[0:3];
  wire [3:0] free_push, free_pop, free_empty, free_full;
  wire free_num_cards[0:3];

  wire [5:0] home_top_cards[0:3];
  wire [3:0] home_push, home_empty, home_full;
  wire [HOME_COUNT_BITS - 1:0] home_num_cards[0:3];

  assign win = &home_full;

  assign tab_src_card = tab_top_cards[source[2:0]];
  assign free_src_card = free_top_cards[source[1:0]];

  assign tab_src_empty = tab_empty[source[2:0]];
  assign free_src_empty = free_empty[source[1:0]];

  assign tab_dest_full = tab_full[dest[2:0]];
  assign free_dest_full = free_full[dest[1:0]];
  assign home_dest_full = home_full[src_card[5:4]];

  assign tab_dest_empty = tab_empty[dest[2:0]];
  assign free_dest_empty = free_empty[dest[1:0]];
  assign home_dest_empty = home_empty[src_card[5:4]];

  assign tab_dest_card = tab_top_cards[dest[2:0]];
  assign free_dest_card = free_top_cards[dest[1:0]];
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
        dest_empty <= tab_dest_empty;
      end
      2'b10: begin
        dest_card <= free_dest_card;
        dest_full <= free_dest_full;
        dest_empty <= free_dest_empty;
      end
      default: begin
        dest_card <= home_dest_card;
        dest_full <= home_dest_full;
        dest_empty <= home_dest_empty;
      end
    endcase
  end

  genvar i;
  generate 

    for(i = 0; i < 8; i =i + 1) begin : tab_gen
      
      card_stack #(.MAX_SIZE(TAB_MAX_SIZE)) tableau (
        .clk(clock), .push(tab_push[i]), .pop(tab_pop[i]), .card_in(src_card),
        .top_card(tab_top_cards[i]), .num_cards(tab_num_cards[i]), .empty(tab_empty[i]), .full(tab_full[i])
      );

    end

    for(i = 0; i < 4; i = i + 1) begin  : home_free_gen 
      
      card_stack #(.MAX_SIZE(13), .INITIAL_N(0)) home (
        .clk(clock), .push(home_push[i]), .pop(1'b0), .card_in(src_card),
        .top_card(home_top_cards[i]), .num_cards(home_num_cards[i]), .empty(home_empty[i]), .full(home_full[i])
      );

      card_stack #(.MAX_SIZE(1), .INITIAL_N(0)) free(
        .clk(clock), .push(free_push[i]), .pop(free_pop[i]), .card_in(src_card),
        .top_card(free_top_cards[i]), .num_cards(free_num_cards[i]), .empty(free_empty[i]), .full(free_full[i])
      );
    end

  endgenerate


/* S4 S5 SJ H4 DQ D5 H5 CJ */
/* DJ S10 C7 SA HJ DK D3 D4 */
/* D10 H8 C9 CQ SQ C3 HQ H10 */
/* D6 C4 C6 C5 S6 D9 D7 C8 */
/* S3 H6 C2 S7 D2 H3 CK H7 */
/* DA HK SK H9 S9 S2 C10 D8 */
/* HA H2 CA S8 */

  defparam tab_gen[0].tableau.INITIAL_N = 7;
  defparam tab_gen[1].tableau.INITIAL_N = 7;
  defparam tab_gen[2].tableau.INITIAL_N = 7;
  defparam tab_gen[3].tableau.INITIAL_N = 7;
  defparam tab_gen[4].tableau.INITIAL_N = 6;
  defparam tab_gen[5].tableau.INITIAL_N = 6;
  defparam tab_gen[6].tableau.INITIAL_N = 6;
  defparam tab_gen[7].tableau.INITIAL_N = 6; 

  defparam tab_gen[0].tableau.INITIAL_CARDS = {`S4, `DJ, `D10, `D6, `S3, `DA, `HA};
  defparam tab_gen[1].tableau.INITIAL_CARDS = {`S5, `S10, `H8, `C4, `H6, `HK, `H2};
  defparam tab_gen[2].tableau.INITIAL_CARDS = {`SJ, `C7, `C9, `C6, `C2, `SK, `CA};
  defparam tab_gen[3].tableau.INITIAL_CARDS = {`H4, `SA, `CQ, `C5, `S7, `H9, `S8};
  defparam tab_gen[4].tableau.INITIAL_CARDS = {`DQ, `HJ, `SQ, `S6, `D2, `S9};
  defparam tab_gen[5].tableau.INITIAL_CARDS = {`D5, `DK, `C3, `D9, `H3, `S2};
  defparam tab_gen[6].tableau.INITIAL_CARDS = {`H5, `D3, `HQ, `D7, `CK, `C10};
  defparam tab_gen[7].tableau.INITIAL_CARDS = {`CJ, `D4, `H10, `C8, `H7, `D8};

endmodule

module freecell_logic(
  input [3:0] source, dest,
  input src_empty, dest_full, dest_empty,
  input [5:0] src_card, dest_card,
  output wire valid, invalid
);

  wire illegal_source, order_valid, order_invalid, src_dest_eq;
  wire dest_home;
  
  assign dest_home = (dest[3:2] == 2'b11);

  assign illegal_source = (source[3:2] == 2'b11);
  assign order_invalid = !order_valid;
  assign src_dest_eq = source == dest; // not really invalid, just for convinience


  assign invalid = illegal_source | order_invalid | src_empty | dest_full | src_dest_eq;
  assign valid = !invalid;

  order_validator ord(
    .dest_home(dest_home), .dest_empty(dest_empty),
    .top(dest_card), .future_top(src_card),
    .valid(order_valid)
  );

endmodule


