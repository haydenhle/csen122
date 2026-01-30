`timescale 1ns / 1ps
// Instruction Memory Module
// store 256 instructions, 32 bits wide.
module instructionMemory (
    input  logic        clk,         // clock signal
    input  logic [7:0]  address,     // 8 bit addr selects 1 of 256 instructions
    output logic [31:0] instruction  // 32 bit instruction output
);

    // instruction memory array
    // 256 slots
    // 32 bits wide
    logic [31:0] mem [0:255];
    
    // initialize i
    integer i;

    // run once
    // hardcode instruction values into mem
    initial begin
        mem[0] = 32'h00000001;
        mem[1] = 32'h00000002;
        mem[2] = 32'h00000003;
        mem[3] = 32'h00000004;
        mem[4] = 32'h00000005;
        mem[5] = 32'h00000006;
        mem[6] = 32'h00000007;
        mem[7] = 32'h00000008;

        // initialize everything else to 0 just in case
        for (i = 8; i < 256; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end

    // always block triggers on the rising edge of clock
    // instruction output updates once per clock cycle
    always @(posedge clk) begin
        // read instruction stored at given addr
        instruction <= mem[address];
    end

endmodule

