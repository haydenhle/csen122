`timescale 1ns / 1ps
//============================================================
// Module: fullAdder
//  32-bit ripple-carry full adder
//  32 oneBitAdder modules
//============================================================
module fullAdder (
    input  wire [31:0] A,    // 32-bit input A
    input  wire [31:0] B,    // 32-bit input B
    output wire [31:0] sum,  // 32-bit sum output
    output wire        cout  // final carry out
);

    // internal wires for carry signals
    wire [32:0] carry;

    // initial cin is 0
    assign carry[0] = 1'b0;

    // generate 32 one-bit adders
    // carry ripples from right to left of bits
    genvar i; // initialize i
    generate
        // loop 32 times
        for (i = 0; i < 32; i = i + 1) begin : ADDER_LOOP
            // initialize sub module
            oneBitAdder adder (
                .A   (A[i]),
                .B   (B[i]),
                .cin (carry[i]),
                .sum (sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    // final cout
    assign cout = carry[32];

endmodule
