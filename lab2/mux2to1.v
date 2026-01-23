`timescale 1ns / 1ps
//============================================================
// Module: mux2to1
// Case 1: sel = 0 → output = A
// Case 2: sel = 1 → output = negA
//============================================================
module mux2to1 (
    input  wire A,        // input A
    input  wire negA,     // 2's complement or inverted A
    input  wire sel,      // select signal
    output wire out       // mux output
);

    // internal wires for gate outputs
    wire notSel;
    wire leftAnd;
    wire rightAnd;

    // inverter on sel
    not (notSel, sel);

    // two AND gates
    // A when sel = 0
    and (leftAnd, notSel, A);

    // -A when sel = 1
    and (rightAnd, sel, negA);

    // OR gate
    or  (out, leftAnd, rightAnd);

endmodule


