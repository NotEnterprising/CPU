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
// Create Date:    11:02:22 11/16/2019 
// Design Name: 
// Module Name:    HAZARD 
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
module HAZARD(
    input [31:0] Instr_D,
    input [31:0] Instr_E,
    input [31:0] Instr_M,
    input [31:0] Instr_W,
	 input [4:0] WBA_E,
	 input [31:0] WD3_E,
	 input [4:0] WBA_M,
	 input [31:0] WD3_M,
	 input [4:0] WBA_W,
	 input [31:0] WD3_W,
    input [31:0] RS_D,
	 input [31:0] RT_D,
	 input [31:0] RS_E,
	 input [31:0] RT_E,
	 input [31:0] RT_M,
	 //
	 input [1:0] Tuse_rs,
	 input [1:0] Tuse_rt,
	 input [1:0] Tnew_E,
	 input [1:0] Tnew_M,
	 //
	 input start,
	 input busy,
	 //
    output [31:0] nRS_D,
	 output [31:0] nRT_D,
	 output [31:0] nRS_E,
	 output [31:0] nRT_E,
	 output [31:0] nRT_M,
    output stall
    );
	 //forward
	 assign nRS_D=(Instr_D[`rs]==WBA_E&&Instr_D[`rs]!=0)?WD3_E:
	              (Instr_D[`rs]==WBA_M&&Instr_D[`rs]!=0)?WD3_M:
					  (Instr_D[`rs]==WBA_W&&Instr_D[`rs]!=0)?WD3_W:
					   RS_D;
	 assign nRT_D=(Instr_D[`rt]==WBA_E&&Instr_D[`rt]!=0)?WD3_E:
	              (Instr_D[`rt]==WBA_M&&Instr_D[`rt]!=0)?WD3_M:
					  (Instr_D[`rt]==WBA_W&&Instr_D[`rt]!=0)?WD3_W:
					   RT_D;
	 assign nRS_E=(Instr_E[`rs]==WBA_M&&Instr_E[`rs]!=0)?WD3_M:
					  (Instr_E[`rs]==WBA_W&&Instr_E[`rs]!=0)?WD3_W:
					   RS_E;
	 assign nRT_E=(Instr_E[`rt]==WBA_M&&Instr_E[`rt]!=0)?WD3_M:
					  (Instr_E[`rt]==WBA_W&&Instr_E[`rt]!=0)?WD3_W:
					   RT_E;
	 assign nRT_M=(Instr_M[`rt]==WBA_W&&Instr_M[`rt]!=0)?WD3_W:
	 				   RT_M;
	 
	 //wire stallcp01=(Instr_D[`op]==6'b010000&&Instr_D[`funct]==6'b011000)&&(Instr_E[`op]==6'b010000&&Instr_E[`rs]==5'b00100);
	 //wire stallcp02=(Instr_D[`op]==6'b010000&&Instr_D[`funct]==6'b011000)&&(Instr_M[`op]==6'b010000&&Instr_M[`rs]==5'b00100);
	 //
	 wire mult_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b011000);
	 wire multu_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b011001);
	 wire div_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b011010);
	 wire divu_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b011011);	 
	 wire mfhi_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b010000);
	 wire mflo_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b010010);
	 wire mthi_D=(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b010001);
	 wire mtlo_D =(Instr_D[`op]==6'b000000 & Instr_D[`funct]==6'b010011);
	 wire stallMD;
	 assign stallMD=((busy|start)&&(mult_D|multu_D|div_D|divu_D|mfhi_D|mflo_D|mthi_D|mtlo_D))?1:0;
	 
	 wire stall_D_E_rs;
	 wire stall_D_E_rt;
	 wire stall_D_M_rs;
	 wire stall_D_M_rt;
	 assign stall_D_E_rs=(Instr_D[`rs]==WBA_E&&Instr_D[`rs]!=0&&(Tuse_rs<Tnew_E))?1:0;
	 assign stall_D_E_rt=(Instr_D[`rt]==WBA_E&&Instr_D[`rt]!=0&&(Tuse_rt<Tnew_E))?1:0;
	 assign stall_D_M_rs=(Instr_D[`rs]==WBA_M&&Instr_D[`rs]!=0&&(Tuse_rs<Tnew_M))?1:0;
	 assign stall_D_M_rt=(Instr_D[`rt]==WBA_M&&Instr_D[`rt]!=0&&(Tuse_rs<Tnew_M))?1:0;
	 assign stall=stall_D_E_rs|stall_D_E_rt|stall_D_M_rs|stall_D_M_rt|stallMD;
	 
endmodule
