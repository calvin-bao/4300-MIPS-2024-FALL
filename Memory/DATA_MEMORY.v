module DATA_MEMORY(
    input [31:0] address, write_data,
    input memwrite, memread,
    output reg [31:0] read_data
    );
    
    reg [31:0] memory [0:255];
    
    always @(*)
    begin
        if (memwrite)
        begin
            memory[address[7:0]] = write_data;
        end
    end
    
    always @(*)
    begin
        if (memread)
        begin
            read_data = memory[address[7:0]];
        end
        else
        begin
            read_data = 32'bz;
        end
    end
    
endmodule
