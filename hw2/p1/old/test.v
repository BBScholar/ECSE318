


`define cond_sum_wo(size, s2) \
module conditional_sum_module_``size (\
  a, b, c0, c1, s0, s1\
);\
  input a, b;\
  output c0, c1, s0, s1;\
  wire [size - 1:0] a, b;\
  reg c0, c1;\
  reg [size-1:0] s0, s1;\
  conditional_sum_module_``s2 csam_l(\
    .a(a[s2 - 1 : 0]), .b(b[s2 - 1:0])\
  );\
endmodule\

`define cond_sum_w_cin(size, s2) \
  module conditional_sum_module_with_cin_``size ( \
    a, b, cin, s, cout\
  );\
  input a, b, cin; \
  output cout, s; \
  wire [size - 1:0] a, b; \
  wire cin;\
  reg cout; \
  reg [size - 1:0] s; \
  wire b0c;\
  wire b1c0, b1c1; \
  wire [size - 1:0] b1s0, b1s1;\
  conditional_sum_module_with_cin_``s2 csa_l( \
    .a(a[s2 - 1:0]), .b(b[s2 - 1:0]), .cin(cin), \
    .cout(b0c), .s(s[s2 - 1:0]) \
  );\
  conditional_sum_module_``s2 csa_h( \
    .a(a[2 * s2 - 1:s2]), .b(b[2 * s2 - 1:s2]), \
    .s0(b1s0), .s1(b1s1), .c0(b1c0), .c1(b1c1) \
  ); \
  always @ (a or b or cin) begin  \
    if(b0c) begin  \
      cout <= b1c1; \
      s[2 * s2 - 1:s2] <= b1s1; \
    end else begin  \
      cout <= b1c0; \
      s[2 * s2 - 1:s2] <= b1s0;\
    end \
  end \
  endmodule

`define generate_with_size(size, s2) \
  `cond_sum_wo(size, s2)\
  `cond_sum_w_cin(size, s2)

/* `define generate_cond_sum_adders(size) \ */
/*   `define eq_2 size==2\ */
/*   `define s1 size / 2 \ */
/*   `ifndef eq_2\ */
/*     `generate_cond_sum_adders(`s1)\ */
/*   `endif\ */
/*   `define s1 size/2 \ */
/*   `generate_with_size(size, `s1)\ */
/*   `undef s1 */
/* https://www.veripool.org/papers/Preproc_Good_Evil_SNUGBos10_pres.pdf */

/* `generate_cond_sum_adders(16) */

`generate_with_size(2, 1)
`generate_with_size(4, 2)
`generate_with_size(8, 4)
`generate_with_size(16, 8)
