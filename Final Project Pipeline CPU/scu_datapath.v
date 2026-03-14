`timescale 1ns / 1ps

module scu_datapath(
    input  wire clock,
    input  wire reset,

    // Debug Outputs
    output wire [31:0] debug_pc,
    output wire [31:0] debug_if_instr,
    output wire [31:0] debug_reg_data1,
    output wire [31:0] debug_reg_data2,
    output wire [31:0] debug_imm,
    output wire [31:0] debug_alu_result,
    output wire        debug_zero,
    output wire        debug_neg,
    output wire        debug_branch_taken,
    output wire        debug_RegWrite,
    output wire        debug_MemRead,
    output wire        debug_MemWrite,
    output wire        debug_Branch,
    output wire        debug_ALUSrc
);

////////////////////////////////////////////////////////////
// IF STAGE
////////////////////////////////////////////////////////////

wire [31:0] pc_current;
wire [31:0] pc_plus1;
wire [31:0] pc_next;
wire [31:0] instruction;

assign pc_plus1 = pc_current + 1;

PC PC_inst (
    .clk(clock),
    .reset(reset),
    .pc_next(pc_next),
    .pc(pc_current)
);

InstructionMemory IM_inst (
    .clk(clock),
    .address(pc_current),
    .instruction(instruction)
);

////////////////////////////////////////////////////////////
// IF/ID REGISTER  (FIX: store pc_current, not pc_plus1)
////////////////////////////////////////////////////////////

wire branch_taken;

wire [31:0] if_flush_instr =
    (branch_taken) ? 32'b0 : instruction;

wire [31:0] if_id_instr;
wire [31:0] if_id_pc;

IF_ID IF_ID_inst (
    .clk(clock),
    .reset(reset),
    .instr_in(if_flush_instr),
    .pc_in(pc_current),      // FIXED
    .instr_out(if_id_instr),
    .pc_out(if_id_pc)
);

////////////////////////////////////////////////////////////
// ID STAGE
////////////////////////////////////////////////////////////

wire RegWrite, MemToReg, MemRead, MemWrite;
wire Branch, BranchN, Jump;
wire ALUA_src, ALUSrc;
wire [2:0] ALUop;

ControlUnit CU_inst (
    .opcode(if_id_instr[3:0]),
    .RegWrite(RegWrite),
    .MemToReg(MemToReg),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .BranchZ(BranchZ),
    .BranchN(BranchN),
    .Jump(Jump),
    .ALUA_src(ALUA_src),
    .ALUSrc(ALUSrc),
    .ALUop(ALUop)
);

wire [31:0] reg_data1, reg_data2;

wire [31:0] writeback_data;
wire [5:0]  memwb_rd;
wire        memwb_RegWrite;

Registers RegFile_inst (
    .clk(clock),
    .reset(reset),
    .rs(if_id_instr[15:10]),
    .rt(if_id_instr[9:4]),
    .rd(memwb_rd),
    .write_data(writeback_data),
    .RegWrite(memwb_RegWrite),
    .read_data1(reg_data1),
    .read_data2(reg_data2)
);

wire [31:0] imm_ext;

ImmGen ImmGen_inst (
    .imm_in(if_id_instr[31:22]),
    .imm_out(imm_ext)
);

////////////////////////////////////////////////////////////
// ID/EX REGISTER (with flush)
////////////////////////////////////////////////////////////

wire flush = branch_taken;

wire [31:0] idex_rs, idex_rt, idex_imm, idex_pc;
wire [5:0]  idex_rd;
wire idex_RegWrite, idex_MemToReg, idex_MemRead, idex_MemWrite;
wire idex_BranchZ, idex_BranchN, idex_Jump;
wire idex_ALUA_src, idex_ALUSrc;
wire [2:0] idex_ALUop;

ID_EX ID_EX_inst (
    .clk(clock),
    .reset(reset),

    .rs_in(reg_data1),
    .rt_in(reg_data2),
    .imm_in(imm_ext),
    .rd_in(if_id_instr[21:16]),
    .pc_in(if_id_pc),

    .RegWrite_in(flush ? 0 : RegWrite),
    .MemToReg_in(flush ? 0 : MemToReg),
    .MemRead_in (flush ? 0 : MemRead),
    .MemWrite_in(flush ? 0 : MemWrite),
    .Branch_in  (flush ? 0 : BranchZ),
    .CheckNeg_in(flush ? 0 : BranchN),
    .Jump_in    (flush ? 0 : Jump),
    .ALUA_src_in(flush ? 0 : ALUA_src),
    .ALUSrc_in  (flush ? 0 : ALUSrc),
    .ALUop_in   (flush ? 3'b000 : ALUop),

    .rs_out(idex_rs),
    .rt_out(idex_rt),
    .imm_out(idex_imm),
    .rd_out(idex_rd),
    .pc_out(idex_pc),

    .RegWrite_out(idex_RegWrite),
    .MemToReg_out(idex_MemToReg),
    .MemRead_out(idex_MemRead),
    .MemWrite_out(idex_MemWrite),
    .Branch_out(idex_BranchZ),
    .CheckNeg_out(idex_BranchN),
    .Jump_out(idex_Jump),
    .ALUA_src_out(idex_ALUA_src),
    .ALUSrc_out(idex_ALUSrc),
    .ALUop_out(idex_ALUop)
);

////////////////////////////////////////////////////////////
// EX STAGE
////////////////////////////////////////////////////////////

wire [31:0] alu_A = (idex_ALUA_src) ? idex_pc : idex_rs;
wire [31:0] alu_B = (idex_ALUSrc)   ? idex_imm : idex_rt;

wire [31:0] alu_result;
wire zero_flag;
wire neg_flag;

ALU ALU_inst (
    .A(alu_A),
    .B(alu_B),
    .ALUop(idex_ALUop),
    .result(alu_result),
    .Zero(zero_flag),
    .Neg(neg_flag)
);

assign branch_taken = (BranchZ & zero_flag) | (BranchN & neg_flag);

assign pc_next =
    (Jump | branch_taken)    ? reg_data1:
                     pc_plus1;

////////////////////////////////////////////////////////////
// EX/MEM
////////////////////////////////////////////////////////////

wire [31:0] exmem_alu_result;
wire [31:0] exmem_rt_data;
wire [5:0]  exmem_rd;
wire exmem_RegWrite, exmem_MemToReg;
wire exmem_MemRead, exmem_MemWrite;

EX_MEM EX_MEM_inst(
    .clk(clock),
    .reset(reset),

    .alu_result_in(alu_result),
    .rt_data_in(idex_rt),
    .rd_in(idex_rd),

    .RegWrite_in(idex_RegWrite),
    .MemToReg_in(idex_MemToReg),
    .MemRead_in(idex_MemRead),
    .MemWrite_in(idex_MemWrite),

    .alu_result_out(exmem_alu_result),
    .rt_data_out(exmem_rt_data),
    .rd_out(exmem_rd),

    .RegWrite_out(exmem_RegWrite),
    .MemToReg_out(exmem_MemToReg),
    .MemRead_out(exmem_MemRead),
    .MemWrite_out(exmem_MemWrite)
);

////////////////////////////////////////////////////////////
// MEM
////////////////////////////////////////////////////////////

wire [31:0] mem_read_data;

DataMemory DM_inst(
    .clk(clock),
    .MemRead(exmem_MemRead),
    .MemWrite(exmem_MemWrite),
    .address(exmem_alu_result),
    .write_data(exmem_rt_data),
    .read_data(mem_read_data)
);

////////////////////////////////////////////////////////////
// MEM/WB
////////////////////////////////////////////////////////////

wire [31:0] memwb_mem_data;
wire [31:0] memwb_alu_result;
wire memwb_MemToReg;

MEM_WB MEM_WB_inst(
    .clk(clock),
    .reset(reset),

    .mem_data_in(mem_read_data),
    .alu_result_in(exmem_alu_result),
    .rd_in(exmem_rd),

    .RegWrite_in(exmem_RegWrite),
    .MemToReg_in(exmem_MemToReg),

    .mem_data_out(memwb_mem_data),
    .alu_result_out(memwb_alu_result),
    .rd_out(memwb_rd),

    .RegWrite_out(memwb_RegWrite),
    .MemToReg_out(memwb_MemToReg)
);

assign writeback_data =
    (memwb_MemToReg) ? memwb_mem_data :
                       memwb_alu_result;

////////////////////////////////////////////////////////////
// DEBUG
////////////////////////////////////////////////////////////

assign debug_pc            = pc_current;
assign debug_if_instr      = if_id_instr;
assign debug_reg_data1     = reg_data1;
assign debug_reg_data2     = reg_data2;
assign debug_imm           = imm_ext;
assign debug_alu_result    = alu_result;
assign debug_zero          = zero_flag;
assign debug_neg           = neg_flag;
assign debug_branch_taken  = branch_taken;
assign debug_RegWrite      = RegWrite;
assign debug_MemRead       = MemRead;
assign debug_MemWrite      = MemWrite;
assign debug_BranchZ        = BranchZ;
assign debug_ALUSrc        = ALUSrc;

endmodule