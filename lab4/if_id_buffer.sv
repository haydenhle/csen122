`timescale 1ns / 1ps

module if_id_buffer (
    input  logic        clock,
    input  logic        reset,

    // IF stage inputs
    input  logic [31:0] instr_in,
    input  logic [31:0] pc_in, // program counter of next addr 4 bits over

    // ID stage outputs
    output logic [31:0] instr_out,
    output logic [31:0] pc_out // program counter of next addr 4 bits over
);

    // update on neg edge for pipelines
    always @(negedge clock) begin
        // set 0 on reset
        if (reset) begin
            instr_out  <= 32'd0;
            pc_out  <= 32'd0;
        // input vals
        end else begin
            instr_out  <= instr_in;
            pc_out  <= pc_in;
        end
    end

endmodule

