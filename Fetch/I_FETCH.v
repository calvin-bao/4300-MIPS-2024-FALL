module I_FETCH(
    input clk, reset,
    input PCSrc,
    input [31:0] ex_mem,
    output [31:0] instruction_out,
    output reg [31:0] pc
    );
    
    wire [31:0] pc_next;
    wire [31:0] pc_plus4;
    wire [31:0] data;
    
    instruction_memory instr_mem (
    .address(pc),
    .data(instruction_out)
    );
    
    increment_by_4 incr_by4 (
    .incr_in(pc),
    .incr_out(pc_plus4)
    );
    
    mux_2x1 mux_2by1 (
    .B(pc_plus4),
    .A(ex_mem),
    .sel(PCSrc),
    .out(pc_next)
    );
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            pc <= 0;
        else
            pc <= pc_next;
    end
    
    assign instruction_out = data;
    
endmodule
