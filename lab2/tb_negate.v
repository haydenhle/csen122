`timescale 1ns / 1ps
//============================================================
// Testbench: tb_negate
//============================================================
module tb_negate;

    // regs store data
    reg  [31:0] A;

    // wires connect modules
    wire [31:0] out;

    // instantiate the negate module
    negate dut (
        .A(A),
        .out(out)
    );

    // run once
    initial begin
        // Case 1: A = 0
        // -0 should be 0
        A = 32'd0;
        #10;

        // Case 2: A = 5
        // -5 should be 0xFFFFFFFB
        A = 32'd5;
        #10;

        // Case 3: A = 0xFFFFFFFF (-1)
        // -(-1) should be 1
        A = 32'hFFFFFFFF;
        #10;

        // end simulation
        $finish;
    end

endmodule
