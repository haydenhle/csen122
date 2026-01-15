`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: mux4to1
//////////////////////////////////////////////////////////////////////////////////

module mux4to1(A, B, C, D, sel, out);

    // define variables
    input A, B, C, D;
    // define 2-bit signal
    input [1:0] sel;

    // define output as reg
    output reg out;

    // run whenever any of these inputs change
    always @(A, B, C, D, sel)
    begin
    // based on truth table in slides
        // Case 1: A = 00
        if (sel == 2'b00)
            out = A;

        // Case 2: B = 01
        else if (sel == 2'b01)
            out = B;

        // Case 3: C = 10
        else if (sel == 2'b10)
            out = C;

        // Case 4: D = 11
        else
            out = D;
    end

endmodule
