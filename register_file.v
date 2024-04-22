`timescale 1ns / 1ps

module register_file(clk,we3,a1,a2,a3,wd3,rd1,rd2);

input wire clk,we3;
input wire [4:0] a1,a2,a3;
input wire [31:0]wd3;
output reg [31:0]rd1,rd2;

reg [31:0] reg_file [31:0];

initial 
begin
     reg_file[5]  = 32'h00000006;
     reg_file[6]  = 32'h000000EC;
     reg_file[9]  = 32'h00000024;     
end

// Read ports
always @*
begin
    rd1 = reg_file[a1];
    rd2 = reg_file[a2];
end

always @ (posedge clk)
begin
    if(we3)
    begin
        reg_file[a3] <= wd3;
    end
end

endmodule


//// Assign output 'rd1' based on input address 'a1'
//always @ (posedge clk) 
//begin
//    if(a1 < 32)         // Bounds checking
//        rd1 = RegFile[a1];
//    else
//        rd1 = 32'h0;     // Default value if address is out of bounds
//end

//// Assign output 'rd2' based on input address 'a2'
//always @ (posedge clk) 
//begin
//    if(a2 < 32)         // Bounds checking
//        rd2 = RegFile[a2];
//    else
//        rd2 = 32'h0;     // Default value if address is out of bounds
//end