`timescale 1ns / 1ps
//============================================================
// Module: mux3to1
// Case 1: sel = 00 → B path → out = B
// Case 2: sel = 01 → 0 path → out = 0
// Case 3: sel = 10 → -B path → out = -B
// Case 4: sel = 11 → unused
//============================================================
module mux3to1 (
    input  wire B,        // input B
    input  wire negB,     // 2's complement or inverted B
    input  wire [1:0] sel,// 2-bit select signal
    output wire out       // mux output
);

    // internal wires for gate outputs
    wire notSel0;
    wire notSel1;

    wire andB;
    wire andZero;
    wire andNegB;

    // invert sel lines
    not (notSel0, sel[0]);
    not (notSel1, sel[1]);

    // three AND gates (one per input)
    // return B if sel = 00
    and (andB, notSel1, notSel0, B);

    // force return 0 when sel = 01
    and (andZero, notSel1, sel[0], 1'b0);

    // return -B when sel = 10
    and (andNegB, sel[1], notSel0, negB);

    // OR gate to combine all paths
    or  (out, andB, andZero, andNegB);

endmodule

