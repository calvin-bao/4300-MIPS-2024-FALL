module bottom_mux_tb(

    );
    
    wire [4:0] t;
    
    reg [4:0] a, b;
    reg sel;
    
    BOTTOM_MUX bottom_mux(
    .y(y),
    .a(a),
    .b(b),
    .sel(sel)
    );
    
    initial
    begin
    
    a = 5'b01010;
    b = 5'b10101;
    sel = 1'b1;
    #10;
    a = 5'b00000;
    #10
    sel = 1'b1;
    #10;
    b = 5'b11111;
    #5;
    a = 5'b00101;
    #5;
    sel = 1'b0;
    b = 5'b11101;
    #5;
    sel = 1'bx;
  
    end
  
  always @(a or b or sel)
    #1 $display("At t = %0d sel = %b a = %b b = %b y = %b",
                $time, sel, a, b, y);
    
endmodule
