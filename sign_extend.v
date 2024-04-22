`timescale 1ns / 1ps

module sign_extend(instr,imm_src,imm_extend);

input wire [31:0] instr;
input wire [1:0] imm_src;
output reg [31:0] imm_extend;

always @(*)
case(imm_src)
    // I-type
    2'b00: imm_extend = {{20{instr[31]}}, instr[31:20]};
    // S-type (stores)
    2'b01: imm_extend = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    // B-type (branches)
    2'b10: imm_extend = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    // J-type (jal)
    2'b11: imm_extend = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    default: imm_extend = 32'bx; // undefined
endcase

endmodule
