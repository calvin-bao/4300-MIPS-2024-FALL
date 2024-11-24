module instruction_memory(
    input [31:0] address, // 32-bit address input
    output [31:0] data // 32-bit instruction data output
    );
    
    reg [31:0] memory [127:0]; // memory array with 128 32-bit words
    integer i;
    
    initial
    begin
        // initializing memory with given HEX values
        memory[0] = 32'hA00000AA;
        memory[1] = 32'h10000011;
        memory[2] = 32'h20000022;
        memory[3] = 32'h30000033;
        memory[4] = 32'h40000044;
        memory[5] = 32'h50000055;
        memory[6] = 32'h60000066;
        memory[7] = 32'h70000077;
        memory[8] = 32'h80000088;
        memory[9] = 32'h90000099;
        
        // initialize the remaining memory to zero
        for (i = 10; i < 128; i = i + 1)
            memory[i] = 32'h00000000;
    end
    
    assign data = memory[address[6:0]];
    
endmodule
