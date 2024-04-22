`timescale 1ns / 1ps

module main_decoder(op,branch,result_src,mem_write,alu_src,imm_src,reg_write,alu_op);

input [6:0] op;
output reg branch;
output reg result_src;
output reg mem_write;
output reg alu_src;
output reg [1:0] imm_src;
output reg reg_write;
output reg [1:0] alu_op;

//output reg jump;

reg [8:0] control_values;

always @* 
begin
    case(op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp
        7'b0000011: control_values = 9'b1_00_1_0_1_0_00;          // lw      
        7'b0100011: control_values = 9'b0_01_1_1_x_0_00;          // sw
        7'b0110011: control_values = 9'b1_xx_0_0_0_0_10;          // R-type
        7'b1100011: control_values = 9'b0_10_0_0_x_1_01;          // beq
        //7'b0010011: control_values = 11'b1_00_1_0_00_0_10_0;  // I-type ALU
        //7'b1101111: control_values = 11'b1_11_0_0_10_0_00_1;  // jal
        default: control_values = 11'bx_xx_x_x_xx_x_xx_x;
    endcase

    {reg_write, imm_src, alu_src, mem_write, result_src, branch, alu_op} = control_values;
end

endmodule

