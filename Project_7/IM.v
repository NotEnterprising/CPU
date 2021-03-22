`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:45 11/08/2019 
// Design Name: 
// Module Name:    IM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IM(
    output [31:0] Instr,
    input [31:0] PC
    );
	 wire [31:0] PCset;
    integer i;
	 reg [31:0] ROM [0:4095];
initial begin
	for(i=0;i<=4095;i=i+1)begin
		ROM[i]=0;
	end
	$readmemh("code.txt",ROM);
	$readmemh("code_handler.txt",ROM,1120,2047);
end
   assign PCset=PC-32'h00003000;
	assign Instr=ROM[PCset[13:2]];
endmodule
