module ALU_CONTROL(
    input [5:0] funct,
    input [1:0] alu_op,
    output reg [2:0] select
    );
    
    always @(*)
    begin
        case (alu_op)
            2'b00: select = 3'b010; // for LW and SW
            2'b01: select = 3'b110; // for branch equal
            2'b10: 
            begin // r types
                case (funct)
                    6'b100000: select = 3'b010; // ADD
                    6'b100010: select = 3'b110; // SUB 
                    6'b100100: select = 3'b000; // AND
                    6'b100101: select = 3'b001; // OR
                    6'b101010: select = 3'b111; // set on less than
                    default: select = 3'bxxx; // default
                endcase
            end
            default: select = 3'bxxx; // default
        endcase
    end
    
endmodule
