module AND_BRANCH(
    input m_ctlout, zero,
    output PCSrc
    );
    
    assign PCSrc = m_ctlout & zero;
    
endmodule
