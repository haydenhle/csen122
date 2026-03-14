`timescale 1ns / 1ps

module MEM_WB(
    input wire clk,
    input wire reset,

    // DATA IN
    input wire [31:0] mem_data_in,
    input wire [31:0] alu_result_in,
    input wire [5:0]  rd_in,

    // CONTROL IN
    input wire RegWrite_in,
    input wire MemToReg_in,

    // DATA OUT
    output reg [31:0] mem_data_out,
    output reg [31:0] alu_result_out,
    output reg [5:0]  rd_out,

    // CONTROL OUT
    output reg RegWrite_out,
    output reg MemToReg_out
);

always @(posedge clk) begin
    if (reset) begin
        mem_data_out  <= 0;
        alu_result_out<= 0;
        rd_out        <= 0;
        RegWrite_out  <= 0;
        MemToReg_out  <= 0;
    end
    else begin
        mem_data_out  <= mem_data_in;
        alu_result_out<= alu_result_in;
        rd_out        <= rd_in;
        RegWrite_out  <= RegWrite_in;
        MemToReg_out  <= MemToReg_in;
    end
end

endmodule