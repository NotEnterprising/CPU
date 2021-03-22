`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:06 11/15/2019 
// Design Name: 
// Module Name:    mw 
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
module mw(
    input clk,
    input reset,
    input [31:0] Instr_M,
    input [31:0] ALU_M,
    input [31:0] DM_M,
    input [31:0] PC4_M,
	 input [31:0] PC8_M,
	 input [31:0] MDout_M,
	 input [4:0] WBA_M,
	 input [31:0] CP0Dout_M,
    output reg [31:0] Instr_W,
    output reg [31:0] ALU_W,
	 output reg [31:0] MDout_W,
    output reg [31:0] DM_W,
    output reg [31:0] PC4_W,
	 output reg [31:0] PC8_W,
	 output reg [4:0] WBA_W,
	 output reg [31:0] CP0Dout_W
    );
initial begin
	Instr_W=0;
	ALU_W=0;
	DM_W=0;
	PC4_W=0;
	PC8_W=0;
	MDout_W=0;
	WBA_W=0;
	CP0Dout_W=0;
end
always @(posedge clk)begin
	if(reset)begin
		Instr_W=0;
		ALU_W=0;
		DM_W=0;
		PC4_W=0;
		PC8_W=0;
		MDout_W=0;
		WBA_W=0;
		CP0Dout_W=0;
	end
	else begin
		Instr_W=Instr_M;
		ALU_W=ALU_M;
		DM_W=DM_M;
		PC4_W=PC4_M;
		PC8_W=PC8_M;
		MDout_W=MDout_M;
		WBA_W=WBA_M;
		CP0Dout_W=CP0Dout_M;
	end
end
endmodule
