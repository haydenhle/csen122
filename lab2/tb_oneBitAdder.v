`timescale 1ns / 1ps
//============================================================
// Testbench: tb_oneBitAdder
// Expected behavior:
//  Adds A, B, and cin
//  sum  = A ⊕ B ⊕ cin
//  cout = 1 when two or more inputs are 1
//============================================================
module tb_oneBitAdder;

    // regs store data
    reg A;
    reg B;
    reg cin;

    // wires connect modules
    wire sum;
    wire cout;

    // instantiate the adder
    oneBitAdder dut (
        .A(A),
        .B(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // run once
    initial begin
        // Case 1: A=0, B=0, cin=0
        A = 0; B = 0; cin = 0; 
        #10;

        // Case 2: A=0, B=0, cin=1
        A = 0; B = 0; cin = 1; 
        #10;

        // Case 3: A=0, B=1, cin=0
        A = 0; B = 1; cin = 0; 
        #10;

        // Case 4: A=0, B=1, cin=1
        // sum = 1
        A = 0; B = 1; cin = 1; 
        #10;

        // Case 5: A=1, B=0, cin=0
        A = 1; B = 0; cin = 0; 
        #10;

        // Case 6: A=1, B=0, cin=1
        // sum = 1
        A = 1; B = 0; cin = 1; 
        #10;

        // Case 7: A=1, B=1, cin=0
        A = 1; B = 1; cin = 0; 
        #10;

        // Case 8: A=1, B=1, cin=1
        // sum = 1
        A = 1; B = 1; cin = 1; 
        #10;

        $finish;
    end

endmodule
