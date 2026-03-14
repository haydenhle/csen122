`timescale 1ns / 1ps

module BranchLogic (
    input  wire Branch,      // 1 if instruction is BRZ or BRN
    input  wire CheckNeg,    // 0 = check Z flag, 1 = check N flag
    input  wire Jump,        // 1 if instruction is J
    input  wire Z_flag,      // from Z register
    input  wire N_flag,      // from N register

    output wire PCSrc        // 1 = take branch or jump
);

    wire check_zero;
    wire check_negative;
    wire BranchTaken;

    // make the logical gates for branch with assign

    // if checkNeg = 0 → check Zero flag
    assign check_zero     = (~CheckNeg) & Z_flag;

    // if checkNeg = 1 → check Negative flag
    assign check_negative = (CheckNeg) & N_flag;

    // conditional branch decision
    assign BranchTaken = Branch & (check_zero | check_negative);

    // final PC selection (jump takes prio over branch)
    assign PCSrc = Jump | BranchTaken;

endmodule
