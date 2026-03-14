`timescale 1ns / 1ps

module tb_scu_datapath;

    reg clock;
    reg reset;

    // DUT debug outputs
    wire [31:0] debug_pc;
    wire [31:0] debug_if_instr;
    wire [31:0] debug_reg_data1;
    wire [31:0] debug_reg_data2;
    wire [31:0] debug_imm;
    wire [31:0] debug_alu_result;
    wire        debug_zero;
    wire        debug_neg;
    wire        debug_branch_taken;
    wire        debug_RegWrite;
    wire        debug_MemRead;
    wire        debug_MemWrite;
    wire        debug_Branch;
    wire        debug_ALUSrc;

    // Instantiate DUT
    scu_datapath DUT (
        .clock(clock),
        .reset(reset),
        .debug_pc(debug_pc),
        .debug_if_instr(debug_if_instr),
        .debug_reg_data1(debug_reg_data1),
        .debug_reg_data2(debug_reg_data2),
        .debug_imm(debug_imm),
        .debug_alu_result(debug_alu_result),
        .debug_zero(debug_zero),
        .debug_neg(debug_neg),
        .debug_branch_taken(debug_branch_taken),
        .debug_RegWrite(debug_RegWrite),
        .debug_MemRead(debug_MemRead),
        .debug_MemWrite(debug_MemWrite),
        .debug_Branch(debug_Branch),
        .debug_ALUSrc(debug_ALUSrc)
    );

    integer cycle;

    // Clock: 10 ns period
    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end

    // Reset
    initial begin
        reset = 1'b1;
        cycle = 0;
        #20;
        reset = 1'b0;
    end

    // Header
    initial begin
        $display("==============================================================================================================");
        $display("cyc time   pc  nxt  instr   ifid   rs   rt   imm   aluRes  Z N  BrT  RegW MemR MemW Branch ALUSrc Jump");
        $display("==============================================================================================================");
    end

//    // Per-cycle print
//    always @(posedge clock) begin
//        #1;
//        if (!reset) begin
//            cycle = cycle + 1;
//            $display("%3d %4t %4d %4d %6d %6d %4d %4d %4d %7d  %b %b   %b    %b    %b    %b     %b      %b     %b",
//                cycle,
//                $time,
//                DUT.pc_current,
//                DUT.pc_next,
//                DUT.instruction,
//                DUT.if_id_instr,
//                DUT.reg_data1,
//                DUT.reg_data2,
//                DUT.imm_ext,
//                DUT.alu_result,
//                DUT.zero_flag,
//                DUT.neg_flag,
//                DUT.branch_taken,
//                DUT.RegWrite,
//                DUT.MemRead,
//                DUT.MemWrite,
//                DUT.Branch,
//                DUT.ALUSrc,
//                DUT.idex_Jump
//            );
//        end
//    end

//    // PC redirect detector
//    always @(posedge clock) begin
//        #1;
//        if (!reset && (DUT.pc_next != DUT.pc_plus1)) begin
//            $display(">>> REDIRECT t=%0t  pc=%0d  pc_plus1=%0d  pc_next=%0d  jump=%b  branch=%b  branch_only=%b  target=%0d",
//                $time,
//                DUT.pc_current,
//                DUT.pc_plus1,
//                DUT.pc_next,
//                DUT.idex_Jump,
//                DUT.idex_Branch,
//                DUT.branch_only,
//                DUT.idex_rs
//            );
//        end
//    end

//    // Memory events
//    always @(posedge clock) begin
//        #1;
//        if (!reset && DUT.exmem_MemRead) begin
//            $display(">>> MEM READ  t=%0t  addr=%0d  data=%0d",
//                $time,
//                DUT.exmem_alu_result,
//                DUT.mem_read_data
//            );
//        end

//        if (!reset && DUT.exmem_MemWrite) begin
//            $display(">>> MEM WRITE t=%0t  addr=%0d  data=%0d",
//                $time,
//                DUT.exmem_alu_result,
//                DUT.exmem_rt_data
//            );
//        end
//    end

//    // Writeback events
//    always @(posedge clock) begin
//        #1;
//        if (!reset && DUT.memwb_RegWrite) begin
//            $display(">>> WB t=%0t  rd=x%0d  data=%0d  MemToReg=%b",
//                $time,
//                DUT.memwb_rd,
//                DUT.writeback_data,
//                DUT.memwb_MemToReg
//            );
//        end
//    end

    // Final register dump
    initial begin
        #1750;
        $display("==============================================================================================================");
        $display("FINAL REGISTER VALUES");
        $display("x1  = %0d", DUT.RegFile_inst.regfile[1]);
        $display("x2  = %0d", DUT.RegFile_inst.regfile[2]);
        $display("x3  = %0d", DUT.RegFile_inst.regfile[3]);
        $display("x4  = %0d", DUT.RegFile_inst.regfile[4]);
        $display("x5  = %0d", DUT.RegFile_inst.regfile[5]);
        $display("x6  = %0d", DUT.RegFile_inst.regfile[6]);
        $display("x7  = %0d", DUT.RegFile_inst.regfile[7]);
        $display("x8  = %0d", DUT.RegFile_inst.regfile[8]);
        $display("x9  = %0d", DUT.RegFile_inst.regfile[9]);
        $display("x10 = %0d", DUT.RegFile_inst.regfile[10]);
        $display("==============================================================================================================");
        $finish;
    end

endmodule