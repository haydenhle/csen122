`timescale 1ns / 1ps
//============================================================
// Testbench: tb_mux2to1
// Expected behavior:
//   sel = 0 → out follows A
//   sel = 1 → out follows negA
//============================================================
module tb_mux2to1;

    // regs store data
    reg A;
    reg negA;
    reg sel;

    // wire connects modules
    wire out;

    // instantiate the mux
    mux2to1 dut (.A(A), .negA(negA), .sel(sel), .out(out));

    // run once
    initial begin
        // set data inputs
        A = 0;
        negA = 0;
        sel = 0;

        // Case 1: sel = 0 → output = A
        sel = 0;

        A = 0; negA = 1; #10;
        A = 1; negA = 0; #10;

        // Case 2: sel = 1 → output = negA
        sel = 1;

        A = 0; negA = 1; #10;
        A = 1; negA = 0; #10;

        $finish;
    end

endmodule

