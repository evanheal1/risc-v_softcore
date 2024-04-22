`timescale 1ns / 1ps

module controller(op,funct3,funct7_b5,zero,pc_src,result_src,mem_write,alu_src,reg_write,alu_control,imm_src);

input [6:0] op;
input [2:0] funct3;
input funct7_b5,zero;
output pc_src, result_src, mem_write, alu_src, reg_write;
output [2:0] alu_control;
output [1:0] imm_src;

wire [1:0] alu_op;
wire branch;

// module main_decoder(op,branch,result_src,mem_write,alu_src,imm_src,reg_write,alu_op);
main_decoder MainDec(
    .op(op),
    .branch(branch),
    .result_src(result_src), 
    .mem_write(mem_write),  
    .alu_src(alu_src), 
    .reg_write(reg_write), 
    .imm_src(imm_src), 
    .alu_op(alu_op)
);

// module alu_decoder(op_b5,funct3,funct7_b5,alu_op,alu_control);
alu_decoder ALUDec(
    .op_b5(op[4]), 
    .funct3(funct3), 
    .funct7_b5(funct7_b5), 
    .alu_op(alu_op), 
    .alu_control(alu_control)
);

assign pc_src = (branch & zero); // | jump;

endmodule
