module mux_2x1_tb(

    );
    
    wire [31:0] out;
    reg [31:0] A, B;
    reg sel;
    
    mux_2x1 mux1 (
    .A(A),
    .B(B),
    .sel(sel),
    .out(out)
    );
    
    initial
    begin
        
        A = 32'hAAAAAAAA; // 8 bytes of 1010
        B = 32'h55555555; // 8 bytes of 0101
        sel = 1'b1; // select in1 to display
        #10;
        A = 32'h00000000; // clear in1
        #10;
        sel = 1'b1; // select in1 to display
        #10;
        B = 32'hFFFFFFFF; // 8 bytes of 1111
        #5;
        A = 32'hA5A5A5A5; // 4 bytes of 10100101
        #5;
        sel = 1'b0; // select in0 to display 
        B = 32'hDDDDDDDD; // 8 bytes of 1101
        #5;
        sel = 1'bx; // display both in0 and in1
        
    end
    
    always @(A or B or sel) // execute for any changes
    #1 $display("At t = %0d sel = %b A = %h B = %h out = %h",
                $time, sel, A, B, out);
    
endmodule
