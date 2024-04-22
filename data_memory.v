`timescale 1ns / 1ps

module data_memory(clk, we, a, wd, rd);

input wire clk, we;
input wire [31:0] a, wd;
output reg [31:0] rd;

reg [31:0] RAM [63:0];

// Read ports
always @*
begin
    rd = RAM[a];
end

always @(posedge clk)
begin
    if (we) 
        //RAM[a[31:2]] <= wd;
        RAM[a] <= wd;
end

initial
    begin
//        RAM[0]  = 32'h00000000;
//        RAM[1]  = 32'h00000001;
//        RAM[2]  = 32'h00000002;
//        RAM[3]  = 32'h00000000;
        RAM[32]  = 32'h0000000A;
    end

endmodule
