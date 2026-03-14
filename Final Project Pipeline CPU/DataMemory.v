`timescale 1ns / 1ps 

module DataMemory(
    input  wire        clk,
    input  wire        MemRead,
    input  wire        MemWrite,
    input  wire [31:0] address,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);

// 256 word memory
reg [31:0] memory [0:255];

integer i;

initial begin
    // initialize to 0
    for (i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;

    // ===============================
    // DEMO ARRAY (base address = 2)
    // [31, 1024, 9, -2048, 512, 0, -1]
    // ===============================

    memory[2] = 32'd31;
    memory[3] = 32'd1024;
    memory[4] = 32'd9;
    memory[5] = -32'd2048;
    memory[6] = 32'd512;
    memory[7] = 32'd0;
    memory[8] = -32'd1;
    
//    memory[2] = -3;
//    memory[3] = 2;
//    memory[4] = 12;
//    memory[5] = 4;
//    memory[6] = -3;
//    memory[7] = 50;
//    memory[8] = 6;
end

// Write (synchronous)
always @(posedge clk) begin
    if (MemWrite)
        memory[address] <= write_data;
    if (MemRead)
        read_data = memory[address];
    else
        read_data = 32'b0;
end

endmodule