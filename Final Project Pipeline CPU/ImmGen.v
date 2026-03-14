`timescale 1ns / 1ps

module ImmGen (
    input  wire [9:0] imm_in,
    output wire [31:0] imm_out
);

// sign extend
// imm_in[15] = sign bit
// 16{} = replicate 16 times 
// then concatenate with itself after extension
assign imm_out = {{22{imm_in[9]}}, imm_in};

endmodule