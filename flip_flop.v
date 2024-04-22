`timescale 1ns / 1ps

module flip_flop  #(parameter WIDTH = 32) (clk,reset,d,q);

input wire clk, reset;
input wire [WIDTH-1:0] d;
output [WIDTH-1:0] q;

reg [WIDTH-1:0] q_reg;              // Internal register for synchronized reset

always @(posedge clk or posedge reset) 
begin
    if (reset) 
    begin
        q_reg <= {WIDTH{1'b0}};     // Assign reset value to all bits of q_reg
    end 
    else 
    begin
        q_reg <= d;                 // Assign input data to q_reg on positive clock edge
    end
end

// Output q_reg to q
assign q = q_reg;

endmodule