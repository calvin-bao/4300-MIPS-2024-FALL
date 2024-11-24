module I_EXECUTE(
input clk,
    input reset,
    input [31:0] npc,              // Next PC from ID stage
    input [31:0] reg_rs, reg_rt,    // Register values
    input [31:0] sign_ext,          // Sign-extended immediate
    input [1:0] wb_ctl,             // Write-back control signals
    input [2:0] m_ctl,              // Memory control signals
    input [3:0] ex_ctl,             // Execution control signals
    input [4:0] instr_20_16,        // Destination register for ALU result
    input [4:0] instr_15_11,        // Destination register for R-type instructions
    output [31:0] alu_result,       // ALU output result
    output zero                     // Zero flag from ALU
);

    // Internal wires
    wire [31:0] branch_target;
    wire [2:0] alu_control_signal;
    wire [31:0] alu_out;
    wire alu_zero;
    wire [4:0] muxout;

    // Branch target address computation
    ADDER branch_adder (
        .add_in1(npc),
        .add_in2(sign_ext << 2),
        .add_out(branch_target)
    );

    // ALU Control module
    ALU_CONTROL alu_control (
        .funct(sign_ext[5:0]),
        .alu_op(ex_ctl[1:0]),
        .select(alu_control_signal)
    );

    // ALU
    ALU_MAX alu (
        .A(reg_rs),
        .B(reg_rt),
        .control(alu_control_signal),
        .zero(alu_zero),
        .result(alu_out)
    );

    // Bottom MUX for selecting destination register
    BOTTOM_MUX bottom_mux (
        .a(instr_15_11),
        .b(instr_20_16),
        .sel(ex_ctl[2]),  // Assuming this control bit selects the mux
        .y(muxout)
    );

    // ID/EX Pipeline Register
    ID_MEM id_mem (
        .aluzero(alu_zero),
        .ctlwb_out(wb_ctl),
        .ctlm_out(m_ctl),
        .adder_out(branch_target),
        .aluout(alu_out),
        .readdat2(reg_rt),
        .muxout(muxout),
        .zero(zero),
        .wb_ctlout(wb_ctl),
        .m_ctlout(m_ctl),
        .add_result(branch_target),
        .alu_result(alu_result),
        .rdata2out(reg_rt),
        .five_bit_muxout(muxout)
    );

endmodule
