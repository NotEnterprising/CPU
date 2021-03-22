`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:25:33 11/15/2019 
// Design Name: 
// Module Name:    de 
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
module de(
    input clk,
    input reset,
    input clr,
    input [31:0] Instr_D,
    input [31:0] RS_D,
    input [31:0] RT_D,
    input [31:0] EXT_D,
	 input [31:0] PC_D,
    input [31:0] PC4_D,
	 input [31:0] PC8_D,
	 input [4:0] ExcCode_Din,
	 input BJ_D,
    output reg [31:0] Instr_E,
    output reg [31:0] RS_E,
    output reg [31:0] RT_E,
    output reg [31:0] EXT_E,
	 output reg [31:0] PC_E,
    output reg [31:0] PC4_E,
	 output reg [31:0] PC8_E,
	 output reg [4:0] ExcCode_Dout,
	 output reg BJ_E
    );
initial begin
	Instr_E=0;
	RS_E=0;
	RT_E=0;
	EXT_E=0;
	PC_E=0;
	PC4_E=0;
	PC8_E=0;
	ExcCode_Dout=0;
	BJ_E=0;
end
always @(posedge clk)begin
	if((reset==1)||(clr==1))begin
		Instr_E=0;
		RS_E=0;
		RT_E=0;
		EXT_E=0;
		PC_E=0;
		PC4_E=0;
		PC8_E=0;
		ExcCode_Dout=0;
		BJ_E=0;
	end
	else begin
		Instr_E=Instr_D;
		RS_E=RS_D;
		RT_E=RT_D;
		EXT_E=EXT_D;
		PC_E=PC_D;
		PC4_E=PC4_D;
		PC8_E=PC8_D;
		ExcCode_Dout=ExcCode_Din;
		BJ_E=BJ_D;
	end
end
endmodule
