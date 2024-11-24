module mux_2x1(
    input [31:0] A, B,
    input sel,
    output [31:0] out
    );
    
    assign out = sel ? A : B;
    
endmodule
