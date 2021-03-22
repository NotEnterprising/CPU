`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:48 11/15/2019 
// Design Name: 
// Module Name:    em 
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
module em(
    input clk,
    input reset,
    input [31:0] Instr_E,
    input [31:0] RT_E,
    input [31:0] ALU_E,
	 input [31:0] PC_E,
    input [31:0] PC4_E,
	 input [31:0] PC8_E,
	 input [31:0] MDout_E,
	 input [4:0] WBA_E,
	 input [4:0] ExcCode_Ein,
	 input BJ_E,
    output reg [31:0] Instr_M,
    output reg [31:0] RT_M,
	 output reg [31:0] MDout_M,
    output reg [31:0] ALU_M,
	 output reg [31:0] PC_M,
    output reg [31:0] PC4_M,
	 output reg [31:0] PC8_M,
	 output reg [4:0] WBA_M,
	 output reg [4:0] ExcCode_Eout,
	 output reg BJ_M
    );
initial begin
	Instr_M=0;
	RT_M=0;
	ALU_M=0;
	PC_M=0;
	PC4_M=0;
	PC8_M=0;
	MDout_M=0;
	WBA_M=0;
	ExcCode_Eout=0;
	BJ_M=0;
end
always@(posedge clk)begin
	if(reset)begin
		Instr_M=0;
		RT_M=0;
		ALU_M=0;
		PC_M=0;
		PC4_M=0;
		PC8_M=0;
		MDout_M=0;
		WBA_M=0;
		ExcCode_Eout=0;
		BJ_M=0;
	end
	else begin
		Instr_M=Instr_E;
		RT_M=RT_E;
		ALU_M=ALU_E;
		PC_M=PC_E;
		PC4_M=PC4_E;
		PC8_M=PC8_E;
		MDout_M=MDout_E;
		WBA_M=WBA_E;
		ExcCode_Eout=ExcCode_Ein;
		BJ_M=BJ_E;
	end
end
endmodule
