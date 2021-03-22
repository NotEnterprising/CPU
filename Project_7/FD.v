`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:53 11/15/2019 
// Design Name: 
// Module Name:    FD 
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
module fd(
    input clk,
    input reset,
    input En,
    input [31:0] Instr_F,
	 input [31:0] PC_F,
    input [31:0] PC4_F,
	 input [31:0] PC8_F,
	 input [4:0] ExcCode_F,
	 input BJ_F,
	 output reg [31:0] Instr_D,
	 output reg [31:0] PC_D,
    output reg [31:0] PC4_D,
	 output reg [31:0] PC8_D,
	 output reg [4:0] ExcCode_Fout,
	 output reg BJ_D
    );
initial begin
	Instr_D=0;
	PC4_D=0;
	PC8_D=0;
	ExcCode_Fout=0;
	PC_D=0;
	BJ_D=0;
end
always @(posedge clk)begin
	if(reset==1)begin
		Instr_D=0;
	   PC4_D=0;
		PC8_D=0;
		ExcCode_Fout=0;
		PC_D=0;
		BJ_D=0;
	end
	else if(En==1)begin
		Instr_D=(ExcCode_F==0)?Instr_F:32'h00000000;
		PC4_D=PC4_F;
		PC8_D=PC8_F;
		ExcCode_Fout=ExcCode_F;
		PC_D=PC_F;
		BJ_D=BJ_F;
	end
end
endmodule
