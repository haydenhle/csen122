`timescale 1ns / 1ps
//============================================================
// Testbench: tb_fullAdder
//============================================================
module tb_fullAdder;

    // regs store data
    reg  [31:0] A;
    reg  [31:0] B;

    // wires connect modules
    wire [31:0] sum;
    wire        cout;

    // instantiate the full adder
    fullAdder dut (
        .A(A),
        .B(B),
        .sum(sum),
        .cout(cout)
    );

    // run once
    initial begin
        // Case 1: zeroes
        // decimal 0 + 0 = 0
        A = 32'd0;
        B = 32'd0;
        #10;

        // Case 2: pos + pos
        // decimal 3 + 4 = 7
        A = 32'd3;
        B = 32'd4;
        #10;

        // Case 3: pos + neg
        A = 32'hFFFFFFFB;   // -5
        B = 32'd3;
        #10;

        
        // Case 4: neg + neg
        A = 32'hFFFFFFFE;   // -2
        B = 32'hFFFFFFFD;   // -3
        #10;

        // end simulation
        $finish;
    end

endmodule
