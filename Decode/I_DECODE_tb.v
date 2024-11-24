module I_DECODE_tb(
    
    );
    reg clk;
    reg [31:0] instr;
    reg [31:0] npc;
    reg [4:0] mem_wb_writereg;
    reg [31:0] mem_wb_writedata;
    reg regwrite;

    wire [1:0] wb_out;
    wire [2:0] m_out;
    wire [3:0] ex_out;
    wire [31:0] npc_out;
    wire [31:0] reg_rs_out;
    wire [31:0] reg_rt_out;
    wire [31:0] sign_ext_out;
    wire [4:0] instr_20_16_out;
    wire [4:0] instr_15_11_out;

    I_DECODE uut (
        .clk(clk),
        .instr(instr),
        .npc(npc),
        .mem_wb_writereg(mem_wb_writereg),
        .mem_wb_writedata(mem_wb_writedata),
        .regwrite(regwrite),
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

    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    initial 
    begin
        npc = 32'h00000004;                 // start with the first next program counter value
        mem_wb_writereg = 5'b00000;         // register to write to
        mem_wb_writedata = 32'h00000000;    // data to write to the register
        regwrite = 1;                       // enable register write

        #10;
        
        // testing the values listed in lab manual
        
        instr = 32'h002300AA;
        #10;

        instr = 32'h10654321;
        #10;

        instr = 32'h00100022;
        #10;

        instr = 32'h8C123456;
        #10;

        instr = 32'h8F123456;
        #10;

        instr = 32'hAD654321;
        #10;

        instr = 32'h13012345;
        #10;

        instr = 32'hAC654321;
        #10;

        instr = 32'h12012345;
        #10;

        $stop;
    end
endmodule
