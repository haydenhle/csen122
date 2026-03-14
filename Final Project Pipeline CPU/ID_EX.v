`timescale 1ns / 1ps

module ID_EX (
    input  wire clk,
    input  wire reset,

    // data inputs
    input  wire [31:0] rs_in,
    input  wire [31:0] rt_in,
    input  wire [31:0] imm_in,
    input  wire [5:0]  rd_in,
    input  wire [31:0] pc_in,

    // control inputs
    input  wire RegWrite_in,
    input  wire MemToReg_in,
    input  wire MemRead_in,
    input  wire MemWrite_in,
    input  wire Branch_in,
    input  wire CheckNeg_in,
    input  wire Jump_in,
    input  wire ALUA_src_in,
    input  wire ALUSrc_in,
    input  wire [2:0] ALUop_in,

    // data outputs
    output reg [31:0] rs_out,
    output reg [31:0] rt_out,
    output reg [31:0] imm_out,
    output reg [5:0]  rd_out,
    output reg [31:0] pc_out,

    // control outputs
    output reg RegWrite_out,
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg Branch_out,
    output reg CheckNeg_out,
    output reg Jump_out,
    output reg ALUA_src_out,
    output reg ALUSrc_out,
    output reg [2:0] ALUop_out
);

always @(negedge clk) begin
    if (reset) begin
        rs_out <= 0;
        rt_out <= 0;
        imm_out <= 0;
        rd_out <= 0;
        pc_out <= 0;

        RegWrite_out <= 0;
        MemToReg_out <= 0;
        MemRead_out  <= 0;
        MemWrite_out <= 0;
        Branch_out   <= 0;
        CheckNeg_out <= 0;
        Jump_out     <= 0;
        ALUA_src_out <= 0;
        ALUSrc_out   <= 0;
        ALUop_out    <= 0;
    end
    else begin
        rs_out <= rs_in;
        rt_out <= rt_in;
        imm_out <= imm_in;
        rd_out <= rd_in;
        pc_out <= pc_in;

        RegWrite_out <= RegWrite_in;
        MemToReg_out <= MemToReg_in;
        MemRead_out  <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        Branch_out   <= Branch_in;
        CheckNeg_out <= CheckNeg_in;
        Jump_out     <= Jump_in;
        ALUA_src_out <= ALUA_src_in;
        ALUSrc_out   <= ALUSrc_in;
        ALUop_out    <= ALUop_in;
    end
end

endmodule