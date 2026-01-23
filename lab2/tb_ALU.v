`timescale 1ns / 1ps
//============================================================
// Testbench: tb_ALU
//  ADD     : out = A + B
//  SUB     : out = A - B
//  NEGATE  : out = -A
//  PASS A  : out = A
//  Z = 1 when out == 0
//  N = 1 when out is negative
//============================================================
module tb_ALU;

    // regs store data
    reg [31:0] A;
    reg [31:0] B;
    reg add;
    reg neg;
    reg sub;

    // wires connect modules
    wire [31:0] out;
    wire Z;
    wire N;

    // instantiate the ALU
    ALU dut (
        .A   (A),
        .B   (B),
        .add (add),
        .neg (neg),
        .sub (sub),
        .out (out),
        .Z   (Z),
        .N   (N)
    );

    // run once
    initial begin
    
        // neg = 0 → use A
        // neg = 1 → use −A

        
        // Case 1: ADD
        // A + B = 4 + 3 = 7
        // add=0, neg=0, sub=0
        A   = 32'd4;
        B   = 32'd3;
        add = 0;
        neg = 0;
        sub = 0;
        #10;

        // Case 2: SUBTRACT
        // A - B = 5 - 3 = 2
        // add=1, neg=0, sub=1
        A   = 32'd5;
        B   = 32'd3;
        add = 1;
        neg = 0;
        sub = 1;
        #10;

        // Case 3: NEGATE
        // -A = -5
        // add=1, neg=1, sub=0
        A   = 32'd5;
        B   = 32'd0;
        add = 1;
        neg = 1;
        sub = 0;
        #10;

        // Case 4: PASS or RETURN A
        // out = A
        // add=1, neg=1, sub=1
        A   = 32'd5;
        B   = 32'd0;
        add = 1;
        neg = 0;
        sub = 1;
        #10;

        // Case 5: ZERO flag
        // A - A = 0 → Z = 1
        A   = 32'd5;
        B   = 32'd5;
        add = 1;
        neg = 0;
        sub = 1;
        #10;

        // Case 6: NEGATIVE flag
        // A - B = 1 - 2 = -1 → N = 1
        A   = 32'd2;
        B   = 32'd3;
        add = 1;
        neg = 0;
        sub = 1;
        #10;

        // end simulation
        $finish;
    end

endmodule
