`timescale 1ns / 1ps
//============================================================
// Module: ALU
// Description:
//  32-bit Arithmetic Logic Unit
//  Supported operations:
//   ADD, SUB, NEGATE, PASS A
//============================================================
module ALU (
    input  wire [31:0] A,     // input A
    input  wire [31:0] B,     // input B
    input  wire        add,   // addition
    input  wire        neg,   // negate
    input  wire        sub,   // subtract
    output wire [31:0] out,   // result
    output wire        Z,     // zero flag
    output wire        N      // negative flag
);

    // internal wires
    wire [31:0] negA;          // -A
    wire [31:0] negB;          // -B
    wire [31:0] selA;          // sel A input
    wire [31:0] selB;          // sel B input
    wire        cout;          // carry out

    // get 2's complement vals
    negate negA_block (
        .A   (A),
        .out (negA)
    );

    negate negB_block (
        .A   (B),
        .out (negB)
    );

    // Path A is to mux2to1
    // sel A or -A
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : A_SELECT
            mux2to1 muxA (
                .A    (A[i]),
                .negA (negA[i]),
                .sel  (neg),
                .out  (selA[i])
            );
        end
    endgenerate

    // Path B is to mux3to1
    // select B, 0, or -B
    // sel 00 = B, 01 = 0, 10 = -B
    generate
        for (i = 0; i < 32; i = i + 1) begin : B_SELECT
            mux3to1 muxB (
                .B     (B[i]),
                .negB  (negB[i]),
                .sel   ({sub, neg}),
                .out   (selB[i])
            );
        end
    endgenerate

    // add inputs
    fullAdder adder (
        .A   (selA),
        .B   (selB),
        .sum (out),
        .cout(cout)
    );

    // flags
    // Z = 1 if output = zero
    assign Z = (out == 32'd0);

    // N = most sig bit of output
    assign N = out[31];

endmodule
