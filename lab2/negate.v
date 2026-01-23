`timescale 1ns / 1ps
//============================================================
// Module: negate
// 2's compliment: flip every bit, then + 1
//============================================================
module negate (
    input  wire [31:0] A,    // input value
    output wire [31:0] out   // 2's complement output (-A)
);

    // internal wires
    wire [31:0] notA;         // bitwise inverted A
    wire cout;                // unused carry out

    // flip every bit
    not (notA[0],  A[0]);
    not (notA[1],  A[1]);
    not (notA[2],  A[2]);
    not (notA[3],  A[3]);
    not (notA[4],  A[4]);
    not (notA[5],  A[5]);
    not (notA[6],  A[6]);
    not (notA[7],  A[7]);
    not (notA[8],  A[8]);
    not (notA[9],  A[9]);
    not (notA[10], A[10]);
    not (notA[11], A[11]);
    not (notA[12], A[12]);
    not (notA[13], A[13]);
    not (notA[14], A[14]);
    not (notA[15], A[15]);
    not (notA[16], A[16]);
    not (notA[17], A[17]);
    not (notA[18], A[18]);
    not (notA[19], A[19]);
    not (notA[20], A[20]);
    not (notA[21], A[21]);
    not (notA[22], A[22]);
    not (notA[23], A[23]);
    not (notA[24], A[24]);
    not (notA[25], A[25]);
    not (notA[26], A[26]);
    not (notA[27], A[27]);
    not (notA[28], A[28]);
    not (notA[29], A[29]);
    not (notA[30], A[30]);
    not (notA[31], A[31]);

    // + 1
    fullAdder addOne (
        .A   (notA),
        .B   (32'd1),
        .sum (out),
        .cout(cout)
    );

endmodule
