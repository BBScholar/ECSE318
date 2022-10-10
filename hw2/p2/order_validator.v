
module order_validator(
  input dest_home, dest_empty,
  input [5:0] top, future_top,
  output reg valid
);


  wire [1:0] top_suite, future_suite;
  wire [3:0] top_value, future_value;

  assign {top_suite, top_value} = top;
  assign {future_suite, future_value} = future_top;

  wire opposite_color, same_color, same_suite;

  assign opposite_color = top_suite[0] ^ future_suite[0];
  assign same_color = !opposite_color; 
  assign same_suite = top_suite == future_suite;

  wire [3:0] home_valid_value, tab_valid_value;
  

  assign home_valid_value = top_value + 4'b0001;
  assign tab_valid_value = top_value - 4'b0001;


  // cases:
  // 1. to empty freecell/tableau
  // 2. to non-empty tableau
  // 3. to empty home cell
  // 4. to non-emppty home cell

  always @ (*) begin 

    casez({dest_home, dest_empty}) 
      2'b11: valid = (future_value == 4'b0000);
      2'b10: valid = same_suite & (future_value == home_valid_value);
      2'b01: valid = 1'b1;
      2'b00: valid = opposite_color & (future_value == tab_valid_value);
    endcase

  end

endmodule
/*

module order_validator(
  input dest_home, dest_empty,
  input [5:0] top, future_top,
  output valid
);


  wire [1:0] top_suite, future_suite;
  wire [3:0] top_value, future_value;

  assign {top_suite, top_value} = top;
  assign {future_suite, future_value} = future_top;

  wire opposite_color, same_color, same_suite;

  assign opposite_color = top_suite[0] ^ future_suite[0];
  assign same_color = !opposite_color; 
  assign same_suite = top_suite == future_suite;

  // value 
  wire [3:0] required_future_value;
  wire future_value_correct;

  assign required_future_value = top_value - 4'b0001;
  assign future_value_correct = required_future_value == future_value;

  // if home_dest, need same suite
  wire home_valid, empty_valid, normal_valid;

  assign empty_valid = dest_empty;
  assign home_valid = same_suite & future_value_correct;
  assign normal_valid = opposite_color & future_value_correct;

  assign valid = home_valid | empty_valid | normal_valid;

endmodule
*/

/* module order_validator( */
/*   input dest_home, dest_empty, */
/*   input [5:0] top, future_top, */
/*   output wire valid */
/* ); */

/*   wire [1:0] top_suit, future_suit; */
/*   wire [3:0] top_value, future_value, future_value_p1; */

/*   wire valid_int; */
/*   wire correct_value, opposite_color; */

/*   assign {top_suit, top_value} = top; */
/*   assign {future_suit, future_value} = future_top; */

/*   // suites [diamonds, clubs, hearts, spades] = [00, 01, 10, 11] */
/*   assign future_value_p1 = future_value + 4'b0001; */
/*   assign correct_value = (top_value == future_value_p1); */

/*   assign opposite_color = top_suit[0] ^ future_suit[0]; */

/*   mux2x1 out_mux( */
/*     .a(correct_value & opposite_color), .b(correct_value & !opposite_color), */
/*     .sel(dest_home), */
/*     .z(valid_int) */
/*   ); */

/*   assign valid = valid_int | dest_empty; */

/* endmodule */
