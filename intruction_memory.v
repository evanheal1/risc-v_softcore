`timescale 1ns / 1ps

module instruction_memory(a, rd);

input wire [31:0] a;
output reg [31:0] rd;

// Declare memory
reg [31:0] ROM [63:0];

// Initialize memory
initial 
begin
     ROM[0] = 32'hFFC4A303;
     //ROM[1] = 32'h003100B3;
     ROM[4] = 32'h0064A423;
     ROM[8] = 32'h0062E233;
     ROM[12] = 32'hFE420AE3;
end

// Assign output 'rd' based on input address 'a'
always @* 
begin
    if(a < 32)         // Bounds checking
        rd = ROM[a];
    else
        rd = 32'h0;     // Default value if address is out of bounds
end

endmodule
