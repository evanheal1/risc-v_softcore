`timescale 1ns / 1ps

module alu_decoder(op_b5,funct3,funct7_b5,alu_op,alu_control);

input op_b5;
input [2:0] funct3;
input funct7_b5;
input [1:0] alu_op;
output reg [2:0] alu_control;

reg RtypeSub;

always @* 
begin
    RtypeSub = funct7_b5 & op_b5;

    case(alu_op)
        2'b00: alu_control = 3'b000; // addition
        2'b01: alu_control = 3'b001; // subtraction
        2'b10: 
        begin
            case(funct3)
                3'b000: 
                begin
                    if (RtypeSub)
                        alu_control = 3'b001;       // sub
                    else
                        alu_control = 3'b000;       // add, addi
                end
                3'b010: alu_control = 3'b101;       // slt, slti
                3'b110: alu_control = 3'b011;       // or, ori
                3'b111: alu_control = 3'b010;       // and, andi
                default: alu_control = 3'bxxx;      
            endcase
        end
        default: alu_control = 3'bxxx;
    endcase
end

endmodule
