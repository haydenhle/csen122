`timescale 1ns / 1ps

module IF_ID (
    input  wire        clk,
    input  wire        reset,

    input  wire [31:0] instr_in,
    input  wire [31:0] pc_in,

    output reg  [31:0] instr_out,
    output reg  [31:0] pc_out
);

always @(negedge clk) begin
    if (reset) begin
        instr_out <= 32'b0;
        pc_out    <= 32'b0;
    end
    else begin
        instr_out <= instr_in;
        pc_out    <= pc_in;
    end
end

endmodule
