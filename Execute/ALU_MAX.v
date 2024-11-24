module ALU_MAX(
    input [31:0] A, B,
    input [2:0] control,
    output zero,
    output reg [31:0] result
    );
    
    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
    
    always @(*)
    begin
        case (control)
            3'b010: result = A + B; // add 
            3'b110: result = A - B; // subtract
            3'b000: result = A & B; // and
            3'b001: result = A | B; // or
            3'b111: result = (A < B) ? 1'b1 : 1'b0; // set on less than
            default: result = 32'bx;
        endcase
    end
    
endmodule
