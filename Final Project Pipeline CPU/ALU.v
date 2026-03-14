`timescale 1ns / 1ps

module ALU(
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [2:0]  ALUop,

    output reg  [31:0] result,
    output wire        Zero,
    output wire        Neg
);

always @(*) begin
    case (ALUop)

        3'b000:  // ADD
            result = A + B;

        3'b001:  // SUB
            result = A - B;

        3'b010:  // NEG
            result = -A;

        default:
            result = 32'b0;

    endcase
end

assign Zero = (result == 32'b0);
assign Neg  = result[31];

endmodule