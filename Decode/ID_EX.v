module ID_EX(
    input clk,
    input [1:0] wb_in,  // Write-back control
    input [2:0] m_in,   // Memory control
    input [3:0] ex_in,  // Execution control
    input [31:0] npc_in, reg_rs_in, reg_rt_in, sign_ext_in,
    input [4:0] instr_20_16_in, instr_15_11_in,
    output reg [1:0] wb_out,
    output reg [2:0] m_out,
    output reg [3:0] ex_out,
    output reg [31:0] npc_out, reg_rs_out, reg_rt_out, sign_ext_out,
    output reg [4:0] instr_20_16_out, instr_15_11_out
    );
    
    always @(posedge clk) 
    begin
        wb_out <= wb_in;
        m_out <= m_in;
        ex_out <= ex_in;
        npc_out <= npc_in;
        reg_rs_out <= reg_rs_in;
        reg_rt_out <= reg_rt_in;
        sign_ext_out <= sign_ext_in;
        instr_20_16_out <= instr_20_16_in;
        instr_15_11_out <= instr_15_11_in;
    end
    
endmodule
