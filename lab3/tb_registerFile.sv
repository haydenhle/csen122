`timescale 1ns / 1ps
// testbench for Register File
module tb_registerFile;

    // testbench signals
    logic        clk;
    logic        wrt;
    logic [5:0]  rs;
    logic [5:0]  rt;
    logic [5:0]  rd;
    logic [31:0] data_in;
    logic [31:0] rs_out;
    logic [31:0] rt_out;

    // instantiate register file
    registerFile dut (
        .clk(clk),
        .wrt(wrt),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .data_in(data_in),
        .rs_out(rs_out),
        .rt_out(rt_out)
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
        wrt     = 0;
        rs      = 6'd0;
        rt      = 6'd0;
        rd      = 6'd0;
        data_in = 32'd0;

        // wait one cycle
        #10;

        // 0x00000001 into rs1
        wrt     = 1;
        rd      = 6'd1;
        data_in = 32'd1;
        #10;

        // 0x00000002 into rs2
        rd      = 6'd2;
        data_in = 32'd2;
        #10;

        // 0x00000003 into rs3
        rd      = 6'd3;
        data_in = 32'd3;
        #10;

        // disable write
        wrt = 0;
        #10;


        // read in batches of 2 since rs and rt out 
        // read registers 1 and 2
        rs = 6'd1;
        rt = 6'd2;
        #10;

        // read registers 2 and 3
        rs = 6'd2;
        rt = 6'd3;
        #10;

        // read registers 1 and 3
        rs = 6'd1;
        rt = 6'd3;
        #10;

        // finish simulation
        $finish;
    end

endmodule
