module WB(
    input MemtoReg,
    input [31:0] mem_Read_data, mem_ALU_result,
    output [31:0] wb_data
    );
    
    assign wb_data = MemtoReg ? mem_Read_data : mem_ALU_result;
    
endmodule
