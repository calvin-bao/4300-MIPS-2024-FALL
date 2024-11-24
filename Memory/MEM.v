module MEM(
    input clk, reset,
    input [31:0] address, write_data,
    input [4:0] write_reg,
    input memwrite, memread, m_ctlout, zero,
    input [1:0] control_wb,
    output [1:0] mem_control_wb,
    output [31:0] mem_read_data, mem_ALU_result,
    output [4:0] mem_Write_reg,
    output PCSrc
    );
    
    wire [31:0] read_data;
    
    DATA_MEMORY data_memory (
        .address(address),
        .write_data(write_data),
        .memwrite(memwrite),
        .memread(memread),
        .read_data(read_data)
    );

    AND_BRANCH and_branch (
        .m_ctlout(m_ctlout),
        .zero(zero),
        .PCSrc(PCSrc)
    );

    MEM_WB_LATCH mem_wb_latch (
        .clk(clk),
        .reset(reset),
        .control_wb_in(control_wb),
        .Read_data_in(read_data),
        .ALU_result_in(address),   
        .Write_reg_in(write_reg),
        .mem_control_wb(mem_control_wb),
        .Read_data(mem_read_data),
        .mem_ALU_result(mem_ALU_result),
        .mem_Write_reg(mem_Write_reg)
    );
    
endmodule
