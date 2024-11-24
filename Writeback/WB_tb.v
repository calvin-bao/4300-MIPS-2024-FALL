module WB_tb(

    );
    
    reg MemtoReg;
    reg [31:0] mem_Read_data;
    reg [31:0] mem_ALU_result;

    wire [31:0] wb_data;

    // instantiate the WB module
    WB wb (
        .MemtoReg(MemtoReg),
        .mem_Read_data(mem_Read_data),
        .mem_ALU_result(mem_ALU_result),
        .wb_data(wb_data)
    );

    //initialize memory
    reg [31:0] memory [0:255];

    initial 
    begin
        memory[0] = 32'h002300AA; // Instruction: addi $3, $1, 170
        memory[1] = 32'h10654321; // Instruction: beq $3, $5, 0x4321
        memory[2] = 32'h00100022; // Instruction: sub $2, $8, $16
        memory[3] = 32'h8C123456; // Instruction: lw $18, 0x3456($8)
        memory[4] = 32'h8F123456; // Instruction: lw $18, 0x3456($15)
        memory[5] = 32'hAD654321; // Instruction: sw $21, 0x4321($11)
        memory[6] = 32'h13012345; // Instruction: beq $24, $1, 0x2345
        memory[7] = 32'hAC654321; // Instruction: sw $21, 0x4321($12)
        memory[8] = 32'h12012345; // Instruction: beq $16, $1, 0x2345
    end

    initial 
    begin
        // testing writeback
        // MemtoReg = 0 (ALU result selected)
        MemtoReg = 0;
        mem_ALU_result = 32'd42;  // Example ALU result
        mem_Read_data = 32'd100; // Example memory read data

        #10; 

        // MemtoReg = 1 (Memory read data selected)
        MemtoReg = 1;
        mem_ALU_result = 32'd84;  // example ALU result
        mem_Read_data = 32'd200; // example memory read data

        #10; 

        // another test
        mem_ALU_result = 32'd120;
        mem_Read_data = 32'd300;
        MemtoReg = 0;

        #10;

        MemtoReg = 1;

        #10;

        $stop;
    end
    
endmodule
