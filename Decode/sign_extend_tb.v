module sign_extend_tb(

    );
    
    wire [31:0] extended_out;
    reg [15:0] in;
    
    sign_extend s_extend (
    .in(in),
    .extended_out(extended_out)
    );
    
    initial
    begin
    
    in = 16'hAAAA;
    #10
    in = 16'h0001;
    #10
    in = 16'hFFFF;
    #10;
    
    $finish;
    
    end
    
endmodule
