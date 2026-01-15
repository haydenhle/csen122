`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tb_mux4to1
//////////////////////////////////////////////////////////////////////////////////

module tb_mux4to1();

    // regs can store data
    reg A, B, C, D;
    // 2-bit 
    reg [1:0] sel;

    // wire connects modules
    wire out;

    // instantiate the mux
    mux4to1 test(A, B, C, D, sel, out);

    // run once
    initial
    begin
        // Set data inputs
        A = 0; B = 1; C = 0; D = 1;

        // Case 1: sel = 00 → out should be A
        sel = 2'b00;
        #50;

        // Case 2: sel = 01 → out should be B
        sel = 2'b01;
        #50;

        // Case 3: sel = 10 → out should be C
        sel = 2'b10;
        #50;

        // Case 4: sel = 11 → out should be D
        sel = 2'b11;
        #50;

        $finish;
    end

endmodule
