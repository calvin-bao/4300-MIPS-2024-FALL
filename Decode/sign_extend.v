module sign_extend(
    input [15:0] in,
    output [31:0] extended_out
    );
    
    assign extended_out = {{16{in[15]}}, in}; // 16 to 32 bit
    // extend the sign bit to the 16 msb's, append the input right after
    
endmodule
