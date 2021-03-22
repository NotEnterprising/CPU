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
// Create Date:    17:47:08 11/08/2019 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input [31:0] Instr,
    output reg RegWrite,
	 output reg MemWrite,
	 output reg ALUASrc,
	 output reg ALUBSrc,
	 output reg [1:0] WD3sel_E,
	 output reg [1:0] WD3sel_M,
	 output reg [2:0] WD3sel_W,
	 output reg [4:0] WBA,
	 output reg [1:0] EXTop,
	 output reg [2:0] Branchop,
	 output reg [2:0] loadsel,
	 output reg [1:0] storesel,
	 output reg mfsel,
	 output reg start,
	 output reg [2:0] MDsel,
	 output reg [3:0] ALUop,
	 output reg [2:0] nPCSrc,
	 output reg [1:0] Tuse_rs,
    output reg [1:0] Tuse_rt,
    output reg [1:0] Tnew_E,
    output reg [1:0] Tnew_M,
	 output reg CP0We,
	 output reg exist
    );
    wire [5:0] op;
	 wire [5:0] funct;
	 assign op=Instr[31:26];
	 assign funct=Instr[5:0];
always@(*)begin
   //////////////////////////////cal_r//////////////////////////////
	if((op==6'b000000&&funct==6'b100000)|(op==6'b000000&&funct==6'b100001))begin //add,addu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if((op==6'b000000&&funct==6'b100010)|(op==6'b000000&&funct==6'b100011))begin //sub,subu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=3;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b100100)begin //and
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=0;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b100101)begin //or
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=1;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b100110)begin //xor
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=4;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b100111)begin //nor
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=5;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b101010)begin //slt
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=6;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b101011)begin //sltu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=7;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b000100)begin //sllv
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=8;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b000110)begin //srlv
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=9;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b000111)begin //srav
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=10;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
   //////////////////////////////cal_i//////////////////////////////
	else if((op==6'b001000)|(op==6'b001001))begin //addi,addiu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=1;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001100)begin //andi
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=0;
     start=0;
     MDsel=0;
     ALUop=0;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001101)begin //ori
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=0;
     start=0;
     MDsel=0;
     ALUop=1;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001110)begin //xori
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=0;
     start=0;
     MDsel=0;
     ALUop=4;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001111)begin //lui
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=2;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001010)begin //slti
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=1;
     start=0;
     MDsel=0;
     ALUop=6;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b001011)begin //sltiu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rt];
     EXTop=1;
     start=0;
     MDsel=0;
     ALUop=7;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
   //////////////////////////////branch//////////////////////////////
	else if(op==6'b000100)begin //beq
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=0;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000101)begin //bne
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=1;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000110)begin //blez
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=2;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000111)begin //bgtz
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=3;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000001&&Instr[`rt]==5'b00000)begin //bltz
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=4;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000001&&Instr[`rt]==5'b00001)begin //bgez
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     EXTop=1;
     Branchop=5;
     start=0;
     MDsel=0;
     nPCSrc=1;
     Tuse_rs=0;
     Tuse_rt=0;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
   //////////////////////////////load//////////////////////////////
	else if(op==6'b100000)begin //lb
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_W=3;
     WBA=Instr[`rt];
     EXTop=1;
     loadsel=0;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b100100)begin //lbu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_W=3;
     WBA=Instr[`rt];
     EXTop=1;
     loadsel=1;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b100001)begin //lh
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_W=3;
     WBA=Instr[`rt];
     EXTop=1;
     loadsel=2;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b100101)begin //lhu
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_W=3;
     WBA=Instr[`rt];
     EXTop=1;
     loadsel=3;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b100011)begin //lw
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=0;
     ALUBSrc=1;
     WD3sel_W=3;
     WBA=Instr[`rt];
     EXTop=1;
     loadsel=4;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
   //////////////////////////////store//////////////////////////////
	else if(op==6'b101000)begin //sb
	  RegWrite=0;
     MemWrite=1;
     ALUASrc=0;
     ALUBSrc=1;
     WBA=0;
     EXTop=1;
     storesel=0;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=2;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b101001)begin //sh
	  RegWrite=0;
     MemWrite=1;
     ALUASrc=0;
     ALUBSrc=1;
     WBA=0;
     EXTop=1;
     storesel=1;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=2;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b101011)begin //sw
	  RegWrite=0;
     MemWrite=1;
     ALUASrc=0;
     ALUBSrc=1;
     WBA=0;
     EXTop=1;
     storesel=2;
     start=0;
     MDsel=0;
     ALUop=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=2;
     Tnew_E=0;
     Tnew_M=0;	
	  exist=1;
	  CP0We=0;
	end
   //////////////////////////////jal//////////////////////////////
	else if(op==6'b000011)begin //jal
	  RegWrite=1;
     MemWrite=0;
     WD3sel_E=0;
     WD3sel_M=0;
     WD3sel_W=0;
     WBA=31;
     start=0;
     MDsel=0;
     nPCSrc=3;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	//////////////////////////////jr//////////////////////////////
	else if(op==6'b000000&&funct==6'b001000)begin //jr
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     start=0;
     MDsel=0;
     nPCSrc=2;
     Tuse_rs=0;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	//////////////////////////////j//////////////////////////////
	else if(op==6'b000010)begin //j
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     start=0;
     MDsel=0;
     nPCSrc=3;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	//////////////////////////////jalr//////////////////////////////
	else if(op==6'b000000&&funct==6'b001001)begin //jalr
	  RegWrite=1;
     MemWrite=0;
     WD3sel_E=0;
     WD3sel_M=0;
     WD3sel_W=0;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     nPCSrc=2;
     Tuse_rs=0;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	//////////////////////////////cal_s//////////////////////////////
	else if(op==6'b000000&&funct==6'b000000)begin //sll
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=1;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=8;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b000010)begin //srl
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=1;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=9;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b000011)begin //sra
	  RegWrite=1;
     MemWrite=0;
     ALUASrc=1;
     ALUBSrc=0;
     WD3sel_M=1;
     WD3sel_W=1;
     WBA=Instr[`rd];
     start=0;
     MDsel=0;
     ALUop=10;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=1;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	//////////////////////////////md//////////////////////////////
	else if(op==6'b000000&&funct==6'b011000)begin //mult
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=1;
     MDsel=1;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b011001)begin //multu
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=1;
     MDsel=2;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b011010)begin //div
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=1;
     MDsel=3;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b011011)begin //divu
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=1;
     MDsel=4;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=1;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b010000)begin //mfhi
	  RegWrite=1;
     MemWrite=0;
     WD3sel_M=2;
     WD3sel_W=2;
     WBA=Instr[`rd];
     mfsel=0;
     start=0;
     MDsel=0;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b010010)begin //mflo
	  RegWrite=1;
     MemWrite=0;
     WD3sel_M=2;
     WD3sel_W=2;
     WBA=Instr[`rd];
     mfsel=1;
     start=0;
     MDsel=0;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=1;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b010001)begin //mthi
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=0;
     MDsel=5;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b000000&&funct==6'b010011)begin //mtlo
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=0;
     MDsel=6;
     nPCSrc=0;
     Tuse_rs=1;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b010000&&Instr[`rs]==5'b00000)begin //mfc0
	  RegWrite=1;
     MemWrite=0;
     WD3sel_W=4;
     WBA=Instr[`rt];
     start=0;
     MDsel=0;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=2;
     Tnew_M=1;
	  exist=1;
	  CP0We=0;
	end
	else if(op==6'b010000&&Instr[`rs]==5'b00100)begin //mtc0
	  RegWrite=0;
     MemWrite=0;
	  WBA=0;
     start=0;
     MDsel=0;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=2;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=1;
	end
	else if(op==6'b010000&&funct==6'b011000)begin //eret
	  RegWrite=0;
     MemWrite=0;
     WBA=0;
     start=0;
     MDsel=0;
     nPCSrc=0;
     Tuse_rs=3;
     Tuse_rt=3;
     Tnew_E=0;
     Tnew_M=0;
	  exist=1;
	  CP0We=0;
	end
	else begin
	  RegWrite=0;
	  MemWrite=0;
	  WBA=0;
	  start=0;
	  MDsel=0;
	  nPCSrc=0;
	  Tuse_rs=3;
	  Tuse_rt=3;
	  Tnew_E=0;
	  Tnew_M=0;
	  exist=0;
	  CP0We=0;
	end
end
endmodule
