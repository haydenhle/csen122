`timescale 1ns / 1ps
//============================================================
// Module: oneBitAdder
// XOR: only true if values are opposite
//============================================================
module oneBitAdder (
    input  wire A,      // input A
    input  wire B,      // input B
    input  wire cin,    // carry in
    output wire sum,    // sum output
    output wire cout    // carry out
);

    // internal wires for gate outputs
    wire AxorB;
    wire AandB;
    wire AxorB_and_cin;

    // XOR gate
    // computes A ⊕ B
    xor (AxorB, A, B);

    // XOR gate
    // computes (A ⊕ B) ⊕ cin
    xor (sum, AxorB, cin);

    // AND gate
    // computes A & B
    and (AandB, A, B);

    // AND gate
    // computes (A ⊕ B) & cin
    and (AxorB_and_cin, AxorB, cin);

    // OR gate
    // combines carry terms to form cout
    or  (cout, AandB, AxorB_and_cin);

endmodule
