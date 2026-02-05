`timescale 1ns / 1ps

module tb_if_id_buffer;

    logic clock;
    logic reset;
    logic [31:0] instr_in;
    logic [31:0] pc_in;
    logic [31:0] instr_out;
    logic [31:0] pc_out;

    // instantiate
    if_id_buffer dut (
        .clock(clock),
        .reset(reset),
        .instr_in(instr_in),
        .pc_in(pc_in),
        .instr_out(instr_out),
        .pc_out(pc_out)
    );

    // start clock
    initial begin
        clock = 1'b1;
        forever #5 clock = ~clock;
    end

    // test seq
    initial begin
        // initialize
        reset = 1'b1;
        instr_in = 32'd0;
        pc_in = 32'd0;

        #10;

        // reset
        reset = 1'b0;

        // insert first instruction
        instr_in = 32'd5;
        pc_in = 32'd4;

        #10;

        //insert next input
        instr_in = 32'd10;
        pc_in = 32'd8;

        #10;

        // reset again
        reset = 1'b1;

        #10;

        $finish;
    end

endmodule

