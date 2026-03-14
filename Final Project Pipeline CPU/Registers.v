`timescale 1ns / 1ps

module Registers(
    input  wire        clk,
    input  wire        reset,

    input  wire [5:0]  rs,
    input  wire [5:0]  rt,
    input  wire [5:0]  rd,

    input  wire [31:0] write_data,
    input  wire        RegWrite,

    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    reg [31:0] regfile [0:63];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 64; i = i + 1)
                regfile[i] <= 32'b0;

            // ===== DEMO INITIALIZATION =====
            regfile[2] <= 32'd2;   // x2 = base array address
            regfile[1] <= 32'd7;   // x1 = n
        end
        else begin
            if (RegWrite && rd != 6'd0)
                regfile[rd] <= write_data;
                
            read_data1 = regfile[rs];
            read_data2 = regfile[rt];
        end
    end

endmodule