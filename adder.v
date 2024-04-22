`timescale 1ns / 1ps

module adder(a, b, y);

input [31:0] a, b;
output [31:0] y;

assign y = a + b;

endmodule
