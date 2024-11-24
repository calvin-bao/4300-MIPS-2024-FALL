module I_DECODE(
input clk,
    input [31:0] instr, npc,
    input [4:0] mem_wb_writereg,
    input [31:0] mem_wb_writedata,
    input regwrite,
    output [1:0] wb_out,
    output [2:0] m_out,
    output [3:0] ex_out,
    output [31:0] npc_out, reg_rs_out, reg_rt_out, sign_ext_out,
    output [4:0] instr_20_16_out, instr_15_11_out
);
    wire [1:0] wb;
    wire [2:0] m;
    wire [3:0] ex;
    wire [31:0] reg_rs, reg_rt, sign_extended;

    // Instantiate Control Module
    control ctrl(
        .opcode(instr[31:26]),
        .WB(wb),
        .M(m),
        .EX(ex)
    );

    // Instantiate Register File
    REG regfile(
        .clk(clk),
        .rs(instr[25:21]),
        .rt(instr[20:16]),
        .writereg(mem_wb_writereg),
        .writedata(mem_wb_writedata),
        .regwrite(regwrite),
        .reg_rs(reg_rs),
        .reg_rt(reg_rt)
    );

    // Instantiate Sign-Extend Module
     sign_extend s_extend(
        .in(instr[15:0]),
        .extended_out(sign_extended)
    );

    // Instantiate ID/EX Pipeline Register
    ID_EX id_ex(
        .clk(clk),
        .wb_in(wb),
        .m_in(m),
        .ex_in(ex),
        .npc_in(npc),
        .reg_rs_in(reg_rs),
        .reg_rt_in(reg_rt),
        .sign_ext_in(sign_extended),
        .instr_20_16_in(instr[20:16]),
        .instr_15_11_in(instr[15:11]),
        .wb_out(wb_out),
        .m_out(m_out),
        .ex_out(ex_out),
        .npc_out(npc_out),
        .reg_rs_out(reg_rs_out),
        .reg_rt_out(reg_rt_out),
        .sign_ext_out(sign_ext_out),
        .instr_20_16_out(instr_20_16_out),
        .instr_15_11_out(instr_15_11_out)
    );
endmodule
