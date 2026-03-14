`timescale 1ns / 1ps

module ControlUnit (
    input  wire [3:0] opcode,

    // WB signals
    output reg RegWrite,
    output reg MemToReg,

    // M signals
    output reg MemRead,
    output reg MemWrite,
    output reg BranchZ,
    output reg BranchN,
    output reg Jump,

    // EX signals
    output reg ALUA_src,
    output reg ALUSrc,
    output reg [2:0] ALUop
);

always @(*) begin

    // initialize vals
    RegWrite = 0;
    MemToReg = 0;

    MemRead  = 0;
    MemWrite = 0;
    BranchZ   = 0;
    BranchN = 0;
    Jump     = 0;

    ALUA_src = 0;
    ALUSrc   = 0;
    ALUop    = 3'b000;  // default ADD

    // opcode cases
    case (opcode)

        4'b0000: begin
            // NOP
        end

        4'b0010: begin
            // ADD rd, rs, rt
            RegWrite = 1;
            ALUop = 3'b000; // ADD
        end

        4'b0011: begin
            // SUB rd, rs, rt
            RegWrite = 1;
            ALUop = 3'b001; // SUB
        end

        4'b0100: begin
            // NEG rd, rs
            RegWrite = 1;
            ALUop = 3'b010; // NEG
        end

        4'b0110: begin
            // INC rd, rs, imm
            RegWrite = 1;
            ALUSrc = 1;     // use imm
            ALUop = 3'b000; // ADD
        end

        4'b1000: begin
            // SVPC rd, imm
            RegWrite = 1;
            ALUA_src = 1;   // use PC
            ALUSrc = 1;     // use imm
            ALUop = 3'b000; // ADD
        end

        4'b1010: begin
            // LD rd, rs, imm
            RegWrite = 1;
            MemRead  = 1;
            ALUSrc   = 1;      // use imm
            ALUop    = 3'b000; // ADD (addr calc)
            MemToReg = 1;      // write memory data
        end

        4'b1011: begin
            // ST rs, rt, imm
            MemWrite = 1;
            ALUSrc   = 1;      // use imm
            ALUop    = 3'b000; // ADD (address calculation)
        end

        4'b1101: begin
            // J rs
            Jump = 1;
        end

        4'b1110: begin
            // BRZ rs
            BranchZ = 1;
            BranchN = 0;  // check Zero flag
        end

        4'b1111: begin
            // BRN rs
            BranchZ = 0;
            BranchN = 1;  // check Negative flag
        end

    endcase

end

endmodule
