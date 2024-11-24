module MEM_tb(

    );
    
    reg clk;
    reg reset;
    reg [31:0] address;
    reg [31:0] write_data;
    reg [4:0] write_reg;
    reg memwrite;
    reg memread;
    reg m_ctlout;
    reg zero;
    reg [1:0] control_wb;

    wire [1:0] mem_control_wb;
    wire [31:0] mem_read_data;
    wire [31:0] mem_ALU_result;
    wire [4:0] mem_Write_reg;
    wire PCSrc;

    // instantiating the MEM module
    MEM mem (
        .clk(clk),
        .reset(reset),
        .address(address),
        .write_data(write_data),
        .write_reg(write_reg),
        .memwrite(memwrite),
        .memread(memread),
        .m_ctlout(m_ctlout),
        .zero(zero),
        .control_wb(control_wb),
        .mem_control_wb(mem_control_wb),
        .mem_read_data(mem_read_data),
        .mem_ALU_result(mem_ALU_result),
        .mem_Write_reg(mem_Write_reg),
        .PCSrc(PCSrc)
    );

    // initialize memory
    reg [31:0] memory [0:255];

    initial begin
        memory[0] = 32'h002300AA; 
        memory[1] = 32'h10654321;
        memory[2] = 32'h00100022;
        memory[3] = 32'h8C123456;
        memory[4] = 32'h8F123456;
        memory[5] = 32'hAD654321;
        memory[6] = 32'h13012345;
        memory[7] = 32'hAC654321;
        memory[8] = 32'h12012345;
    end

    always #5 clk = ~clk;

    initial 
    begin
        clk = 0;
        reset = 1;
        address = 0;
        write_data = 0;
        write_reg = 0;
        memwrite = 0;
        memread = 0;
        m_ctlout = 0;
        zero = 0;
        control_wb = 0;

        #10 reset = 0;

        @(posedge clk);
        address = 32'h00000004; 
        write_data = memory[1];
        memwrite = 1;           // write to memory
        memread = 0;

        @(posedge clk);
        address = 32'h00000008; // change address for next instruction
        write_data = memory[2];
        memwrite = 0;           // stop writing to memory
        memread = 1;           // read from memory

        #100;

        $stop;
    end
    
endmodule
