//
// Verilog description for cell mux2x1, 
// Thu Oct  6 19:31:12 2022
//
// LeonardoSpectrum Level 3, 2009a.6 
//


module mux2x1 ( a, b, sel, z ) ;

    input a ;
    input b ;
    input sel ;
    output z ;




    mux21_ni ix7 (.Y (z), .A0 (a), .A1 (b), .S0 (sel)) ;
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

