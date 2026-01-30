`timescale 1ns / 1ps
// Data Memory Module
// store data values, 32 bits wide
// uses lower 16 bits of address (65536 spots)
module dataMemory (
    input  logic        clk,        // clock signal
    input  logic        read,       // read enable
    input  logic        wrt,        // write enable
    input  logic [31:0] address,    // 32 bit address (use lower 16 bits)
    input  logic [31:0] data_in,    // data to write into memory
    output logic [31:0] data_out    // data read from memory
);

    // data memory array
    // 65536 spots
    // 32 bits wide
    logic [31:0] mem [0:65535];

    // loop variable for initialization
    integer i;

    // run once
    // initialize all memory locations to 0 just in case
    initial begin
        for (i = 0; i < 65536; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end

    // always block triggers on the rising edge of clock
    always @(posedge clk) begin
        // if write is enabled, write data_in to memory
        // use only lower 16 bits of address
        if (wrt) begin
            mem[address[15:0]] <= data_in;
        end

        // if read is enabled, read data from memory
        if (read) begin
            data_out <= mem[address[15:0]];
        end
    end

endmodule
