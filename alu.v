`timescale 1ns / 1ps

module alu(a,b,alu_control,result,zero);

input [31:0]a,b;
input [2:0]alu_control;
output zero;
output reg [31:0]result;

always @(*) 
begin
    case(alu_control)
        3'b000: result = a + b;     // Addition
        3'b001: result = a - b;     // Subtraction
        3'b111: result = a & b;     // Bitwise AND
        3'b011: result = a | b;     // Bitwise OR
        3'b101: 
        begin                       // Set Less Than (signed comparison)
            if (a < b)
                result = 32'h1;     // Set result to 1 if a < b
            else
                result = 32'h0;     // Otherwise, set result to 0
        end
        default: result = 32'b0;     // Default case (zero output)
    endcase
end

assign zero = (result == 0);

endmodule
