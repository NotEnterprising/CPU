`timescale 1ns / 1ps
`define op 31:26
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define funct 5:0
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:52 12/07/2019 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input [31:0] Instr_M,
	 input [31:0] Instr_W,
	 input [4:0] A1,
	 input [4:0] A2,
	 input [31:0] Din,
	 input [31:0] PC_M,
	 input [6:2] ExcCodein,
	 input [5:0] HWInt,
	 input We,
	 input EXLSet,
	 input EXLCLr,
	 input clk,
	 input reset,
	 input BJ_M,
	 output IntExc,
	 output [31:0] EPCout,
	 output [31:0] Dout
    );
	 reg BD; 
	 reg [5:0] IP;
	 reg [4:0] ExcCode;
	 
	 reg [31:0] EPC;
	 
	 reg [31:0] PRID=32'h00000000;
	 reg [5:0] IM;
    reg EXL;
    reg IE;	 
	 assign EPCout=EPC;
    assign Dout=(A1==12)?{16'b0,IM,8'b0,EXL,IE}:
	             (A1==13)?{BD,15'b0,IP,3'b0,ExcCode,2'b0}:
					 (A1==14)?EPC:
					 (A1==15)?PRID:
					 32'b0;
    wire Int;
	 wire Exc;
	 assign Exc=(ExcCodein!=0)?1:0;
	 assign Int=|(HWInt[5:0] & IM[5:0]) & IE & !EXL;
	 assign IntExc=Int|Exc;
	 always @(posedge clk)begin
		if(reset==1)begin
			BD=0;
			IP=0;
			ExcCode=0;
			EPC=0;
			PRID=0;
			IM=0;
			EXL=0;
			IE=0;
		end
		else begin
		   if(EXLSet||IntExc)begin
				EXL=1;
				ExcCode=ExcCodein;
				BD=BJ_M;
			end
			if(EXLCLr)begin
				EXL=0;
			end
			IP=HWInt;
			EPC=(BD & IntExc)?{PC_M[31:2],2'b0}-4:
			    (!BD & IntExc)?{PC_M[31:2],2'b0}:
				 EPC;
			if(We==1)begin
				case(A2)
					12:begin
						IM=Din[15:10];
						EXL=Din[1];
						IE=Din[0];
					end
					13:begin
					   //BD=Din[31];
					   //IP=Din[15:10];
						//ExcCode=Din[6:2];
					end
					14:EPC=Din;
					15:PRID=Din;
				endcase
			end
		end
	 end
endmodule
