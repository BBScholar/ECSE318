//
// Verilog description for cell alu, 
// Thu Oct 13 17:31:50 2022
//
// LeonardoSpectrum Level 3, 2009a.6 
//


module alu ( A, B, alu_code, C, overflow ) ;

    input [15:0]A ;
    input [15:0]B ;
    input [4:0]alu_code ;
    output [15:0]C ;
    output overflow ;

    wire add_vout, logic_out_15, logic_out_14, logic_out_13, logic_out_12, 
         logic_out_11, logic_out_10, logic_out_9, logic_out_8, logic_out_7, 
         logic_out_6, logic_out_5, logic_out_4, logic_out_3, logic_out_2, 
         logic_out_1, logic_out_0, add_out_15, add_out_14, add_out_13, 
         add_out_12, add_out_11, add_out_10, add_out_9, add_out_8, add_out_7, 
         add_out_6, add_out_5, add_out_4, add_out_3, add_out_2, add_out_1, 
         add_out_0, shift_out_15, shift_out_14, shift_out_13, shift_out_12, 
         shift_out_11, shift_out_10, shift_out_9, shift_out_8, shift_out_7, 
         shift_out_6, shift_out_5, shift_out_4, shift_out_3, shift_out_2, 
         shift_out_1, shift_out_0, nx12, nx26, nx42, nx56, nx62, nx70, nx76, 
         nx100, nx114, nx124, nx134, nx144, nx154, nx164, nx174, nx184, nx194, 
         nx204, nx214, nx224, nx234, nx244, nx254, nx373, nx378, nx382, nx385, 
         nx387, nx389, nx391, nx394, nx396, nx398, nx400, nx403, nx405, nx407, 
         nx409, nx412, nx414, nx416, nx418, nx422, nx459, nx461, nx463, nx465, 
         nx467, nx469, nx471, nx473, nx475, nx477, nx479, nx481, nx483, 
         adder_b_sign, adder_subtraction, adder_b_source_14, adder_b_source_13, 
         adder_b_source_12, adder_b_source_11, adder_b_source_10, 
         adder_b_source_9, adder_b_source_8, adder_b_source_7, adder_b_source_6, 
         adder_b_source_5, adder_b_source_4, adder_b_source_3, adder_b_source_2, 
         adder_b_source_1, adder_b_source_0, adder_adder_b1s1_7, 
         adder_adder_b1s1_6, adder_adder_b1s1_5, adder_adder_b1s1_4, 
         adder_adder_b1s1_3, adder_adder_b1s1_2, adder_adder_b1s1_1, 
         adder_adder_b1s1_0, adder_adder_b1s0_7, adder_adder_b1s0_6, 
         adder_adder_b1s0_5, adder_adder_b1s0_4, adder_adder_b1s0_3, 
         adder_adder_b1s0_2, adder_adder_b1s0_1, adder_adder_b1s0_0, 
         adder_adder_csa_l_b1s1_3, adder_adder_csa_l_b1s1_2, 
         adder_adder_csa_l_b1s1_1, adder_adder_csa_l_b1s1_0, 
         adder_adder_csa_l_b1s0_3, adder_adder_csa_l_b1s0_2, 
         adder_adder_csa_l_b1s0_1, adder_adder_csa_l_b1s0_0, 
         adder_adder_csa_l_b1c1, adder_adder_csa_l_b1c0, adder_adder_csa_l_b0c, 
         adder_nx38, adder_nx98, adder_nx202, adder_nx69, adder_nx75, adder_nx77, 
         adder_nx83, adder_nx87, adder_nx91, adder_nx95, adder_nx99, adder_nx103, 
         adder_nx107, adder_nx111, adder_nx115, adder_nx119, adder_nx123, 
         adder_nx127, adder_nx131, adder_nx135, adder_nx139, adder_nx143, 
         adder_cin, adder_nx179, adder_nx181, adder_nx183, adder_nx185, 
         adder_nx191, adder_nx197, adder_adder_csa_h_b0c1, 
         adder_adder_csa_h_b0c0, adder_adder_csa_h_nx54, adder_adder_csa_h_nx64, 
         adder_adder_csa_h_nx66, adder_adder_csa_h_nx116, adder_adder_csa_h_nx87, 
         adder_adder_csa_h_nx89, adder_adder_csa_h_nx93, adder_adder_csa_h_nx95, 
         adder_adder_csa_h_nx97, adder_adder_csa_h_nx99, adder_adder_csa_h_nx101, 
         adder_adder_csa_h_nx107, adder_adder_csa_h_nx109, 
         adder_adder_csa_h_nx113, adder_adder_csa_h_nx117, 
         adder_adder_csa_h_nx119, adder_adder_csa_h_nx121, 
         adder_adder_csa_h_nx125, adder_adder_csa_h_nx127, 
         adder_adder_csa_h_nx129, adder_adder_csa_h_nx131, 
         adder_adder_csa_h_nx133, adder_adder_csa_h_nx135, 
         adder_adder_csa_h_nx147, adder_adder_csa_h_nx149, 
         adder_adder_csa_h_nx151, adder_adder_csa_h_csa_l_nx40, 
         adder_adder_csa_h_csa_l_nx74, adder_adder_csa_h_csa_l_nx88, 
         adder_adder_csa_h_csa_l_nx188, adder_adder_csa_h_csa_l_nx191, 
         adder_adder_csa_h_csa_l_nx193, adder_adder_csa_h_csa_l_nx195, 
         adder_adder_csa_h_csa_l_nx198, adder_adder_csa_h_csa_l_nx200, 
         adder_adder_csa_h_csa_l_nx203, adder_adder_csa_h_csa_l_nx206, 
         adder_adder_csa_h_csa_l_nx208, adder_adder_csa_h_csa_l_nx210, 
         adder_adder_csa_h_csa_l_nx212, adder_adder_csa_h_csa_l_nx214, 
         adder_adder_csa_h_csa_l_nx220, adder_adder_csa_h_csa_l_nx223, 
         adder_adder_csa_h_csa_l_nx227, adder_adder_csa_h_csa_l_nx230, 
         adder_adder_csa_h_csa_l_nx238, adder_adder_csa_l_csa_l_nx0, 
         adder_adder_csa_l_csa_l_nx24, adder_adder_csa_l_csa_l_nx30, 
         adder_adder_csa_l_csa_l_nx58, adder_adder_csa_l_csa_l_nx161, 
         adder_adder_csa_l_csa_l_nx164, adder_adder_csa_l_csa_l_nx166, 
         adder_adder_csa_l_csa_l_nx170, adder_adder_csa_l_csa_l_nx172, 
         adder_adder_csa_l_csa_l_nx177, adder_adder_csa_l_csa_l_nx179, 
         adder_adder_csa_l_csa_l_nx181, adder_adder_csa_l_csa_l_nx183, 
         adder_adder_csa_l_csa_l_nx187, adder_adder_csa_l_csa_h_nx40, 
         adder_adder_csa_l_csa_h_nx74, adder_adder_csa_l_csa_h_nx88, 
         adder_adder_csa_l_csa_h_nx188, adder_adder_csa_l_csa_h_nx191, 
         adder_adder_csa_l_csa_h_nx193, adder_adder_csa_l_csa_h_nx195, 
         adder_adder_csa_l_csa_h_nx198, adder_adder_csa_l_csa_h_nx200, 
         adder_adder_csa_l_csa_h_nx203, adder_adder_csa_l_csa_h_nx206, 
         adder_adder_csa_l_csa_h_nx208, adder_adder_csa_l_csa_h_nx210, 
         adder_adder_csa_l_csa_h_nx212, adder_adder_csa_l_csa_h_nx214, 
         adder_adder_csa_l_csa_h_nx220, adder_adder_csa_l_csa_h_nx223, 
         adder_adder_csa_l_csa_h_nx227, adder_adder_csa_l_csa_h_nx230, 
         adder_adder_csa_l_csa_h_nx238, shift_nx2, shift_nx4, shift_nx6, 
         shift_nx14, shift_nx22, shift_nx30, shift_nx36, shift_nx42, shift_nx52, 
         shift_nx56, shift_nx64, shift_nx76, shift_nx80, shift_nx90, shift_nx102, 
         shift_nx106, shift_nx112, shift_nx120, shift_nx132, shift_nx136, 
         shift_nx148, shift_nx160, shift_nx164, shift_nx168, shift_nx172, 
         shift_nx182, shift_nx194, shift_nx198, shift_nx210, shift_nx222, 
         shift_nx226, shift_nx230, shift_nx242, shift_nx254, shift_nx258, 
         shift_nx270, shift_nx278, shift_nx282, shift_nx286, shift_nx294, 
         shift_nx304, shift_nx310, shift_nx316, shift_nx328, shift_nx338, 
         shift_nx342, shift_nx350, shift_nx362, shift_nx366, shift_nx376, 
         shift_nx388, shift_nx392, shift_nx404, shift_nx412, shift_nx416, 
         shift_nx424, shift_nx432, shift_nx438, shift_nx448, shift_nx456, 
         shift_nx466, shift_nx474, shift_nx482, shift_nx490, shift_nx496, 
         shift_nx506, shift_nx514, shift_nx524, shift_nx532, shift_nx540, 
         shift_nx548, shift_nx564, shift_nx572, shift_nx588, shift_nx596, 
         shift_nx612, shift_nx620, shift_nx636, shift_nx642, shift_nx650, 
         shift_nx658, shift_nx666, shift_nx674, shift_nx682, shift_nx690, 
         shift_nx698, shift_nx151, shift_nx155, shift_nx159, shift_nx171, 
         shift_nx177, shift_nx237, shift_nx265, shift_nx281, shift_nx297, 
         shift_nx303, shift_nx309, shift_nx315, shift_nx348, shift_nx351, 
         shift_nx353, shift_nx355, shift_nx357, shift_nx359, shift_nx361, 
         shift_nx369, shift_nx371, shift_nx373, logic_nx16, logic_nx631, 
         logic_nx633, logic_nx635, logic_nx639, logic_nx641, logic_nx645, 
         logic_nx647, logic_nx650, logic_nx652, logic_nx655, logic_nx657, 
         logic_nx660, logic_nx662, logic_nx665, logic_nx667, logic_nx670, 
         logic_nx672, logic_nx675, logic_nx677, logic_nx680, logic_nx682, 
         logic_nx685, logic_nx687, logic_nx690, logic_nx692, logic_nx695, 
         logic_nx697, logic_nx700, logic_nx702, logic_nx705, logic_nx707, 
         logic_nx710, logic_nx712, logic_nx715, logic_nx717, logic_nx724, 
         logic_nx726, logic_nx728, logic_nx730, logic_nx732, logic_nx734, 
         logic_nx736, logic_nx738, logic_nx740, logic_nx742, logic_nx744, 
         logic_nx746, nx591, nx593, nx595, nx597, nx599;



    nor02_2x ix101 (.Y (nx100), .A0 (alu_code[4]), .A1 (alu_code[3])) ;
    nand02_2x ix107 (.Y (C[0]), .A0 (nx373), .A1 (nx378)) ;
    aoi22 ix374 (.Y (nx373), .A0 (add_out_0), .A1 (nx477), .B0 (logic_out_0), .B1 (
          nx469)) ;
    aoi32 ix379 (.Y (nx378), .A0 (nx76), .A1 (alu_code[4]), .A2 (alu_code[3]), .B0 (
          shift_out_0), .B1 (nx461)) ;
    ao22 ix77 (.Y (nx76), .A0 (alu_code[1]), .A1 (nx62), .B0 (alu_code[2]), .B1 (
         nx70)) ;
    xnor2 ix63 (.Y (nx62), .A0 (nx483), .A1 (alu_code[0])) ;
    nor04 ix383 (.Y (nx382), .A0 (nx56), .A1 (nx42), .A2 (nx26), .A3 (nx12)) ;
    nand04 ix57 (.Y (nx56), .A0 (nx385), .A1 (nx387), .A2 (nx389), .A3 (nx391)
           ) ;
    xnor2 ix386 (.Y (nx385), .A0 (A[15]), .A1 (B[15])) ;
    xnor2 ix388 (.Y (nx387), .A0 (A[14]), .A1 (B[14])) ;
    xnor2 ix390 (.Y (nx389), .A0 (A[13]), .A1 (B[13])) ;
    xnor2 ix392 (.Y (nx391), .A0 (A[12]), .A1 (B[12])) ;
    nand04 ix43 (.Y (nx42), .A0 (nx394), .A1 (nx396), .A2 (nx398), .A3 (nx400)
           ) ;
    xnor2 ix395 (.Y (nx394), .A0 (A[11]), .A1 (B[11])) ;
    xnor2 ix397 (.Y (nx396), .A0 (A[10]), .A1 (B[10])) ;
    xnor2 ix399 (.Y (nx398), .A0 (A[9]), .A1 (B[9])) ;
    xnor2 ix401 (.Y (nx400), .A0 (A[8]), .A1 (B[8])) ;
    nand04 ix27 (.Y (nx26), .A0 (nx403), .A1 (nx405), .A2 (nx407), .A3 (nx409)
           ) ;
    xnor2 ix404 (.Y (nx403), .A0 (A[7]), .A1 (B[7])) ;
    xnor2 ix406 (.Y (nx405), .A0 (A[6]), .A1 (B[6])) ;
    xnor2 ix408 (.Y (nx407), .A0 (A[5]), .A1 (B[5])) ;
    xnor2 ix410 (.Y (nx409), .A0 (A[4]), .A1 (B[4])) ;
    nand04 ix13 (.Y (nx12), .A0 (nx412), .A1 (nx414), .A2 (nx416), .A3 (nx418)
           ) ;
    xnor2 ix413 (.Y (nx412), .A0 (A[3]), .A1 (B[3])) ;
    xnor2 ix415 (.Y (nx414), .A0 (A[2]), .A1 (B[2])) ;
    xnor2 ix417 (.Y (nx416), .A0 (A[1]), .A1 (B[1])) ;
    xnor2 ix419 (.Y (nx418), .A0 (A[0]), .A1 (B[0])) ;
    mux21_ni ix71 (.Y (nx70), .A0 (alu_code[1]), .A1 (alu_code[0]), .S0 (nx483)
             ) ;
    inv02 ix423 (.Y (nx422), .A (alu_code[4])) ;
    ao21 ix117 (.Y (C[1]), .A0 (add_out_1), .A1 (nx477), .B0 (nx114)) ;
    ao22 ix115 (.Y (nx114), .A0 (logic_out_1), .A1 (nx469), .B0 (shift_out_1), .B1 (
         nx461)) ;
    ao21 ix127 (.Y (C[2]), .A0 (add_out_2), .A1 (nx477), .B0 (nx124)) ;
    ao22 ix125 (.Y (nx124), .A0 (logic_out_2), .A1 (nx469), .B0 (shift_out_2), .B1 (
         nx461)) ;
    ao21 ix137 (.Y (C[3]), .A0 (add_out_3), .A1 (nx477), .B0 (nx134)) ;
    ao22 ix135 (.Y (nx134), .A0 (logic_out_3), .A1 (nx469), .B0 (shift_out_3), .B1 (
         nx461)) ;
    ao21 ix147 (.Y (C[4]), .A0 (add_out_4), .A1 (nx477), .B0 (nx144)) ;
    ao22 ix145 (.Y (nx144), .A0 (logic_out_4), .A1 (nx469), .B0 (shift_out_4), .B1 (
         nx461)) ;
    ao21 ix157 (.Y (C[5]), .A0 (add_out_5), .A1 (nx477), .B0 (nx154)) ;
    ao22 ix155 (.Y (nx154), .A0 (logic_out_5), .A1 (nx469), .B0 (shift_out_5), .B1 (
         nx461)) ;
    ao21 ix167 (.Y (C[6]), .A0 (add_out_6), .A1 (nx479), .B0 (nx164)) ;
    ao22 ix165 (.Y (nx164), .A0 (logic_out_6), .A1 (nx469), .B0 (shift_out_6), .B1 (
         nx461)) ;
    ao21 ix177 (.Y (C[7]), .A0 (add_out_7), .A1 (nx479), .B0 (nx174)) ;
    ao22 ix175 (.Y (nx174), .A0 (logic_out_7), .A1 (nx471), .B0 (shift_out_7), .B1 (
         nx463)) ;
    ao21 ix187 (.Y (C[8]), .A0 (add_out_8), .A1 (nx479), .B0 (nx184)) ;
    ao22 ix185 (.Y (nx184), .A0 (logic_out_8), .A1 (nx471), .B0 (shift_out_8), .B1 (
         nx463)) ;
    ao21 ix197 (.Y (C[9]), .A0 (add_out_9), .A1 (nx479), .B0 (nx194)) ;
    ao22 ix195 (.Y (nx194), .A0 (logic_out_9), .A1 (nx471), .B0 (shift_out_9), .B1 (
         nx463)) ;
    ao21 ix207 (.Y (C[10]), .A0 (add_out_10), .A1 (nx479), .B0 (nx204)) ;
    ao22 ix205 (.Y (nx204), .A0 (logic_out_10), .A1 (nx471), .B0 (shift_out_10)
         , .B1 (nx463)) ;
    ao21 ix217 (.Y (C[11]), .A0 (add_out_11), .A1 (nx479), .B0 (nx214)) ;
    ao22 ix215 (.Y (nx214), .A0 (logic_out_11), .A1 (nx471), .B0 (shift_out_11)
         , .B1 (nx463)) ;
    ao21 ix227 (.Y (C[12]), .A0 (add_out_12), .A1 (nx479), .B0 (nx224)) ;
    ao22 ix225 (.Y (nx224), .A0 (logic_out_12), .A1 (nx471), .B0 (shift_out_12)
         , .B1 (nx463)) ;
    ao21 ix237 (.Y (C[13]), .A0 (add_out_13), .A1 (nx481), .B0 (nx234)) ;
    ao22 ix235 (.Y (nx234), .A0 (logic_out_13), .A1 (nx471), .B0 (shift_out_13)
         , .B1 (nx463)) ;
    ao21 ix247 (.Y (C[14]), .A0 (add_out_14), .A1 (nx481), .B0 (nx244)) ;
    ao22 ix245 (.Y (nx244), .A0 (logic_out_14), .A1 (nx473), .B0 (shift_out_14)
         , .B1 (nx465)) ;
    ao21 ix257 (.Y (C[15]), .A0 (add_out_15), .A1 (nx481), .B0 (nx254)) ;
    ao22 ix255 (.Y (nx254), .A0 (logic_out_15), .A1 (nx473), .B0 (shift_out_15)
         , .B1 (nx465)) ;
    inv02 ix460 (.Y (nx461), .A (nx459)) ;
    inv02 ix462 (.Y (nx463), .A (nx459)) ;
    inv02 ix464 (.Y (nx465), .A (nx459)) ;
    inv02 ix468 (.Y (nx469), .A (nx467)) ;
    inv02 ix470 (.Y (nx471), .A (nx467)) ;
    inv02 ix472 (.Y (nx473), .A (nx467)) ;
    inv02 ix474 (.Y (nx475), .A (nx100)) ;
    inv02 ix476 (.Y (nx477), .A (nx475)) ;
    inv02 ix478 (.Y (nx479), .A (nx475)) ;
    inv02 ix480 (.Y (nx481), .A (nx475)) ;
    buf02 ix482 (.Y (nx483), .A (nx382)) ;
    nand02_2x ix93 (.Y (nx467), .A0 (nx422), .A1 (alu_code[3])) ;
    or02 ix85 (.Y (nx459), .A0 (nx422), .A1 (alu_code[3])) ;
    ao21 adder_ix103 (.Y (adder_subtraction), .A0 (alu_code[0]), .A1 (
         alu_code[2]), .B0 (alu_code[1])) ;
    nor02ii adder_ix99 (.Y (adder_nx98), .A0 (alu_code[1]), .A1 (alu_code[2])) ;
    nand02_2x adder_ix76 (.Y (adder_nx75), .A0 (B[1]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix84 (.Y (adder_nx83), .A0 (B[2]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix88 (.Y (adder_nx87), .A0 (B[3]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix92 (.Y (adder_nx91), .A0 (B[4]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix96 (.Y (adder_nx95), .A0 (B[5]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix100 (.Y (adder_nx99), .A0 (B[6]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix104 (.Y (adder_nx103), .A0 (B[7]), .A1 (adder_nx183)) ;
    nand02_2x adder_ix108 (.Y (adder_nx107), .A0 (B[8]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix112 (.Y (adder_nx111), .A0 (B[9]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix116 (.Y (adder_nx115), .A0 (B[10]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix120 (.Y (adder_nx119), .A0 (B[11]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix124 (.Y (adder_nx123), .A0 (B[12]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix128 (.Y (adder_nx127), .A0 (B[13]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix132 (.Y (adder_nx131), .A0 (B[14]), .A1 (adder_nx185)) ;
    nand02_2x adder_ix136 (.Y (adder_nx135), .A0 (B[15]), .A1 (adder_nx77)) ;
    nor03 adder_ix219 (.Y (add_vout), .A0 (adder_nx139), .A1 (adder_nx202), .A2 (
          adder_nx143)) ;
    nor02ii adder_ix140 (.Y (adder_nx139), .A0 (alu_code[2]), .A1 (alu_code[0])
            ) ;
    xor2 adder_ix203 (.Y (adder_nx202), .A0 (A[15]), .A1 (adder_b_sign)) ;
    xnor2 adder_ix144 (.Y (adder_nx143), .A0 (A[15]), .A1 (add_out_15)) ;
    mux21_ni adder_ix211 (.Y (add_out_15), .A0 (adder_adder_b1s0_7), .A1 (
             adder_adder_b1s1_7), .S0 (adder_nx179)) ;
    mux21_ni adder_ix39 (.Y (adder_nx38), .A0 (adder_adder_csa_l_b1c0), .A1 (
             adder_adder_csa_l_b1c1), .S0 (adder_adder_csa_l_b0c)) ;
    mux21_ni adder_ix15 (.Y (add_out_5), .A0 (adder_adder_csa_l_b1s0_1), .A1 (
             adder_adder_csa_l_b1s1_1), .S0 (adder_adder_csa_l_b0c)) ;
    mux21_ni adder_ix23 (.Y (add_out_6), .A0 (adder_adder_csa_l_b1s0_2), .A1 (
             adder_adder_csa_l_b1s1_2), .S0 (adder_adder_csa_l_b0c)) ;
    mux21_ni adder_ix31 (.Y (add_out_7), .A0 (adder_adder_csa_l_b1s0_3), .A1 (
             adder_adder_csa_l_b1s1_3), .S0 (adder_adder_csa_l_b0c)) ;
    mux21_ni adder_ix55 (.Y (add_out_9), .A0 (adder_adder_b1s0_1), .A1 (
             adder_adder_b1s1_1), .S0 (adder_nx179)) ;
    mux21_ni adder_ix63 (.Y (add_out_10), .A0 (adder_adder_b1s0_2), .A1 (
             adder_adder_b1s1_2), .S0 (adder_nx179)) ;
    mux21_ni adder_ix71 (.Y (add_out_11), .A0 (adder_adder_b1s0_3), .A1 (
             adder_adder_b1s1_3), .S0 (adder_nx179)) ;
    mux21_ni adder_ix79 (.Y (add_out_12), .A0 (adder_adder_b1s0_4), .A1 (
             adder_adder_b1s1_4), .S0 (adder_nx179)) ;
    mux21_ni adder_ix87 (.Y (add_out_13), .A0 (adder_adder_b1s0_5), .A1 (
             adder_adder_b1s1_5), .S0 (adder_nx179)) ;
    mux21_ni adder_ix95 (.Y (add_out_14), .A0 (adder_adder_b1s0_6), .A1 (
             adder_adder_b1s1_6), .S0 (adder_nx181)) ;
    inv02 adder_ix78 (.Y (adder_nx77), .A (adder_nx98)) ;
    inv02 adder_ix171 (.Y (adder_cin), .A (adder_nx197)) ;
    buf02 adder_ix178 (.Y (adder_nx179), .A (adder_nx38)) ;
    buf02 adder_ix180 (.Y (adder_nx181), .A (adder_nx38)) ;
    inv02 adder_ix182 (.Y (adder_nx183), .A (adder_nx191)) ;
    inv02 adder_ix184 (.Y (adder_nx185), .A (adder_nx191)) ;
    inv02 adder_ix190 (.Y (adder_nx191), .A (adder_nx77)) ;
    inv02 adder_ix196 (.Y (adder_nx197), .A (adder_subtraction)) ;
    xnor2 adder_adder_csa_h_ix9 (.Y (adder_adder_b1s1_4), .A0 (
          adder_adder_csa_h_nx147), .A1 (adder_adder_csa_h_nx87)) ;
    oai21 adder_adder_csa_h_ix88 (.Y (adder_adder_csa_h_nx87), .A0 (A[12]), .A1 (
          adder_b_source_12), .B0 (adder_adder_csa_h_nx89)) ;
    nand02_2x adder_adder_csa_h_ix90 (.Y (adder_adder_csa_h_nx89), .A0 (
              adder_b_source_12), .A1 (A[12])) ;
    mux21 adder_adder_csa_h_ix31 (.Y (adder_adder_b1s1_5), .A0 (
          adder_adder_csa_h_nx93), .A1 (adder_adder_csa_h_nx99), .S0 (
          adder_adder_csa_h_nx147)) ;
    xnor2 adder_adder_csa_h_ix94 (.Y (adder_adder_csa_h_nx93), .A0 (
          adder_adder_csa_h_nx95), .A1 (adder_adder_csa_h_nx89)) ;
    oai21 adder_adder_csa_h_ix96 (.Y (adder_adder_csa_h_nx95), .A0 (A[13]), .A1 (
          adder_b_source_13), .B0 (adder_adder_csa_h_nx97)) ;
    nand02_2x adder_adder_csa_h_ix98 (.Y (adder_adder_csa_h_nx97), .A0 (
              adder_b_source_13), .A1 (A[13])) ;
    xnor2 adder_adder_csa_h_ix100 (.Y (adder_adder_csa_h_nx99), .A0 (
          adder_adder_csa_h_nx95), .A1 (adder_adder_csa_h_nx101)) ;
    nor02_2x adder_adder_csa_h_ix102 (.Y (adder_adder_csa_h_nx101), .A0 (
             adder_b_source_12), .A1 (A[12])) ;
    ao21 adder_adder_csa_h_ix71 (.Y (adder_adder_b1s1_6), .A0 (
         adder_adder_csa_h_nx147), .A1 (adder_adder_csa_h_nx66), .B0 (
         adder_adder_csa_h_nx54)) ;
    xnor2 adder_adder_csa_h_ix67 (.Y (adder_adder_csa_h_nx66), .A0 (
          adder_adder_csa_h_nx107), .A1 (adder_adder_csa_h_nx151)) ;
    oai21 adder_adder_csa_h_ix108 (.Y (adder_adder_csa_h_nx107), .A0 (A[14]), .A1 (
          adder_b_source_14), .B0 (adder_adder_csa_h_nx109)) ;
    nand02_2x adder_adder_csa_h_ix110 (.Y (adder_adder_csa_h_nx109), .A0 (
              adder_b_source_14), .A1 (A[14])) ;
    oai32 adder_adder_csa_h_ix66 (.Y (adder_adder_csa_h_nx64), .A0 (
          adder_b_source_12), .A1 (A[12]), .A2 (adder_adder_csa_h_nx97), .B0 (
          adder_adder_csa_h_nx101), .B1 (adder_adder_csa_h_nx113)) ;
    nor02_2x adder_adder_csa_h_ix114 (.Y (adder_adder_csa_h_nx113), .A0 (
             adder_b_source_13), .A1 (A[13])) ;
    nor02_2x adder_adder_csa_h_ix55 (.Y (adder_adder_csa_h_nx54), .A0 (
             adder_adder_csa_h_nx147), .A1 (adder_adder_csa_h_nx117)) ;
    xnor2 adder_adder_csa_h_ix118 (.Y (adder_adder_csa_h_nx117), .A0 (
          adder_adder_csa_h_nx107), .A1 (adder_adder_csa_h_nx119)) ;
    mux21_ni adder_adder_csa_h_ix120 (.Y (adder_adder_csa_h_nx119), .A0 (
             adder_adder_csa_h_nx121), .A1 (adder_adder_csa_h_nx97), .S0 (
             adder_adder_csa_h_nx89)) ;
    nor02_2x adder_adder_csa_h_ix122 (.Y (adder_adder_csa_h_nx121), .A0 (
             adder_b_source_13), .A1 (A[13])) ;
    mux21 adder_adder_csa_h_ix103 (.Y (adder_adder_b1s1_7), .A0 (
          adder_adder_csa_h_nx125), .A1 (adder_adder_csa_h_nx135), .S0 (
          adder_adder_csa_h_nx147)) ;
    mux21_ni adder_adder_csa_h_ix126 (.Y (adder_adder_csa_h_nx125), .A0 (
             adder_adder_csa_h_nx127), .A1 (adder_adder_csa_h_nx133), .S0 (
             adder_adder_csa_h_nx119)) ;
    xnor2 adder_adder_csa_h_ix128 (.Y (adder_adder_csa_h_nx127), .A0 (
          adder_adder_csa_h_nx129), .A1 (adder_adder_csa_h_nx131)) ;
    xnor2 adder_adder_csa_h_ix130 (.Y (adder_adder_csa_h_nx129), .A0 (A[15]), .A1 (
          adder_b_sign)) ;
    nor02_2x adder_adder_csa_h_ix132 (.Y (adder_adder_csa_h_nx131), .A0 (
             adder_b_source_14), .A1 (A[14])) ;
    xnor2 adder_adder_csa_h_ix134 (.Y (adder_adder_csa_h_nx133), .A0 (
          adder_adder_csa_h_nx129), .A1 (adder_adder_csa_h_nx109)) ;
    mux21_ni adder_adder_csa_h_ix136 (.Y (adder_adder_csa_h_nx135), .A0 (
             adder_adder_csa_h_nx133), .A1 (adder_adder_csa_h_nx127), .S0 (
             adder_adder_csa_h_nx151)) ;
    xnor2 adder_adder_csa_h_ix105 (.Y (adder_adder_b1s0_4), .A0 (
          adder_adder_csa_h_nx149), .A1 (adder_adder_csa_h_nx87)) ;
    mux21 adder_adder_csa_h_ix113 (.Y (adder_adder_b1s0_5), .A0 (
          adder_adder_csa_h_nx93), .A1 (adder_adder_csa_h_nx99), .S0 (
          adder_adder_csa_h_nx149)) ;
    ao21 adder_adder_csa_h_ix121 (.Y (adder_adder_b1s0_6), .A0 (
         adder_adder_csa_h_nx149), .A1 (adder_adder_csa_h_nx66), .B0 (
         adder_adder_csa_h_nx116)) ;
    nor02_2x adder_adder_csa_h_ix117 (.Y (adder_adder_csa_h_nx116), .A0 (
             adder_adder_csa_h_nx149), .A1 (adder_adder_csa_h_nx117)) ;
    mux21 adder_adder_csa_h_ix129 (.Y (adder_adder_b1s0_7), .A0 (
          adder_adder_csa_h_nx125), .A1 (adder_adder_csa_h_nx135), .S0 (
          adder_adder_csa_h_nx149)) ;
    buf02 adder_adder_csa_h_ix146 (.Y (adder_adder_csa_h_nx147), .A (
          adder_adder_csa_h_b0c1)) ;
    buf02 adder_adder_csa_h_ix148 (.Y (adder_adder_csa_h_nx149), .A (
          adder_adder_csa_h_b0c0)) ;
    buf02 adder_adder_csa_h_ix150 (.Y (adder_adder_csa_h_nx151), .A (
          adder_adder_csa_h_nx64)) ;
    oai21 adder_adder_csa_h_csa_l_ix187 (.Y (adder_adder_b1s1_0), .A0 (A[8]), .A1 (
          adder_b_source_8), .B0 (adder_adder_csa_h_csa_l_nx188)) ;
    nand02_2x adder_adder_csa_h_csa_l_ix189 (.Y (adder_adder_csa_h_csa_l_nx188)
              , .A0 (adder_b_source_8), .A1 (A[8])) ;
    xor2 adder_adder_csa_h_csa_l_ix21 (.Y (adder_adder_b1s1_1), .A0 (
         adder_adder_csa_h_csa_l_nx191), .A1 (adder_adder_csa_h_csa_l_nx195)) ;
    oai21 adder_adder_csa_h_csa_l_ix192 (.Y (adder_adder_csa_h_csa_l_nx191), .A0 (
          A[9]), .A1 (adder_b_source_9), .B0 (adder_adder_csa_h_csa_l_nx193)) ;
    nand02_2x adder_adder_csa_h_csa_l_ix194 (.Y (adder_adder_csa_h_csa_l_nx193)
              , .A0 (adder_b_source_9), .A1 (A[9])) ;
    nor02_2x adder_adder_csa_h_csa_l_ix196 (.Y (adder_adder_csa_h_csa_l_nx195), 
             .A0 (adder_b_source_8), .A1 (A[8])) ;
    xnor2 adder_adder_csa_h_csa_l_ix43 (.Y (adder_adder_b1s1_2), .A0 (
          adder_adder_csa_h_csa_l_nx198), .A1 (adder_adder_csa_h_csa_l_nx238)) ;
    oai21 adder_adder_csa_h_csa_l_ix199 (.Y (adder_adder_csa_h_csa_l_nx198), .A0 (
          A[10]), .A1 (adder_b_source_10), .B0 (adder_adder_csa_h_csa_l_nx200)
          ) ;
    nand02_2x adder_adder_csa_h_csa_l_ix201 (.Y (adder_adder_csa_h_csa_l_nx200)
              , .A0 (adder_b_source_10), .A1 (A[10])) ;
    oai32 adder_adder_csa_h_csa_l_ix41 (.Y (adder_adder_csa_h_csa_l_nx40), .A0 (
          adder_b_source_8), .A1 (A[8]), .A2 (adder_adder_csa_h_csa_l_nx193), .B0 (
          adder_adder_csa_h_csa_l_nx195), .B1 (adder_adder_csa_h_csa_l_nx203)) ;
    nor02_2x adder_adder_csa_h_csa_l_ix204 (.Y (adder_adder_csa_h_csa_l_nx203), 
             .A0 (adder_b_source_9), .A1 (A[9])) ;
    mux21 adder_adder_csa_h_csa_l_ix65 (.Y (adder_adder_b1s1_3), .A0 (
          adder_adder_csa_h_csa_l_nx206), .A1 (adder_adder_csa_h_csa_l_nx212), .S0 (
          adder_adder_csa_h_csa_l_nx238)) ;
    xnor2 adder_adder_csa_h_csa_l_ix207 (.Y (adder_adder_csa_h_csa_l_nx206), .A0 (
          adder_adder_csa_h_csa_l_nx208), .A1 (adder_adder_csa_h_csa_l_nx200)) ;
    oai21 adder_adder_csa_h_csa_l_ix209 (.Y (adder_adder_csa_h_csa_l_nx208), .A0 (
          A[11]), .A1 (adder_b_source_11), .B0 (adder_adder_csa_h_csa_l_nx210)
          ) ;
    nand02_2x adder_adder_csa_h_csa_l_ix211 (.Y (adder_adder_csa_h_csa_l_nx210)
              , .A0 (adder_b_source_11), .A1 (A[11])) ;
    xnor2 adder_adder_csa_h_csa_l_ix213 (.Y (adder_adder_csa_h_csa_l_nx212), .A0 (
          adder_adder_csa_h_csa_l_nx208), .A1 (adder_adder_csa_h_csa_l_nx214)) ;
    nor02_2x adder_adder_csa_h_csa_l_ix215 (.Y (adder_adder_csa_h_csa_l_nx214), 
             .A0 (adder_b_source_10), .A1 (A[10])) ;
    nor02_2x adder_adder_csa_h_csa_l_ix221 (.Y (adder_adder_csa_h_csa_l_nx220), 
             .A0 (adder_b_source_9), .A1 (A[9])) ;
    mux21_ni adder_adder_csa_h_csa_l_ix224 (.Y (adder_adder_csa_h_csa_l_nx223), 
             .A0 (adder_adder_csa_h_csa_l_nx220), .A1 (
             adder_adder_csa_h_csa_l_nx193), .S0 (adder_adder_csa_h_csa_l_nx188)
             ) ;
    mux21_ni adder_adder_csa_h_csa_l_ix93 (.Y (adder_adder_csa_h_b0c1), .A0 (
             adder_adder_csa_h_csa_l_nx74), .A1 (adder_adder_csa_h_csa_l_nx88), 
             .S0 (adder_adder_csa_h_csa_l_nx238)) ;
    mux21 adder_adder_csa_h_csa_l_ix75 (.Y (adder_adder_csa_h_csa_l_nx74), .A0 (
          adder_adder_csa_h_csa_l_nx227), .A1 (adder_adder_csa_h_csa_l_nx210), .S0 (
          adder_adder_csa_h_csa_l_nx200)) ;
    nor02_2x adder_adder_csa_h_csa_l_ix228 (.Y (adder_adder_csa_h_csa_l_nx227), 
             .A0 (adder_b_source_11), .A1 (A[11])) ;
    oai32 adder_adder_csa_h_csa_l_ix89 (.Y (adder_adder_csa_h_csa_l_nx88), .A0 (
          adder_b_source_10), .A1 (A[10]), .A2 (adder_adder_csa_h_csa_l_nx210), 
          .B0 (adder_adder_csa_h_csa_l_nx214), .B1 (
          adder_adder_csa_h_csa_l_nx230)) ;
    nor02_2x adder_adder_csa_h_csa_l_ix231 (.Y (adder_adder_csa_h_csa_l_nx230), 
             .A0 (adder_b_source_11), .A1 (A[11])) ;
    inv02 adder_adder_csa_h_csa_l_ix7 (.Y (adder_adder_b1s0_0), .A (
          adder_adder_b1s1_0)) ;
    buf02 adder_adder_csa_h_csa_l_ix237 (.Y (adder_adder_csa_h_csa_l_nx238), .A (
          adder_adder_csa_h_csa_l_nx40)) ;
    xor2 adder_adder_csa_h_csa_l_ix23 (.Y (adder_adder_b1s0_1), .A0 (
         adder_adder_csa_h_csa_l_nx191), .A1 (adder_adder_csa_h_csa_l_nx188)) ;
    xor2 adder_adder_csa_h_csa_l_ix105 (.Y (adder_adder_b1s0_2), .A0 (
         adder_adder_csa_h_csa_l_nx198), .A1 (nx597)) ;
    xnor2 adder_adder_csa_l_csa_l_ix162 (.Y (adder_adder_csa_l_csa_l_nx161), .A0 (
          A[0]), .A1 (adder_b_source_0)) ;
    xor2 adder_adder_csa_l_csa_l_ix15 (.Y (add_out_1), .A0 (
         adder_adder_csa_l_csa_l_nx164), .A1 (adder_adder_csa_l_csa_l_nx166)) ;
    xnor2 adder_adder_csa_l_csa_l_ix165 (.Y (adder_adder_csa_l_csa_l_nx164), .A0 (
          A[1]), .A1 (adder_b_source_1)) ;
    aoi22 adder_adder_csa_l_csa_l_ix167 (.Y (adder_adder_csa_l_csa_l_nx166), .A0 (
          A[0]), .A1 (adder_b_source_0), .B0 (adder_cin), .B1 (
          adder_adder_csa_l_csa_l_nx0)) ;
    xnor2 adder_adder_csa_l_csa_l_ix33 (.Y (add_out_2), .A0 (
          adder_adder_csa_l_csa_l_nx170), .A1 (adder_adder_csa_l_csa_l_nx30)) ;
    oai21 adder_adder_csa_l_csa_l_ix171 (.Y (adder_adder_csa_l_csa_l_nx170), .A0 (
          A[2]), .A1 (adder_b_source_2), .B0 (adder_adder_csa_l_csa_l_nx172)) ;
    nand02_2x adder_adder_csa_l_csa_l_ix173 (.Y (adder_adder_csa_l_csa_l_nx172)
              , .A0 (adder_b_source_2), .A1 (A[2])) ;
    ao21 adder_adder_csa_l_csa_l_ix31 (.Y (adder_adder_csa_l_csa_l_nx30), .A0 (
         A[1]), .A1 (adder_b_source_1), .B0 (adder_adder_csa_l_csa_l_nx24)) ;
    nor02_2x adder_adder_csa_l_csa_l_ix25 (.Y (adder_adder_csa_l_csa_l_nx24), .A0 (
             adder_adder_csa_l_csa_l_nx164), .A1 (adder_adder_csa_l_csa_l_nx166)
             ) ;
    mux21 adder_adder_csa_l_csa_l_ix49 (.Y (add_out_3), .A0 (
          adder_adder_csa_l_csa_l_nx177), .A1 (adder_adder_csa_l_csa_l_nx181), .S0 (
          adder_adder_csa_l_csa_l_nx30)) ;
    xnor2 adder_adder_csa_l_csa_l_ix178 (.Y (adder_adder_csa_l_csa_l_nx177), .A0 (
          adder_adder_csa_l_csa_l_nx179), .A1 (adder_adder_csa_l_csa_l_nx172)) ;
    xnor2 adder_adder_csa_l_csa_l_ix180 (.Y (adder_adder_csa_l_csa_l_nx179), .A0 (
          adder_b_source_3), .A1 (A[3])) ;
    xnor2 adder_adder_csa_l_csa_l_ix182 (.Y (adder_adder_csa_l_csa_l_nx181), .A0 (
          adder_adder_csa_l_csa_l_nx179), .A1 (adder_adder_csa_l_csa_l_nx183)) ;
    nor02_2x adder_adder_csa_l_csa_l_ix184 (.Y (adder_adder_csa_l_csa_l_nx183), 
             .A0 (adder_b_source_2), .A1 (A[2])) ;
    ao21 adder_adder_csa_l_csa_l_ix63 (.Y (adder_adder_csa_l_b0c), .A0 (
         adder_b_source_3), .A1 (A[3]), .B0 (adder_adder_csa_l_csa_l_nx58)) ;
    nor02_2x adder_adder_csa_l_csa_l_ix59 (.Y (adder_adder_csa_l_csa_l_nx58), .A0 (
             adder_adder_csa_l_csa_l_nx179), .A1 (adder_adder_csa_l_csa_l_nx187)
             ) ;
    mux21_ni adder_adder_csa_l_csa_l_ix188 (.Y (adder_adder_csa_l_csa_l_nx187), 
             .A0 (adder_adder_csa_l_csa_l_nx172), .A1 (
             adder_adder_csa_l_csa_l_nx183), .S0 (adder_adder_csa_l_csa_l_nx30)
             ) ;
    inv02 adder_adder_csa_l_csa_l_ix1 (.Y (adder_adder_csa_l_csa_l_nx0), .A (
          adder_adder_csa_l_csa_l_nx161)) ;
    oai21 adder_adder_csa_l_csa_h_ix187 (.Y (adder_adder_csa_l_b1s1_0), .A0 (
          A[4]), .A1 (adder_b_source_4), .B0 (adder_adder_csa_l_csa_h_nx188)) ;
    nand02_2x adder_adder_csa_l_csa_h_ix189 (.Y (adder_adder_csa_l_csa_h_nx188)
              , .A0 (adder_b_source_4), .A1 (A[4])) ;
    xor2 adder_adder_csa_l_csa_h_ix21 (.Y (adder_adder_csa_l_b1s1_1), .A0 (
         adder_adder_csa_l_csa_h_nx191), .A1 (adder_adder_csa_l_csa_h_nx195)) ;
    oai21 adder_adder_csa_l_csa_h_ix192 (.Y (adder_adder_csa_l_csa_h_nx191), .A0 (
          A[5]), .A1 (adder_b_source_5), .B0 (adder_adder_csa_l_csa_h_nx193)) ;
    nand02_2x adder_adder_csa_l_csa_h_ix194 (.Y (adder_adder_csa_l_csa_h_nx193)
              , .A0 (adder_b_source_5), .A1 (A[5])) ;
    nor02_2x adder_adder_csa_l_csa_h_ix196 (.Y (adder_adder_csa_l_csa_h_nx195), 
             .A0 (adder_b_source_4), .A1 (A[4])) ;
    xnor2 adder_adder_csa_l_csa_h_ix43 (.Y (adder_adder_csa_l_b1s1_2), .A0 (
          adder_adder_csa_l_csa_h_nx198), .A1 (adder_adder_csa_l_csa_h_nx238)) ;
    oai21 adder_adder_csa_l_csa_h_ix199 (.Y (adder_adder_csa_l_csa_h_nx198), .A0 (
          A[6]), .A1 (adder_b_source_6), .B0 (adder_adder_csa_l_csa_h_nx200)) ;
    nand02_2x adder_adder_csa_l_csa_h_ix201 (.Y (adder_adder_csa_l_csa_h_nx200)
              , .A0 (adder_b_source_6), .A1 (A[6])) ;
    oai32 adder_adder_csa_l_csa_h_ix41 (.Y (adder_adder_csa_l_csa_h_nx40), .A0 (
          adder_b_source_4), .A1 (A[4]), .A2 (adder_adder_csa_l_csa_h_nx193), .B0 (
          adder_adder_csa_l_csa_h_nx195), .B1 (adder_adder_csa_l_csa_h_nx203)) ;
    nor02_2x adder_adder_csa_l_csa_h_ix204 (.Y (adder_adder_csa_l_csa_h_nx203), 
             .A0 (adder_b_source_5), .A1 (A[5])) ;
    mux21 adder_adder_csa_l_csa_h_ix65 (.Y (adder_adder_csa_l_b1s1_3), .A0 (
          adder_adder_csa_l_csa_h_nx206), .A1 (adder_adder_csa_l_csa_h_nx212), .S0 (
          adder_adder_csa_l_csa_h_nx238)) ;
    xnor2 adder_adder_csa_l_csa_h_ix207 (.Y (adder_adder_csa_l_csa_h_nx206), .A0 (
          adder_adder_csa_l_csa_h_nx208), .A1 (adder_adder_csa_l_csa_h_nx200)) ;
    oai21 adder_adder_csa_l_csa_h_ix209 (.Y (adder_adder_csa_l_csa_h_nx208), .A0 (
          A[7]), .A1 (adder_b_source_7), .B0 (adder_adder_csa_l_csa_h_nx210)) ;
    nand02_2x adder_adder_csa_l_csa_h_ix211 (.Y (adder_adder_csa_l_csa_h_nx210)
              , .A0 (adder_b_source_7), .A1 (A[7])) ;
    xnor2 adder_adder_csa_l_csa_h_ix213 (.Y (adder_adder_csa_l_csa_h_nx212), .A0 (
          adder_adder_csa_l_csa_h_nx208), .A1 (adder_adder_csa_l_csa_h_nx214)) ;
    nor02_2x adder_adder_csa_l_csa_h_ix215 (.Y (adder_adder_csa_l_csa_h_nx214), 
             .A0 (adder_b_source_6), .A1 (A[6])) ;
    nor02_2x adder_adder_csa_l_csa_h_ix221 (.Y (adder_adder_csa_l_csa_h_nx220), 
             .A0 (adder_b_source_5), .A1 (A[5])) ;
    mux21_ni adder_adder_csa_l_csa_h_ix224 (.Y (adder_adder_csa_l_csa_h_nx223), 
             .A0 (adder_adder_csa_l_csa_h_nx220), .A1 (
             adder_adder_csa_l_csa_h_nx193), .S0 (adder_adder_csa_l_csa_h_nx188)
             ) ;
    mux21_ni adder_adder_csa_l_csa_h_ix93 (.Y (adder_adder_csa_l_b1c1), .A0 (
             adder_adder_csa_l_csa_h_nx74), .A1 (adder_adder_csa_l_csa_h_nx88), 
             .S0 (adder_adder_csa_l_csa_h_nx238)) ;
    mux21 adder_adder_csa_l_csa_h_ix75 (.Y (adder_adder_csa_l_csa_h_nx74), .A0 (
          adder_adder_csa_l_csa_h_nx227), .A1 (adder_adder_csa_l_csa_h_nx210), .S0 (
          adder_adder_csa_l_csa_h_nx200)) ;
    nor02_2x adder_adder_csa_l_csa_h_ix228 (.Y (adder_adder_csa_l_csa_h_nx227), 
             .A0 (adder_b_source_7), .A1 (A[7])) ;
    oai32 adder_adder_csa_l_csa_h_ix89 (.Y (adder_adder_csa_l_csa_h_nx88), .A0 (
          adder_b_source_6), .A1 (A[6]), .A2 (adder_adder_csa_l_csa_h_nx210), .B0 (
          adder_adder_csa_l_csa_h_nx214), .B1 (adder_adder_csa_l_csa_h_nx230)) ;
    nor02_2x adder_adder_csa_l_csa_h_ix231 (.Y (adder_adder_csa_l_csa_h_nx230), 
             .A0 (adder_b_source_7), .A1 (A[7])) ;
    inv02 adder_adder_csa_l_csa_h_ix7 (.Y (adder_adder_csa_l_b1s0_0), .A (
          adder_adder_csa_l_b1s1_0)) ;
    buf02 adder_adder_csa_l_csa_h_ix237 (.Y (adder_adder_csa_l_csa_h_nx238), .A (
          adder_adder_csa_l_csa_h_nx40)) ;
    xor2 adder_adder_csa_l_csa_h_ix23 (.Y (adder_adder_csa_l_b1s0_1), .A0 (
         adder_adder_csa_l_csa_h_nx191), .A1 (adder_adder_csa_l_csa_h_nx188)) ;
    xor2 adder_adder_csa_l_csa_h_ix105 (.Y (adder_adder_csa_l_b1s0_2), .A0 (
         adder_adder_csa_l_csa_h_nx198), .A1 (nx599)) ;
    ao21 shift_ix297 (.Y (shift_out_0), .A0 (shift_nx357), .A1 (shift_nx42), .B0 (
         shift_nx294)) ;
    inv02 shift_ix152 (.Y (shift_nx151), .A (alu_code[0])) ;
    ao21 shift_ix43 (.Y (shift_nx42), .A0 (shift_nx361), .A1 (shift_nx36), .B0 (
         shift_nx369)) ;
    inv02 shift_ix156 (.Y (shift_nx155), .A (B[3])) ;
    ao21 shift_ix37 (.Y (shift_nx36), .A0 (shift_nx159), .A1 (shift_nx30), .B0 (
         shift_nx373)) ;
    inv02 shift_ix160 (.Y (shift_nx159), .A (B[2])) ;
    mux21_ni shift_ix31 (.Y (shift_nx30), .A0 (shift_nx22), .A1 (shift_nx2), .S0 (
             B[1])) ;
    mux21_ni shift_ix23 (.Y (shift_nx22), .A0 (shift_nx14), .A1 (shift_nx2), .S0 (
             B[0])) ;
    mux21_ni shift_ix15 (.Y (shift_nx14), .A0 (A[0]), .A1 (A[15]), .S0 (
             alu_code[0])) ;
    nand03 shift_ix172 (.Y (shift_nx171), .A0 (alu_code[0]), .A1 (A[15]), .A2 (
           alu_code[1])) ;
    aoi221 shift_ix178 (.Y (shift_nx177), .A0 (shift_nx168), .A1 (shift_nx353), 
           .B0 (B[3]), .B1 (shift_nx286), .C0 (shift_nx112)) ;
    mux21_ni shift_ix169 (.Y (shift_nx168), .A0 (shift_nx136), .A1 (shift_nx164)
             , .S0 (B[1])) ;
    mux21_ni shift_ix137 (.Y (shift_nx136), .A0 (shift_nx120), .A1 (shift_nx132)
             , .S0 (B[0])) ;
    mux21_ni shift_ix121 (.Y (shift_nx120), .A0 (A[11]), .A1 (A[4]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix133 (.Y (shift_nx132), .A0 (A[10]), .A1 (A[5]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix165 (.Y (shift_nx164), .A0 (shift_nx148), .A1 (shift_nx160)
             , .S0 (B[0])) ;
    mux21_ni shift_ix149 (.Y (shift_nx148), .A0 (A[9]), .A1 (A[6]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix161 (.Y (shift_nx160), .A0 (A[8]), .A1 (A[7]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix287 (.Y (shift_nx286), .A0 (shift_nx230), .A1 (shift_nx282)
             , .S0 (B[2])) ;
    mux21_ni shift_ix231 (.Y (shift_nx230), .A0 (shift_nx198), .A1 (shift_nx226)
             , .S0 (B[1])) ;
    mux21_ni shift_ix199 (.Y (shift_nx198), .A0 (shift_nx182), .A1 (shift_nx194)
             , .S0 (B[0])) ;
    mux21_ni shift_ix183 (.Y (shift_nx182), .A0 (A[7]), .A1 (A[8]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix195 (.Y (shift_nx194), .A0 (A[6]), .A1 (A[9]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix227 (.Y (shift_nx226), .A0 (shift_nx210), .A1 (shift_nx222)
             , .S0 (B[0])) ;
    mux21_ni shift_ix211 (.Y (shift_nx210), .A0 (A[5]), .A1 (A[10]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix223 (.Y (shift_nx222), .A0 (A[4]), .A1 (A[11]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix283 (.Y (shift_nx282), .A0 (shift_nx258), .A1 (shift_nx278)
             , .S0 (B[1])) ;
    mux21_ni shift_ix259 (.Y (shift_nx258), .A0 (shift_nx242), .A1 (shift_nx254)
             , .S0 (B[0])) ;
    mux21_ni shift_ix243 (.Y (shift_nx242), .A0 (A[3]), .A1 (A[12]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix255 (.Y (shift_nx254), .A0 (A[2]), .A1 (A[13]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix279 (.Y (shift_nx278), .A0 (shift_nx270), .A1 (shift_nx14)
             , .S0 (B[0])) ;
    mux21_ni shift_ix271 (.Y (shift_nx270), .A0 (A[1]), .A1 (A[14]), .S0 (
             alu_code[0])) ;
    ao32 shift_ix113 (.Y (shift_nx112), .A0 (shift_nx106), .A1 (B[1]), .A2 (
         shift_nx348), .B0 (shift_nx56), .B1 (shift_nx80)) ;
    mux21_ni shift_ix107 (.Y (shift_nx106), .A0 (shift_nx90), .A1 (shift_nx102)
             , .S0 (B[0])) ;
    mux21_ni shift_ix91 (.Y (shift_nx90), .A0 (A[13]), .A1 (A[2]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix103 (.Y (shift_nx102), .A0 (A[12]), .A1 (A[3]), .S0 (
             alu_code[0])) ;
    nor02_2x shift_ix53 (.Y (shift_nx52), .A0 (B[3]), .A1 (B[2])) ;
    nor03_2x shift_ix57 (.Y (shift_nx56), .A0 (B[1]), .A1 (B[3]), .A2 (B[2])) ;
    mux21_ni shift_ix81 (.Y (shift_nx80), .A0 (shift_nx64), .A1 (shift_nx76), .S0 (
             B[0])) ;
    mux21_ni shift_ix65 (.Y (shift_nx64), .A0 (A[15]), .A1 (A[0]), .S0 (
             alu_code[0])) ;
    mux21_ni shift_ix77 (.Y (shift_nx76), .A0 (A[14]), .A1 (A[1]), .S0 (
             alu_code[0])) ;
    ao21 shift_ix427 (.Y (shift_out_1), .A0 (shift_nx357), .A1 (shift_nx316), .B0 (
         shift_nx424)) ;
    ao21 shift_ix317 (.Y (shift_nx316), .A0 (shift_nx361), .A1 (shift_nx310), .B0 (
         shift_nx369)) ;
    ao21 shift_ix311 (.Y (shift_nx310), .A0 (shift_nx159), .A1 (shift_nx304), .B0 (
         shift_nx373)) ;
    mux21_ni shift_ix305 (.Y (shift_nx304), .A0 (shift_nx278), .A1 (shift_nx2), 
             .S0 (B[1])) ;
    aoi221 shift_ix238 (.Y (shift_nx237), .A0 (shift_nx366), .A1 (shift_nx353), 
           .B0 (B[3]), .B1 (shift_nx416), .C0 (shift_nx342)) ;
    mux21_ni shift_ix367 (.Y (shift_nx366), .A0 (shift_nx350), .A1 (shift_nx362)
             , .S0 (B[1])) ;
    mux21_ni shift_ix351 (.Y (shift_nx350), .A0 (shift_nx132), .A1 (shift_nx148)
             , .S0 (B[0])) ;
    mux21_ni shift_ix363 (.Y (shift_nx362), .A0 (shift_nx160), .A1 (shift_nx182)
             , .S0 (B[0])) ;
    mux21_ni shift_ix417 (.Y (shift_nx416), .A0 (shift_nx392), .A1 (shift_nx412)
             , .S0 (B[2])) ;
    mux21_ni shift_ix393 (.Y (shift_nx392), .A0 (shift_nx376), .A1 (shift_nx388)
             , .S0 (B[1])) ;
    mux21_ni shift_ix377 (.Y (shift_nx376), .A0 (shift_nx194), .A1 (shift_nx210)
             , .S0 (B[0])) ;
    mux21_ni shift_ix389 (.Y (shift_nx388), .A0 (shift_nx222), .A1 (shift_nx242)
             , .S0 (B[0])) ;
    mux21_ni shift_ix413 (.Y (shift_nx412), .A0 (shift_nx404), .A1 (shift_nx22)
             , .S0 (B[1])) ;
    mux21_ni shift_ix405 (.Y (shift_nx404), .A0 (shift_nx254), .A1 (shift_nx270)
             , .S0 (B[0])) ;
    ao32 shift_ix343 (.Y (shift_nx342), .A0 (shift_nx338), .A1 (B[1]), .A2 (
         shift_nx348), .B0 (shift_nx56), .B1 (shift_nx328)) ;
    mux21_ni shift_ix339 (.Y (shift_nx338), .A0 (shift_nx102), .A1 (shift_nx120)
             , .S0 (B[0])) ;
    mux21_ni shift_ix329 (.Y (shift_nx328), .A0 (shift_nx76), .A1 (shift_nx90), 
             .S0 (B[0])) ;
    ao21 shift_ix485 (.Y (shift_out_2), .A0 (shift_nx357), .A1 (shift_nx438), .B0 (
         shift_nx482)) ;
    ao21 shift_ix439 (.Y (shift_nx438), .A0 (shift_nx361), .A1 (shift_nx432), .B0 (
         shift_nx369)) ;
    ao21 shift_ix433 (.Y (shift_nx432), .A0 (shift_nx159), .A1 (shift_nx412), .B0 (
         shift_nx373)) ;
    aoi221 shift_ix266 (.Y (shift_nx265), .A0 (shift_nx456), .A1 (shift_nx353), 
           .B0 (B[3]), .B1 (shift_nx474), .C0 (shift_nx448)) ;
    mux21_ni shift_ix457 (.Y (shift_nx456), .A0 (shift_nx164), .A1 (shift_nx198)
             , .S0 (B[1])) ;
    mux21_ni shift_ix475 (.Y (shift_nx474), .A0 (shift_nx466), .A1 (shift_nx304)
             , .S0 (B[2])) ;
    mux21_ni shift_ix467 (.Y (shift_nx466), .A0 (shift_nx226), .A1 (shift_nx258)
             , .S0 (B[1])) ;
    ao32 shift_ix449 (.Y (shift_nx448), .A0 (shift_nx136), .A1 (B[1]), .A2 (
         shift_nx348), .B0 (shift_nx106), .B1 (shift_nx56)) ;
    ao21 shift_ix543 (.Y (shift_out_3), .A0 (shift_nx357), .A1 (shift_nx496), .B0 (
         shift_nx540)) ;
    ao21 shift_ix497 (.Y (shift_nx496), .A0 (shift_nx361), .A1 (shift_nx490), .B0 (
         shift_nx369)) ;
    ao21 shift_ix491 (.Y (shift_nx490), .A0 (shift_nx159), .A1 (shift_nx282), .B0 (
         shift_nx373)) ;
    aoi221 shift_ix282 (.Y (shift_nx281), .A0 (shift_nx514), .A1 (shift_nx353), 
           .B0 (B[3]), .B1 (shift_nx532), .C0 (shift_nx506)) ;
    mux21_ni shift_ix515 (.Y (shift_nx514), .A0 (shift_nx362), .A1 (shift_nx376)
             , .S0 (B[1])) ;
    mux21_ni shift_ix533 (.Y (shift_nx532), .A0 (shift_nx524), .A1 (shift_nx30)
             , .S0 (B[2])) ;
    mux21_ni shift_ix525 (.Y (shift_nx524), .A0 (shift_nx388), .A1 (shift_nx404)
             , .S0 (B[1])) ;
    ao32 shift_ix507 (.Y (shift_nx506), .A0 (shift_nx350), .A1 (B[1]), .A2 (
         shift_nx348), .B0 (shift_nx338), .B1 (shift_nx56)) ;
    ao21 shift_ix567 (.Y (shift_out_4), .A0 (shift_nx359), .A1 (shift_nx548), .B0 (
         shift_nx564)) ;
    ao21 shift_ix549 (.Y (shift_nx548), .A0 (shift_nx361), .A1 (shift_nx532), .B0 (
         shift_nx369)) ;
    aoi222 shift_ix298 (.Y (shift_nx297), .A0 (shift_nx168), .A1 (shift_nx348), 
           .B0 (shift_nx230), .B1 (shift_nx353), .C0 (B[3]), .C1 (shift_nx490)
           ) ;
    ao21 shift_ix591 (.Y (shift_out_5), .A0 (shift_nx359), .A1 (shift_nx572), .B0 (
         shift_nx588)) ;
    ao21 shift_ix573 (.Y (shift_nx572), .A0 (shift_nx361), .A1 (shift_nx474), .B0 (
         shift_nx369)) ;
    aoi222 shift_ix304 (.Y (shift_nx303), .A0 (shift_nx366), .A1 (shift_nx348), 
           .B0 (shift_nx392), .B1 (shift_nx353), .C0 (B[3]), .C1 (shift_nx432)
           ) ;
    ao21 shift_ix615 (.Y (shift_out_6), .A0 (shift_nx359), .A1 (shift_nx596), .B0 (
         shift_nx612)) ;
    ao21 shift_ix597 (.Y (shift_nx596), .A0 (shift_nx155), .A1 (shift_nx416), .B0 (
         shift_nx369)) ;
    aoi222 shift_ix310 (.Y (shift_nx309), .A0 (shift_nx456), .A1 (shift_nx348), 
           .B0 (shift_nx466), .B1 (shift_nx353), .C0 (B[3]), .C1 (shift_nx310)
           ) ;
    ao21 shift_ix639 (.Y (shift_out_7), .A0 (shift_nx151), .A1 (shift_nx620), .B0 (
         shift_nx636)) ;
    ao21 shift_ix621 (.Y (shift_nx620), .A0 (shift_nx155), .A1 (shift_nx286), .B0 (
         shift_nx371)) ;
    aoi222 shift_ix316 (.Y (shift_nx315), .A0 (shift_nx514), .A1 (shift_nx351), 
           .B0 (shift_nx524), .B1 (shift_nx355), .C0 (B[3]), .C1 (shift_nx36)) ;
    ao21 shift_ix647 (.Y (shift_out_8), .A0 (alu_code[0]), .A1 (shift_nx620), .B0 (
         shift_nx642)) ;
    nor02_2x shift_ix643 (.Y (shift_nx642), .A0 (alu_code[0]), .A1 (shift_nx315)
             ) ;
    ao21 shift_ix655 (.Y (shift_out_9), .A0 (alu_code[0]), .A1 (shift_nx596), .B0 (
         shift_nx650)) ;
    nor02_2x shift_ix651 (.Y (shift_nx650), .A0 (alu_code[0]), .A1 (shift_nx309)
             ) ;
    ao21 shift_ix663 (.Y (shift_out_10), .A0 (alu_code[0]), .A1 (shift_nx572), .B0 (
         shift_nx658)) ;
    nor02_2x shift_ix659 (.Y (shift_nx658), .A0 (alu_code[0]), .A1 (shift_nx303)
             ) ;
    ao21 shift_ix671 (.Y (shift_out_11), .A0 (alu_code[0]), .A1 (shift_nx548), .B0 (
         shift_nx666)) ;
    nor02_2x shift_ix667 (.Y (shift_nx666), .A0 (alu_code[0]), .A1 (shift_nx297)
             ) ;
    ao21 shift_ix679 (.Y (shift_out_12), .A0 (alu_code[0]), .A1 (shift_nx496), .B0 (
         shift_nx674)) ;
    nor02_2x shift_ix675 (.Y (shift_nx674), .A0 (alu_code[0]), .A1 (shift_nx281)
             ) ;
    ao21 shift_ix687 (.Y (shift_out_13), .A0 (alu_code[0]), .A1 (shift_nx438), .B0 (
         shift_nx682)) ;
    nor02_2x shift_ix683 (.Y (shift_nx682), .A0 (alu_code[0]), .A1 (shift_nx265)
             ) ;
    ao21 shift_ix695 (.Y (shift_out_14), .A0 (alu_code[0]), .A1 (shift_nx316), .B0 (
         shift_nx690)) ;
    nor02_2x shift_ix691 (.Y (shift_nx690), .A0 (alu_code[0]), .A1 (shift_nx237)
             ) ;
    ao21 shift_ix703 (.Y (shift_out_15), .A0 (alu_code[0]), .A1 (shift_nx42), .B0 (
         shift_nx698)) ;
    nor02_2x shift_ix699 (.Y (shift_nx698), .A0 (alu_code[0]), .A1 (shift_nx177)
             ) ;
    inv02 shift_ix3 (.Y (shift_nx2), .A (shift_nx171)) ;
    buf02 shift_ix347 (.Y (shift_nx348), .A (shift_nx52)) ;
    buf02 shift_ix349 (.Y (shift_nx351), .A (shift_nx52)) ;
    buf02 shift_ix352 (.Y (shift_nx353), .A (shift_nx172)) ;
    buf02 shift_ix354 (.Y (shift_nx355), .A (shift_nx172)) ;
    inv02 shift_ix356 (.Y (shift_nx357), .A (alu_code[0])) ;
    inv02 shift_ix358 (.Y (shift_nx359), .A (alu_code[0])) ;
    inv02 shift_ix360 (.Y (shift_nx361), .A (B[3])) ;
    nor02ii shift_ix7 (.Y (shift_nx6), .A0 (shift_nx171), .A1 (B[2])) ;
    nor02ii shift_ix5 (.Y (shift_nx4), .A0 (shift_nx171), .A1 (B[3])) ;
    nor02ii shift_ix295 (.Y (shift_nx294), .A0 (shift_nx177), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix173 (.Y (shift_nx172), .A0 (B[3]), .A1 (B[2])) ;
    nor02ii shift_ix425 (.Y (shift_nx424), .A0 (shift_nx237), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix483 (.Y (shift_nx482), .A0 (shift_nx265), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix541 (.Y (shift_nx540), .A0 (shift_nx281), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix565 (.Y (shift_nx564), .A0 (shift_nx297), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix589 (.Y (shift_nx588), .A0 (shift_nx303), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix613 (.Y (shift_nx612), .A0 (shift_nx309), .A1 (alu_code[0])
            ) ;
    nor02ii shift_ix637 (.Y (shift_nx636), .A0 (shift_nx315), .A1 (alu_code[0])
            ) ;
    buf02 shift_ix368 (.Y (shift_nx369), .A (shift_nx4)) ;
    buf02 shift_ix370 (.Y (shift_nx371), .A (shift_nx4)) ;
    buf02 shift_ix372 (.Y (shift_nx373), .A (shift_nx6)) ;
    oai221 logic_ix37 (.Y (logic_out_0), .A0 (logic_nx631), .A1 (logic_nx734), .B0 (
           A[0]), .B1 (logic_nx742), .C0 (logic_nx641)) ;
    xnor2 logic_ix632 (.Y (logic_nx631), .A0 (A[0]), .A1 (B[0])) ;
    or02 logic_ix634 (.Y (logic_nx633), .A0 (alu_code[2]), .A1 (logic_nx635)) ;
    xnor2 logic_ix636 (.Y (logic_nx635), .A0 (alu_code[1]), .A1 (alu_code[0])) ;
    inv02 logic_ix640 (.Y (logic_nx639), .A (alu_code[2])) ;
    nand03 logic_ix642 (.Y (logic_nx641), .A0 (logic_nx726), .A1 (A[0]), .A2 (
           B[0])) ;
    nor02_2x logic_ix17 (.Y (logic_nx16), .A0 (alu_code[2]), .A1 (alu_code[1])
             ) ;
    oai221 logic_ix55 (.Y (logic_out_1), .A0 (logic_nx645), .A1 (logic_nx734), .B0 (
           A[1]), .B1 (logic_nx742), .C0 (logic_nx647)) ;
    xnor2 logic_ix646 (.Y (logic_nx645), .A0 (A[1]), .A1 (B[1])) ;
    nand03 logic_ix648 (.Y (logic_nx647), .A0 (logic_nx726), .A1 (A[1]), .A2 (
           B[1])) ;
    oai221 logic_ix73 (.Y (logic_out_2), .A0 (logic_nx650), .A1 (logic_nx734), .B0 (
           A[2]), .B1 (logic_nx742), .C0 (logic_nx652)) ;
    xnor2 logic_ix651 (.Y (logic_nx650), .A0 (A[2]), .A1 (B[2])) ;
    nand03 logic_ix653 (.Y (logic_nx652), .A0 (logic_nx726), .A1 (A[2]), .A2 (
           B[2])) ;
    oai221 logic_ix91 (.Y (logic_out_3), .A0 (logic_nx655), .A1 (logic_nx734), .B0 (
           A[3]), .B1 (logic_nx742), .C0 (logic_nx657)) ;
    xnor2 logic_ix656 (.Y (logic_nx655), .A0 (A[3]), .A1 (B[3])) ;
    nand03 logic_ix658 (.Y (logic_nx657), .A0 (logic_nx726), .A1 (A[3]), .A2 (
           B[3])) ;
    oai221 logic_ix109 (.Y (logic_out_4), .A0 (logic_nx660), .A1 (logic_nx734), 
           .B0 (A[4]), .B1 (logic_nx742), .C0 (logic_nx662)) ;
    xnor2 logic_ix661 (.Y (logic_nx660), .A0 (A[4]), .A1 (B[4])) ;
    nand03 logic_ix663 (.Y (logic_nx662), .A0 (logic_nx726), .A1 (A[4]), .A2 (
           B[4])) ;
    oai221 logic_ix127 (.Y (logic_out_5), .A0 (logic_nx665), .A1 (logic_nx734), 
           .B0 (A[5]), .B1 (logic_nx742), .C0 (logic_nx667)) ;
    xnor2 logic_ix666 (.Y (logic_nx665), .A0 (A[5]), .A1 (B[5])) ;
    nand03 logic_ix668 (.Y (logic_nx667), .A0 (logic_nx726), .A1 (A[5]), .A2 (
           B[5])) ;
    oai221 logic_ix145 (.Y (logic_out_6), .A0 (logic_nx670), .A1 (logic_nx734), 
           .B0 (A[6]), .B1 (logic_nx742), .C0 (logic_nx672)) ;
    xnor2 logic_ix671 (.Y (logic_nx670), .A0 (A[6]), .A1 (B[6])) ;
    nand03 logic_ix673 (.Y (logic_nx672), .A0 (logic_nx726), .A1 (A[6]), .A2 (
           B[6])) ;
    oai221 logic_ix163 (.Y (logic_out_7), .A0 (logic_nx675), .A1 (logic_nx736), 
           .B0 (A[7]), .B1 (logic_nx744), .C0 (logic_nx677)) ;
    xnor2 logic_ix676 (.Y (logic_nx675), .A0 (A[7]), .A1 (B[7])) ;
    nand03 logic_ix678 (.Y (logic_nx677), .A0 (logic_nx728), .A1 (A[7]), .A2 (
           B[7])) ;
    oai221 logic_ix181 (.Y (logic_out_8), .A0 (logic_nx680), .A1 (logic_nx736), 
           .B0 (A[8]), .B1 (logic_nx744), .C0 (logic_nx682)) ;
    xnor2 logic_ix681 (.Y (logic_nx680), .A0 (A[8]), .A1 (B[8])) ;
    nand03 logic_ix683 (.Y (logic_nx682), .A0 (logic_nx728), .A1 (A[8]), .A2 (
           B[8])) ;
    oai221 logic_ix199 (.Y (logic_out_9), .A0 (logic_nx685), .A1 (logic_nx736), 
           .B0 (A[9]), .B1 (logic_nx744), .C0 (logic_nx687)) ;
    xnor2 logic_ix686 (.Y (logic_nx685), .A0 (A[9]), .A1 (B[9])) ;
    nand03 logic_ix688 (.Y (logic_nx687), .A0 (logic_nx728), .A1 (A[9]), .A2 (
           B[9])) ;
    oai221 logic_ix217 (.Y (logic_out_10), .A0 (logic_nx690), .A1 (logic_nx736)
           , .B0 (A[10]), .B1 (logic_nx744), .C0 (logic_nx692)) ;
    xnor2 logic_ix691 (.Y (logic_nx690), .A0 (A[10]), .A1 (B[10])) ;
    nand03 logic_ix693 (.Y (logic_nx692), .A0 (logic_nx728), .A1 (A[10]), .A2 (
           B[10])) ;
    oai221 logic_ix235 (.Y (logic_out_11), .A0 (logic_nx695), .A1 (logic_nx736)
           , .B0 (A[11]), .B1 (logic_nx744), .C0 (logic_nx697)) ;
    xnor2 logic_ix696 (.Y (logic_nx695), .A0 (A[11]), .A1 (B[11])) ;
    nand03 logic_ix698 (.Y (logic_nx697), .A0 (logic_nx728), .A1 (A[11]), .A2 (
           B[11])) ;
    oai221 logic_ix253 (.Y (logic_out_12), .A0 (logic_nx700), .A1 (logic_nx736)
           , .B0 (A[12]), .B1 (logic_nx744), .C0 (logic_nx702)) ;
    xnor2 logic_ix701 (.Y (logic_nx700), .A0 (A[12]), .A1 (B[12])) ;
    nand03 logic_ix703 (.Y (logic_nx702), .A0 (logic_nx728), .A1 (A[12]), .A2 (
           B[12])) ;
    oai221 logic_ix271 (.Y (logic_out_13), .A0 (logic_nx705), .A1 (logic_nx736)
           , .B0 (A[13]), .B1 (logic_nx744), .C0 (logic_nx707)) ;
    xnor2 logic_ix706 (.Y (logic_nx705), .A0 (A[13]), .A1 (B[13])) ;
    nand03 logic_ix708 (.Y (logic_nx707), .A0 (logic_nx728), .A1 (A[13]), .A2 (
           B[13])) ;
    oai221 logic_ix289 (.Y (logic_out_14), .A0 (logic_nx710), .A1 (logic_nx738)
           , .B0 (A[14]), .B1 (logic_nx746), .C0 (logic_nx712)) ;
    xnor2 logic_ix711 (.Y (logic_nx710), .A0 (A[14]), .A1 (B[14])) ;
    nand03 logic_ix713 (.Y (logic_nx712), .A0 (logic_nx730), .A1 (A[14]), .A2 (
           B[14])) ;
    oai221 logic_ix307 (.Y (logic_out_15), .A0 (logic_nx715), .A1 (logic_nx738)
           , .B0 (A[15]), .B1 (logic_nx746), .C0 (logic_nx717)) ;
    xnor2 logic_ix716 (.Y (logic_nx715), .A0 (A[15]), .A1 (B[15])) ;
    nand03 logic_ix718 (.Y (logic_nx717), .A0 (logic_nx730), .A1 (A[15]), .A2 (
           B[15])) ;
    inv02 logic_ix723 (.Y (logic_nx724), .A (logic_nx16)) ;
    inv02 logic_ix725 (.Y (logic_nx726), .A (logic_nx724)) ;
    inv02 logic_ix727 (.Y (logic_nx728), .A (logic_nx724)) ;
    inv02 logic_ix729 (.Y (logic_nx730), .A (logic_nx724)) ;
    inv02 logic_ix731 (.Y (logic_nx732), .A (logic_nx633)) ;
    inv02 logic_ix733 (.Y (logic_nx734), .A (logic_nx732)) ;
    inv02 logic_ix735 (.Y (logic_nx736), .A (logic_nx732)) ;
    inv02 logic_ix737 (.Y (logic_nx738), .A (logic_nx732)) ;
    inv02 logic_ix741 (.Y (logic_nx742), .A (logic_nx740)) ;
    inv02 logic_ix743 (.Y (logic_nx744), .A (logic_nx740)) ;
    inv02 logic_ix745 (.Y (logic_nx746), .A (logic_nx740)) ;
    nor03_2x logic_ix638 (.Y (logic_nx740), .A0 (alu_code[0]), .A1 (logic_nx639)
             , .A2 (alu_code[1])) ;
    and02 ix259 (.Y (overflow), .A0 (nx100), .A1 (add_vout)) ;
    xnor2 adder_ix107 (.Y (adder_b_source_0), .A0 (nx591), .A1 (adder_nx69)) ;
    nor02_2x adder_ix70 (.Y (adder_nx69), .A0 (B[0]), .A1 (adder_nx98)) ;
    xnor2 adder_ix113 (.Y (adder_b_source_1), .A0 (nx591), .A1 (adder_nx75)) ;
    xnor2 adder_ix119 (.Y (adder_b_source_2), .A0 (nx591), .A1 (adder_nx83)) ;
    xnor2 adder_ix125 (.Y (adder_b_source_3), .A0 (nx591), .A1 (adder_nx87)) ;
    xnor2 adder_ix131 (.Y (adder_b_source_4), .A0 (nx591), .A1 (adder_nx91)) ;
    xnor2 adder_ix137 (.Y (adder_b_source_5), .A0 (nx591), .A1 (adder_nx95)) ;
    xnor2 adder_ix143 (.Y (adder_b_source_6), .A0 (nx591), .A1 (adder_nx99)) ;
    xnor2 adder_ix149 (.Y (adder_b_source_7), .A0 (nx593), .A1 (adder_nx103)) ;
    xnor2 adder_ix155 (.Y (adder_b_source_8), .A0 (nx593), .A1 (adder_nx107)) ;
    xnor2 adder_ix161 (.Y (adder_b_source_9), .A0 (nx593), .A1 (adder_nx111)) ;
    xnor2 adder_ix167 (.Y (adder_b_source_10), .A0 (nx593), .A1 (adder_nx115)) ;
    xnor2 adder_ix173 (.Y (adder_b_source_11), .A0 (nx593), .A1 (adder_nx119)) ;
    xnor2 adder_ix179 (.Y (adder_b_source_12), .A0 (nx593), .A1 (adder_nx123)) ;
    xnor2 adder_ix185 (.Y (adder_b_source_13), .A0 (nx593), .A1 (adder_nx127)) ;
    xnor2 adder_ix191 (.Y (adder_b_source_14), .A0 (nx595), .A1 (adder_nx131)) ;
    xnor2 adder_ix201 (.Y (adder_b_sign), .A0 (nx595), .A1 (adder_nx135)) ;
    mux21_ni adder_ix9 (.Y (add_out_4), .A0 (adder_adder_csa_l_b1s0_0), .A1 (
             adder_adder_csa_l_b1s1_0), .S0 (adder_adder_csa_l_b0c)) ;
    mux21_ni adder_ix47 (.Y (add_out_8), .A0 (adder_adder_b1s0_0), .A1 (
             adder_adder_b1s1_0), .S0 (adder_nx179)) ;
    mux21 adder_adder_csa_h_csa_l_ix113 (.Y (adder_adder_b1s0_3), .A0 (
          adder_adder_csa_h_csa_l_nx212), .A1 (adder_adder_csa_h_csa_l_nx206), .S0 (
          nx597)) ;
    mux21_ni adder_adder_csa_h_csa_l_ix121 (.Y (adder_adder_csa_h_b0c0), .A0 (
             adder_adder_csa_h_csa_l_nx88), .A1 (adder_adder_csa_h_csa_l_nx74), 
             .S0 (nx597)) ;
    xor2 adder_adder_csa_l_csa_l_ix3 (.Y (add_out_0), .A0 (adder_nx197), .A1 (
         adder_adder_csa_l_csa_l_nx161)) ;
    mux21 adder_adder_csa_l_csa_h_ix113 (.Y (adder_adder_csa_l_b1s0_3), .A0 (
          adder_adder_csa_l_csa_h_nx212), .A1 (adder_adder_csa_l_csa_h_nx206), .S0 (
          nx599)) ;
    mux21_ni adder_adder_csa_l_csa_h_ix121 (.Y (adder_adder_csa_l_b1c0), .A0 (
             adder_adder_csa_l_csa_h_nx88), .A1 (adder_adder_csa_l_csa_h_nx74), 
             .S0 (nx599)) ;
    inv02 ix590 (.Y (nx591), .A (adder_nx197)) ;
    inv02 ix592 (.Y (nx593), .A (adder_nx197)) ;
    inv02 ix594 (.Y (nx595), .A (adder_nx197)) ;
    buf02 ix596 (.Y (nx597), .A (adder_adder_csa_h_csa_l_nx223)) ;
    buf02 ix598 (.Y (nx599), .A (adder_adder_csa_l_csa_h_nx223)) ;
endmodule


module and02 ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;




    and (Y, A0, A1) ;
endmodule


module oai221 ( Y, A0, A1, B0, B1, C0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;
    input B1 ;
    input C0 ;

    wire NOT_B0, NOT_B1, nx4, NOT_A0, NOT_A1, nx10, nx12, NOT_C0;



    assign NOT_B0 = ~B0 ;
    assign NOT_B1 = ~B1 ;
    and (nx4, NOT_B0, NOT_B1) ;
    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx10, NOT_A0, NOT_A1) ;
    or (nx12, nx4, nx10) ;
    assign NOT_C0 = ~C0 ;
    or (Y, nx12, NOT_C0) ;
endmodule


module aoi222 ( Y, A0, A1, B0, B1, C0, C1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;
    input B1 ;
    input C0 ;
    input C1 ;

    wire NOT_A1, NOT_B1, nx4, NOT_C1, nx8, NOT_A0, nx12, nx14, nx16, NOT_B0, 
         nx20, nx22, nx24, nx26, nx28, nx30, nx32, NOT_C0, nx36, nx38, nx40, 
         nx42, nx44, nx46, nx48, nx50, nx52, nx54;



    assign NOT_A1 = ~A1 ;
    assign NOT_B1 = ~B1 ;
    and (nx4, NOT_A1, NOT_B1) ;
    assign NOT_C1 = ~C1 ;
    and (nx8, nx4, NOT_C1) ;
    assign NOT_A0 = ~A0 ;
    and (nx12, NOT_A0, NOT_B1) ;
    and (nx14, nx12, NOT_C1) ;
    or (nx16, nx8, nx14) ;
    assign NOT_B0 = ~B0 ;
    and (nx20, NOT_A1, NOT_B0) ;
    and (nx22, nx20, NOT_C1) ;
    or (nx24, nx16, nx22) ;
    and (nx26, NOT_A0, NOT_B0) ;
    and (nx28, nx26, NOT_C1) ;
    or (nx30, nx24, nx28) ;
    and (nx32, NOT_A1, NOT_B1) ;
    assign NOT_C0 = ~C0 ;
    and (nx36, nx32, NOT_C0) ;
    or (nx38, nx30, nx36) ;
    and (nx40, NOT_A0, NOT_B1) ;
    and (nx42, nx40, NOT_C0) ;
    or (nx44, nx38, nx42) ;
    and (nx46, NOT_A1, NOT_B0) ;
    and (nx48, nx46, NOT_C0) ;
    or (nx50, nx44, nx48) ;
    and (nx52, NOT_A0, NOT_B0) ;
    and (nx54, nx52, NOT_C0) ;
    or (Y, nx50, nx54) ;
endmodule


module nor03_2x ( Y, A0, A1, A2 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;

    wire NOT_A0, NOT_A1, nx4, NOT_A2;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx4, NOT_A0, NOT_A1) ;
    assign NOT_A2 = ~A2 ;
    and (Y, nx4, NOT_A2) ;
endmodule


module ao32 ( Y, A0, A1, A2, B0, B1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;
    input B0 ;
    input B1 ;

    wire nx0, nx2, nx4;



    and (nx0, A0, A1) ;
    and (nx2, nx0, A2) ;
    and (nx4, B0, B1) ;
    or (Y, nx2, nx4) ;
endmodule


module aoi221 ( Y, A0, A1, B0, B1, C0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;
    input B1 ;
    input C0 ;

    wire NOT_A1, NOT_B1, nx4, NOT_C0, nx8, NOT_A0, nx12, nx14, nx16, NOT_B0, 
         nx20, nx22, nx24, nx26, nx28;



    assign NOT_A1 = ~A1 ;
    assign NOT_B1 = ~B1 ;
    and (nx4, NOT_A1, NOT_B1) ;
    assign NOT_C0 = ~C0 ;
    and (nx8, nx4, NOT_C0) ;
    assign NOT_A0 = ~A0 ;
    and (nx12, NOT_A0, NOT_B1) ;
    and (nx14, nx12, NOT_C0) ;
    or (nx16, nx8, nx14) ;
    assign NOT_B0 = ~B0 ;
    and (nx20, NOT_A1, NOT_B0) ;
    and (nx22, nx20, NOT_C0) ;
    or (nx24, nx16, nx22) ;
    and (nx26, NOT_A0, NOT_B0) ;
    and (nx28, nx26, NOT_C0) ;
    or (Y, nx24, nx28) ;
endmodule


module nand03 ( Y, A0, A1, A2 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;

    wire NOT_A2, NOT_A1, nx4, NOT_A0;



    assign NOT_A2 = ~A2 ;
    assign NOT_A1 = ~A1 ;
    or (nx4, NOT_A2, NOT_A1) ;
    assign NOT_A0 = ~A0 ;
    or (Y, nx4, NOT_A0) ;
endmodule


module oai32 ( Y, A0, A1, A2, B0, B1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;
    input B0 ;
    input B1 ;

    wire NOT_A0, NOT_A1, nx4, NOT_A2, nx8, NOT_B0, NOT_B1, nx14;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx4, NOT_A0, NOT_A1) ;
    assign NOT_A2 = ~A2 ;
    and (nx8, nx4, NOT_A2) ;
    assign NOT_B0 = ~B0 ;
    assign NOT_B1 = ~B1 ;
    and (nx14, NOT_B0, NOT_B1) ;
    or (Y, nx8, nx14) ;
endmodule


module mux21 ( Y, A0, A1, S0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input S0 ;

    wire NOT_A0, NOT_S0, nx4, NOT_A1, nx8;



    assign NOT_A0 = ~A0 ;
    assign NOT_S0 = ~S0 ;
    and (nx4, NOT_A0, NOT_S0) ;
    assign NOT_A1 = ~A1 ;
    and (nx8, NOT_A1, S0) ;
    or (Y, nx4, nx8) ;
endmodule


module oai21 ( Y, A0, A1, B0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;

    wire NOT_A0, NOT_A1, nx4, NOT_B0;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx4, NOT_A0, NOT_A1) ;
    assign NOT_B0 = ~B0 ;
    or (Y, nx4, NOT_B0) ;
endmodule


module xor2 ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;




    xor (Y, A0, A1) ;
endmodule


module nor03 ( Y, A0, A1, A2 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;

    wire NOT_A0, NOT_A1, nx4, NOT_A2;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx4, NOT_A0, NOT_A1) ;
    assign NOT_A2 = ~A2 ;
    and (Y, nx4, NOT_A2) ;
endmodule


module nor02ii ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;

    wire NOT_A0;



    assign NOT_A0 = ~A0 ;
    and (Y, NOT_A0, A1) ;
endmodule


module or02 ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;




    or (Y, A1, A0) ;
endmodule


module buf02 ( Y, A ) ;

    output Y ;
    input A ;




    assign Y = A ;
endmodule


module ao21 ( Y, A0, A1, B0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;

    wire nx0;



    and (nx0, A0, A1) ;
    or (Y, nx0, B0) ;
endmodule


module inv02 ( Y, A ) ;

    output Y ;
    input A ;




    assign Y = ~A ;
endmodule


module mux21_ni ( Y, A0, A1, S0 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input S0 ;

    wire NOT_S0, nx2, nx4;



    assign NOT_S0 = ~S0 ;
    and (nx2, A0, NOT_S0) ;
    and (nx4, A1, S0) ;
    or (Y, nx2, nx4) ;
endmodule


module nand04 ( Y, A0, A1, A2, A3 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;
    input A3 ;

    wire NOT_A3, NOT_A2, nx4, NOT_A1, nx8, NOT_A0;



    assign NOT_A3 = ~A3 ;
    assign NOT_A2 = ~A2 ;
    or (nx4, NOT_A3, NOT_A2) ;
    assign NOT_A1 = ~A1 ;
    or (nx8, nx4, NOT_A1) ;
    assign NOT_A0 = ~A0 ;
    or (Y, nx8, NOT_A0) ;
endmodule


module nor04 ( Y, A0, A1, A2, A3 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;
    input A3 ;

    wire NOT_A0, NOT_A1, nx4, NOT_A2, nx8, NOT_A3;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (nx4, NOT_A0, NOT_A1) ;
    assign NOT_A2 = ~A2 ;
    and (nx8, nx4, NOT_A2) ;
    assign NOT_A3 = ~A3 ;
    and (Y, nx8, NOT_A3) ;
endmodule


module xnor2 ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;




    xnor (Y, A0, A1) ;
endmodule


module ao22 ( Y, A0, A1, B0, B1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;
    input B1 ;

    wire nx0, nx2;



    and (nx0, B0, B1) ;
    and (nx2, A0, A1) ;
    or (Y, nx0, nx2) ;
endmodule


module aoi32 ( Y, A0, A1, A2, B0, B1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input A2 ;
    input B0 ;
    input B1 ;

    wire NOT_A2, NOT_B1, nx4, NOT_A1, nx8, nx10, NOT_A0, nx14, nx16, NOT_B0, 
         nx20, nx22, nx24, nx26, nx28;



    assign NOT_A2 = ~A2 ;
    assign NOT_B1 = ~B1 ;
    and (nx4, NOT_A2, NOT_B1) ;
    assign NOT_A1 = ~A1 ;
    and (nx8, NOT_A1, NOT_B1) ;
    or (nx10, nx4, nx8) ;
    assign NOT_A0 = ~A0 ;
    and (nx14, NOT_A0, NOT_B1) ;
    or (nx16, nx10, nx14) ;
    assign NOT_B0 = ~B0 ;
    and (nx20, NOT_A2, NOT_B0) ;
    or (nx22, nx16, nx20) ;
    and (nx24, NOT_A1, NOT_B0) ;
    or (nx26, nx22, nx24) ;
    and (nx28, NOT_A0, NOT_B0) ;
    or (Y, nx26, nx28) ;
endmodule


module aoi22 ( Y, A0, A1, B0, B1 ) ;

    output Y ;
    input A0 ;
    input A1 ;
    input B0 ;
    input B1 ;

    wire NOT_A1, NOT_B1, nx4, NOT_A0, nx8, nx10, NOT_B0, nx14, nx16, nx18;



    assign NOT_A1 = ~A1 ;
    assign NOT_B1 = ~B1 ;
    and (nx4, NOT_A1, NOT_B1) ;
    assign NOT_A0 = ~A0 ;
    and (nx8, NOT_A0, NOT_B1) ;
    or (nx10, nx4, nx8) ;
    assign NOT_B0 = ~B0 ;
    and (nx14, NOT_A1, NOT_B0) ;
    or (nx16, nx10, nx14) ;
    and (nx18, NOT_A0, NOT_B0) ;
    or (Y, nx16, nx18) ;
endmodule


module nand02_2x ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;

    wire NOT_A1, NOT_A0;



    assign NOT_A1 = ~A1 ;
    assign NOT_A0 = ~A0 ;
    or (Y, NOT_A1, NOT_A0) ;
endmodule


module nor02_2x ( Y, A0, A1 ) ;

    output Y ;
    input A0 ;
    input A1 ;

    wire NOT_A0, NOT_A1;



    assign NOT_A0 = ~A0 ;
    assign NOT_A1 = ~A1 ;
    and (Y, NOT_A0, NOT_A1) ;
endmodule

