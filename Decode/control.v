module control(
    input [5:0] opcode,     // 6-bit opcode
    output reg [1:0] WB,    // 2-bit for Write Back: Mem to Reg, Reg to Write
    output reg [2:0] M,     // 3-bit for Memory Access: Mem Write, Mem Read, Branch 
    output reg [3:0] EX         // 4-bit for Execution/Address Calculation:
                                // ALU Src, ALU OP0, ALU OP1, Reg Dst
    );
    
    always @(*)
    begin
    case (opcode)
        6'b000000: // R-format 
        begin
            WB = 2'b11;    // Mem to Reg = 1, Reg Write = 1
            M  = 3'b000;   // Mem Write = 0, Mem Read = 0, Branch = 0
            EX = 4'b0010;  // ALU Src = 0, ALU OP0 = 0, ALU OP1 = 1, Reg Dst = 1
        end
        
        6'b000011: // lw (load word)
        begin
            WB = 2'b10;    // Mem to Reg = 1, Reg Write = 1
            M  = 3'b010;   // Mem Write = 0, Mem Read = 0, Branch = 0
            EX = 4'b0001;  // ALU Src = 0, ALU OP0 = 0, ALU OP1 = 1, Reg Dst = 1
        end
        
        6'b101011: // sw (store word)
        begin
            WB = 2'b0x;    // Mem to Reg = 1, Reg Write = 1
            M  = 3'b001;   // Mem Write = 0, Mem Read = 0, Branch = 0
            EX = 4'bx001;  // ALU Src = 0, ALU OP0 = 0, ALU OP1 = 1, Reg Dst = 1
        end
        
        6'b000100: // beq (branch equal)
        begin
            WB = 2'b0x;    // Mem to Reg = 1, Reg Write = 1
            M  = 3'b100;   // Mem Write = 0, Mem Read = 0, Branch = 0
            EX = 4'bx010;  // ALU Src = 0, ALU OP0 = 0, ALU OP1 = 1, Reg Dst = 1
        end
        
       default: // default to 0s
        begin
            WB = 2'b00;    // Mem to Reg = 1, Reg Write = 1
            M  = 3'b000;   // Mem Write = 0, Mem Read = 0, Branch = 0
            EX = 4'b0000;  // ALU Src = 0, ALU OP0 = 0, ALU OP1 = 1, Reg Dst = 1
        end    
    endcase
    end
endmodule

//    the control module has a 6 bit opcode input and a 9 bits of control bits.
//    2 bit WB (write back stage control lines) output, 
//    M (memory access stage control lines) output, 
//    and EX (execution/Address calculation stage control lines) output.
//    The WB control lines has 2 bits (0-1), Mem to Reg and Reg Write respectively.
//    The M control line has 3 bits (2-4), Mem Write, Mem Read, and Branch respectively.
//    The EX control line has 4 bits (5-8), ALU Src, ALU OP0, ALU OP1, and Reg Dst respectively.
//    The R-format equals 110000010, lw equals 000101011, sw equals X0010010X, and beq equals X0101000X.
