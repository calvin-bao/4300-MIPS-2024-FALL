module MEM_WB_LATCH(
    input clk, reset,
    input [1:0] control_wb_in,
    input [31:0] Read_data_in, ALU_result_in,
    input [4:0] Write_reg_in,
    output reg [1:0] mem_control_wb,
    output reg [31:0] Read_data, mem_ALU_result,
    output reg [4:0] mem_Write_reg
    );
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            mem_control_wb <= 2'b0;
            Read_data <= 32'b0;
            mem_ALU_result <= 32'b0;
            mem_Write_reg <= 5'b0;
        end
        else
        begin
            mem_control_wb <= control_wb_in;
            Read_data <= Read_data_in;
            mem_ALU_result <= ALU_result_in;
            mem_Write_reg <= Write_reg_in;
        end
    end
endmodule
