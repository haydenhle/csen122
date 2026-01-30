`timescale 1ns / 1ps

// Testbench for Data Memory
module tb_dataMemory;

    // testbench signals
    logic clk;
    logic read;
    logic wrt;
    logic [31:0] address;
    logic [31:0] data_in;
    logic [31:0] data_out;

    // instantiate the data memory
    dataMemory dut (
        .clk(clk),
        .read(read),
        .wrt(wrt),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    // clock gen
    // clock toggles every 5 ns -> 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // test sequence
    initial begin
        // initialize signals to 0
        read    = 0;
        wrt     = 0;
        address = 32'd0;
        data_in = 32'd0;

        // wait one cycle
        #10;

        // write 20 into addr 8
        wrt = 1;
        address = 32'd8;
        data_in = 32'd20;
        #10;

        // disable write
        wrt = 0;
        #10;

        // read val in addr 8
        read = 1;
        address = 32'd8;
        #10;

        // disable read
        read = 0;
        #10;

        // finish simulation
        $finish;
    end

endmodule
