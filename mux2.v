`timescale 1ns / 1ps

module mux2 #(parameter WIDTH = 8)(in0,in1,en,out);

input [WIDTH-1:0] in0,in1;
input en;
output reg [WIDTH-1:0] out;

always @(*) 
begin
    if(en)
        out = in1;
    else
        out = in0;
end
                
endmodule

