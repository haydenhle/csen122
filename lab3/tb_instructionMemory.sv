`timescale 1ns / 1ps
// testbench for instructionMemory
module tb_instructionMemory;

    // testbench signals
    logic        clk;
    logic [7:0]  address;
    logic [31:0] instruction;

    // instantiate instruction memory
    instructionMemory dut (
        .clk(clk),
        .address(address),
        .instruction(instruction)
    );

    // clock gen
    // clock toggles every 5 ns -> 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // test sequence
    initial begin
        // initialize address
        address = 8'd0;

        // wait one cycle
        #10;

        // read instruction at address 0
        address = 8'd0;
        #10;

        // read instruction at address 1
        address = 8'd1;
        #10;

        // read instruction at address 2
        address = 8'd2;
        #10;

        // read instruction at address 3
        address = 8'd3;
        #10;

        // read instruction at address 4
        address = 8'd4;
        #10;

        // read instruction at address 5
        address = 8'd5;
        #10;

        // read instruction at address 6
        address = 8'd6;
        #10;

        // read instruction at address 7
        address = 8'd7;
        #10;

        // finish simulation
        $finish;
    end

endmodule
