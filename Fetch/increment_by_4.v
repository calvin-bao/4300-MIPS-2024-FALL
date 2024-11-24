module increment_by_4(
    input [31:0] incr_in,
    output [31:0] incr_out
    );
    
    assign incr_out = incr_in + 4;
    
endmodule
