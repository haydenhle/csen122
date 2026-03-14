`timescale 1ns / 1ps

module InstructionMemory(
    input clk,
    input  wire [31:0] address,
    output reg  [31:0] instruction
);

reg [31:0] Instr [0:255];
integer i;

initial begin

    for (i = 0; i < 256; i = i + 1) begin
        Instr[i] = 32'b0000000000_000000_000000_000000_0000;
    end

    // ============================
    // PROGRAM START
    // ============================

    // ADD x4, x0, x0
    Instr[0] = 32'b0000000000_000100_000000_000000_0010;

    Instr[1] = 0; Instr[2] = 0; Instr[3] = 0;

    // LD x3, x2, 0
    Instr[4] = 32'b0000000000_000011_000010_000000_1010;

    Instr[5] = 0; Instr[6] = 0; Instr[7] = 0;

    // INC x4
    Instr[8] = 32'b0000000001_000100_000100_000000_0110;

    Instr[9] = 0; Instr[10] = 0; Instr[11] = 0;

    // ============================
    // SVPC x8 (LOOP)
    // PC=12 → PC+1=13
    // target = 30
    // imm = 30 - 13 = 17
    // FIX: subtract 1 → imm = 18
    // ============================
    Instr[12] = 32'b0000010010_001000_000000_000000_1000;

    Instr[13] = 0; Instr[14] = 0; Instr[15] = 0; Instr[16] = 0; Instr[17] = 0;

    // ============================
    // SVPC x9 (DONE)
    // PC=18 → PC+1=19
    // target = 49
    // imm = 57 - 19 = 38
    // FIX: subtract 1 → imm = 31
    // ============================
    Instr[18] = 32'b0000011111_001001_000000_000000_1000;

    Instr[19] = 0; Instr[20] = 0; Instr[21] = 0; Instr[22] = 0; Instr[23] = 0;

    // ============================
    // SVPC x10 (SKIP)
    // PC=24 → PC+1=25
    // target = 44
    // imm = 44 - 25 = 27
    // FIX: subtract 1 → imm = 20
    // ============================
    Instr[24] = 32'b0000010100_001010_000000_000000_1000;

    Instr[25] = 0; Instr[26] = 0; Instr[27] = 0; Instr[28] = 0; Instr[29] = 0;

    // ============================
    // LOOP (index 30)
    // ============================

    // SUB x7, x4, x1
    Instr[30] = 32'b0000000000_000111_000100_000001_0011;

    // BRZ x9
    Instr[31] = 32'b0000000000_000000_001001_000000_1110;

    // ADD x5, x2, x4
    Instr[32] = 32'b0000000000_000101_000010_000100_0010;

    Instr[33] = 0; Instr[37] = 0; Instr[38] = 0;

    // LD x6, x5, 0
    Instr[34] = 32'b0000000000_000110_000101_000000_1010;

    Instr[35] = 0; Instr[36] = 0; Instr[37] = 0;

    // SUB x7, x6, x3
    Instr[38] = 32'b0000000000_000111_000110_000011_0011;

    // BRN x10
    Instr[39] = 32'b0000000000_000000_001010_000000_1111;

    // ADD x3, x6, x0
    Instr[40] = 32'b0000000000_000011_000110_000000_0010;

    Instr[41] = 0; Instr[42] = 0; Instr[43] = 0;

    // SKIP (index 44)
    Instr[44] = 32'b0000000001_000100_000100_000000_0110;

    Instr[45] = 0; Instr[46] = 0; Instr[47] = 0;

    // J x8
    // rs = 001000 (x8)
    Instr[48] = 32'b0000000000_000000_001000_000000_1101;

    // DONE (index 49)
    // NOP
    Instr[49] = 32'b0000000000_000000_001001_000000_0000;
    
    // NEG x3, x3 (negate max result)
    Instr[50] = 32'b0000000000_000011_000011_000000_0100;
    
    Instr[51] = 0; Instr[52] = 0; Instr[53] = 0;
    
    // ST x3, x2, 0 (store negated redult into address 2)
    Instr[54] = 32'b0000000000_000000_000010_000011_1011;

end

always @(posedge clk) begin
    if (address < 256)
        instruction = Instr[address];
    else
        instruction = 32'b0;
end

endmodule