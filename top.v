`timescale 1ns / 1ps

module top(clk, reset, pc, read_data, instr);

input wire clk, reset;
output wire [31:0] pc, read_data, instr;
//output wire alu_src, result_src, pc_src, zero;

wire [31:0] alu_result, read_data1, read_data2, 
imm_extend, write_data_in, pc_plus4, alu_mux_result, pc_target, pc_next, result;

wire mem_write, reg_write, alu_src, result_src, pc_src, zero;
wire [1:0] imm_src;
wire [2:0] alu_control;

// Program Counter
// module flip_flop  #(parameter WIDTH = 8) (clk,reset,d,q);
flip_flop #(32) PCReg(
    .clk(clk), 
    .reset(reset), 
    .d(pc_next), 
    .q(pc)
);

// module instruction_memory(a, rd);
instruction_memory InstrMem(
    .a(pc),
    .rd(instr)
);

// module register_file(clk,we3,a1,a2,a3,wd3,rd1,rd2);
register_file RegFile(
    .clk(clk), 
    .we3(reg_write), 
    .a1(instr[19:15]), 
    .a2(instr[24:20]), 
    .a3(instr[11:7]), 
    .wd3(result), 
    .rd1(read_data1), 
    .rd2(read_data2)
);

// module sign_extend(instr,imm_src,imm_extend);
sign_extend SignExt(
    .instr(instr), 
    .imm_src(imm_src), 
    .imm_extend(imm_extend)
    );


// module alu(a,b,alu_control,result,zero);
alu ALU(
    .a(read_data1), 
    .b(alu_mux_result), 
    .alu_control(alu_control), 
    .result(alu_result), 
    .zero(zero)
    );

// module data_memory(clk, we, a, wd, rd);
data_memory DataMem(
    .clk(clk),
    .we(mem_write),
    .a(alu_result),
    .wd(read_data2),
    .rd(read_data)
);

// module adder(a, b, y);
adder PCadd4(pc, 32'd4, pc_plus4);
adder PCaddBranch(pc, imm_extend, pc_target);

// module mux2 #(parameter WIDTH = 8)(in0,in1,en,out);
mux2 #(32) ALUMux(read_data2, imm_extend, alu_src, alu_mux_result);
mux2 #(32) ResultMux(alu_result, read_data, result_src, result);
mux2 #(32) PCMux(pc_plus4, pc_target, pc_src, pc_next);

// module controller(op,funct3,funct7_b5,zero,pc_src,result_src,mem_write,alu_src,reg_write,alu_control,imm_src);
controller ControlUnit(
    .op(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7_b5(instr[30]),
    .zero(zero),
    .pc_src(pc_src),    
    .result_src(result_src),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .alu_control(alu_control),
    .imm_src(imm_src)
    );

endmodule
