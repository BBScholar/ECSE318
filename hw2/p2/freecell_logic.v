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


