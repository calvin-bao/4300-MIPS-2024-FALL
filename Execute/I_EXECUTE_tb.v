module I_EXECUTE_tb(

    );
    
    reg clk;
    reg reset;
    reg [31:0] npc;
    reg [31:0] reg_rs, reg_rt;
    reg [31:0] sign_ext;
    reg [1:0] wb_ctl;
    reg [3:0] ex_ctl;
    reg [2:0] m_ctl;
    reg [4:0] instr_20_16, instr_15_11;

    wire [31:0] alu_result;
    wire zero;

    reg [31:0] memory [0:8]; // memory for 9 instructions

    // instantiate I_EXECUTE module
    I_EXECUTE uut (
        .clk(clk),
        .reset(reset),
        .npc(npc),
        .reg_rs(reg_rs),
        .reg_rt(reg_rt),
        .sign_ext(sign_ext),
        .wb_ctl(wb_ctl),
        .m_ctl(m_ctl),
        .ex_ctl(ex_ctl),
        .instr_20_16(instr_20_16),
        .instr_15_11(instr_15_11),
        .alu_result(alu_result),
        .zero(zero)
    );

    always #5 clk = ~clk; // 10 ns clock period


    initial 
    begin
        // Initialize clock and reset
        clk = 0;
        reset = 1;
        #10 reset = 0;

        // initialize memory with hex values
        memory[0] = 32'h002300AA;
        memory[1] = 32'h10654321;
        memory[2] = 32'h00100022;
        memory[3] = 32'h8C123456;
        memory[4] = 32'h8F123456;
        memory[5] = 32'hAD654321;
        memory[6] = 32'h13012345;
        memory[7] = 32'hAC654321;
        memory[8] = 32'h12012345;

        // initialize signals to zero
        npc = 32'd0;
        reg_rs = 32'd0;
        reg_rt = 32'd0;
        sign_ext = 32'd0;
        wb_ctl = 2'b00;
        m_ctl = 3'b000;
        ex_ctl = 4'b0000;
        instr_20_16 = 5'd0;
        instr_15_11 = 5'd0;

        // test memory instructions
        repeat (9) begin
            @(posedge clk);
            npc = npc + 4;         
            reg_rs = 32'd0;         
            reg_rt = 32'd0;         
            sign_ext = 32'd0;       
            wb_ctl = 2'b00;         
            m_ctl = 3'b000;         
            ex_ctl = 4'b0000;       
            instr_20_16 = 5'd0;     
            instr_15_11 = 5'd0;     
        end

        #100;

        $stop;
    end
endmodule
