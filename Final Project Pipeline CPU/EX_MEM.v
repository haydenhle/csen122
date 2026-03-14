`timescale 1ns / 1ps

module EX_MEM(
    input wire clk,
    input wire reset,

    // DATA IN
    input wire [31:0] alu_result_in,
    input wire [31:0] rt_data_in,
    input wire [5:0]  rd_in,

    // CONTROL IN
    input wire RegWrite_in,
    input wire MemToReg_in,
    input wire MemRead_in,
    input wire MemWrite_in,

    // DATA OUT
    output reg [31:0] alu_result_out,
    output reg [31:0] rt_data_out,
    output reg [5:0]  rd_out,

    // CONTROL OUT
    output reg RegWrite_out,
    output reg MemToReg_out,
    output reg MemRead_out,
    output reg MemWrite_out
);

always @(posedge clk) begin
    if (reset) begin
        alu_result_out <= 0;
        rt_data_out    <= 0;
        rd_out         <= 0;
        RegWrite_out   <= 0;
        MemToReg_out   <= 0;
        MemRead_out    <= 0;
        MemWrite_out   <= 0;
    end
    else begin
        alu_result_out <= alu_result_in;
        rt_data_out    <= rt_data_in;
        rd_out         <= rd_in;
        RegWrite_out   <= RegWrite_in;
        MemToReg_out   <= MemToReg_in;
        MemRead_out    <= MemRead_in;
        MemWrite_out   <= MemWrite_in;
    end
end

endmodule