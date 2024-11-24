module REG(
    input clk,
    input [4:0] rs, rt,            // Source register addresses
    input [4:0] writereg,          // Destination register address for writing
    input [31:0] writedata,        // Data to be written to writereg
    input regwrite,                // Write enable signal
    output [31:0] reg_rs,          // Data read from rs
    output [31:0] reg_rt           // Data read from rt
    );
    
    reg [31:0] registers [0:31]; // 32 registers that are each 32-bits wide

    integer i;
    initial
    begin
        for (i = 0; i < 32; i = i + 1)
        begin
        registers[i] = 32'h0;
        end
    end
    
    assign reg_rs = registers[rs];
    assign reg_rt = registers[rt];
    
    always @(posedge clk) begin
        if (regwrite)
        begin
            registers[writereg] <= writedata;
        end
    end

endmodule
