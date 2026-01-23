`timescale 1ns / 1ps
//============================================================
// Testbench: tb_mux3to1
// Expected behavior:
//   sel = 00 → B OR 0 → B
//   sel = 01 → 0 OR 0 → 0
//   sel = 10 → -B OR 0 → -B
//============================================================
module tb_mux3to1;

    // regs store data
    reg B;
    reg negB;
    reg [1:0] sel;

    // wire connects modules
    wire out;

    // instantiate the mux
    mux3to1 dut (.B(B), .negB(negB), .sel(sel), .out(out));

    // run once
    initial begin
        // set data inputs
        B = 0;
        negB = 0;
        sel = 2'b00;

        // Case 1: sel = 00 → output = B
        sel = 2'b00;

        B = 0; negB = 1; 
        #10;
        B = 1; negB = 0; 
        #10;

        // Case 2: sel = 01 → output = 0
        sel = 2'b01;

        B = 0; negB = 1; 
        #10;
        B = 1; negB = 0; 
        #10;

        // Case 3: sel = 10 → output = negB
        sel = 2'b10;

        B = 0; negB = 1; 
        #10;
        B = 1; negB = 0; 
        #10;

        // end simulation
        $finish;
    end

endmodule
