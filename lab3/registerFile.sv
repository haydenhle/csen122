`timescale 1ns / 1ps
// Register File Module
// stores 64 registers, each 32 bits wide
module registerFile (
    input  logic        clk,        // clock signal
    input  logic        wrt,        // write enable
    input  logic [5:0]  rd,         // write register address
    input  logic [5:0]  rs,         // read register 1 address
    input  logic [5:0]  rt,         // read register 2 address
    input  logic [31:0] data_in,    // data to write into register
    output logic [31:0] rs_out,     // data from rs register
    output logic [31:0] rt_out      // data from rt register
);

    // register file array
    // 64 registers
    // 32 bits wide
    logic [31:0] regs [0:63];

    // loop variable for initialization
    integer i;

    // run once
    // initialize all registers to 0 just in case
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            regs[i] = 32'h00000000;
        end
    end

    // always block triggers on the rising edge of clock
    always @(posedge clk) begin
        // if write is enabled, write data_in to register rd
        if (wrt) begin
            regs[rd] <= data_in;
        end

        // read values from registers rs and rt
        rs_out <= regs[rs];
        rt_out <= regs[rt];
    end

endmodule
