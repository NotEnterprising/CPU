`timescale 1ns / 1ps
`define op 31:26
`define imm26 25:0
`define imm16 15:0
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define shamt 10:6
`define funct 5:0
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:30 11/16/2019 
// Design Name: 
// Module Name:    mips 
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
module CPU(
    input clk,
    input reset,
	 input [31:0] PrRD,
	 input [5:0] HWInt,
	 output [31:0] PrAddr,
	 output [31:0] PrWD,
	 output WeCPU,
	 output [31:0] addr
    );

wire [31:0] PC_M;
wire IntExc;
wire [31:0] EPCout;
wire eret;
//
wire [1:0] Tuse_rs;
wire [1:0] Tuse_rt;
wire [1:0] Tnew_E;
wire [1:0] Tnew_M;
//
wire [4:0] WBA_E;
wire [4:0] WBA_M;
wire [4:0] WBA_W;
//
wire [31:0] nRS_D;
wire [31:0] nRT_D;
wire [31:0] nRS_E;
wire [31:0] nRT_E;
wire [31:0] nRT_M;
//DE
wire clr;
wire [31:0] Instr_E;
wire [31:0] RS_E;
wire [31:0] RT_E;
wire [31:0] EXT_E;
wire [31:0] PC4_E;
wire [31:0] PC8_E;
//EM
wire [31:0] Instr_M;
wire [31:0] RT_M;
wire [31:0] ALU_M;
wire [31:0] PC4_M;
wire [31:0] PC8_M;
wire [31:0] MDout_M;
//WD3_W
wire [31:0] WD3_W;
//controller_W
wire [2:0] WD3sel_W;
wire RegWrite;
//MW
wire [31:0] DM_M;
wire [31:0] Instr_W;
wire [31:0] ALU_W;
wire [31:0] DM_W;
wire [31:0] PC4_W;
wire [31:0] PC8_W;
wire [31:0] MDout_W;
//PC
wire PCEn;
wire [31:0] nPC;
wire [31:0] PC;
wire [4:0] ExcCode_F;
PC PCwire(
    .clk(clk), 
    .reset(reset), 
    .PCEn(PCEn|IntExc), 
    .nPC(nPC), 
    .PC(PC),
	 .IntExc(IntExc),
	 .eret(eret),
	 .EPCout(EPCout),
	 .ExcCode_F(ExcCode_F)
    );
//IM
wire [31:0] Instr;
IM IMwire(
    .Instr(Instr), 
    .PC(PC)
    );
wire [31:0] PC4_F;
wire [31:0] PC8_F;
assign PC4_F=PC+4;
assign PC8_F=PC+8;
//////////////////////////////////////////D
//FD
wire BJ_F;
assign BJ_F=(Instr_D[`op]==6'b000100)||(Instr_D[`op]==6'b000101)||(Instr_D[`op]==6'b000110)||
	           (Instr_D[`op]==6'b000111)||(Instr_D[`op]==6'b000001&&Instr_D[`rt]==5'b00000)||
				  (Instr_D[`op]==6'b000001&&Instr_D[`rt]==5'b00001)||(Instr_D[`op]==6'b000010)||
				  (Instr_D[`op]==6'b000011)||(Instr_D[`op]==6'b000000&&Instr_D[`funct]==6'b001000)||
				  (Instr_D[`op]==6'b000000&&Instr_D[`funct]==6'b001001);
wire En;
wire [31:0] Instr_D;
wire [31:0] PC_D;
wire [31:0] PC4_D;
wire [31:0] PC8_D;
wire [4:0] ExcCode_Fout;
wire BJ_D;
fd fdwire (
    .clk(clk), 
    .reset(reset|IntExc|eret), 
    .En(En), 
    .Instr_F(Instr), 
	 .PC_F(PC),
    .PC4_F(PC4_F), 
    .PC8_F(PC8_F), 
	 .BJ_F(BJ_F),
    .Instr_D(Instr_D), 
	 .PC_D(PC_D),
    .PC4_D(PC4_D), 
    .PC8_D(PC8_D),
	 .ExcCode_F(ExcCode_F),
	 .ExcCode_Fout(ExcCode_Fout),
	 .BJ_D(BJ_D)
    );
//controller_D
wire [1:0] EXTop;
wire [2:0] nPCSrc;
wire [2:0] Branchop;
wire exist;
wire [4:0] ExcCode_D;
assign ExcCode_D=(exist==0)?10:0;
controller controller_D (
    .Instr(Instr_D), 
    .EXTop(EXTop),  
    .nPCSrc(nPCSrc),
	 .Tuse_rs(Tuse_rs),
	 .Tuse_rt(Tuse_rt),
	 .Branchop(Branchop),
	 .exist(exist)
    );
//EXT
wire [31:0] EXTimm16;
EXT EXTwire (
    .imm16(Instr_D[`imm16]), 
    .EXTimm16(EXTimm16), 
    .EXTop(EXTop)
    );
//GRF
wire [31:0] GRFPC;
wire [31:0] O1;
wire [31:0] O2;
assign GRFPC=PC4_W-4;
GRF GRFwire (
    .A1(Instr_D[`rs]), 
    .A2(Instr_D[`rt]), 
    .WriteAdd(WBA_W), 
    .clk(clk), 
    .reset(reset), 
    .RegWrite(RegWrite), 
    .WD3(WD3_W), 
    .PC(GRFPC), 
    .O1(O1), 
    .O2(O2)
    );
//NPC
wire [31:0] branch;
wire [31:0] jump;
NPC NPCwire (
    .PC4(PC4_D), 
    .immbeq(EXTimm16), 
    .imm26(Instr_D[`imm26]), 
    .cmp1(nRS_D), 
    .cmp2(nRT_D), 
	 .Branchop(Branchop),
    .branch(branch), 
    .jump(jump)
    );
//PCMUX
MUX8 PCMUX (
    .in0(PC4_F), 
    .in1(branch), 
    .in2(nRS_D), 
    .in3(jump), 
    .out8(nPC), 
    .mux8op(nPCSrc)
    );
/////////////////////////////////////E
//DE
wire BJ_E;
wire [31:0] PC_E;
wire [4:0] ExcCode_Din;
wire [4:0] ExcCode_Dout;
assign ExcCode_Din=(ExcCode_Fout==0)?ExcCode_D:ExcCode_Fout;
de dewire (
    .clk(clk), 
    .reset(reset|IntExc|eret), 
    .clr(clr), 
    .Instr_D((ExcCode_D>0)?32'h00000000:Instr_D), 
    .RS_D(O1), 
    .RT_D(O2), 
    .EXT_D(EXTimm16), 
	 .PC_D(PC_D),
    .PC4_D(PC4_D), 
    .PC8_D(PC8_D), 
	 .BJ_D(BJ_D),
    .Instr_E(Instr_E), 
    .RS_E(RS_E), 
    .RT_E(RT_E),  
    .EXT_E(EXT_E), 
	 .PC_E(PC_E),
    .PC4_E(PC4_E), 
    .PC8_E(PC8_E),
	 .ExcCode_Din(ExcCode_Din),
	 .ExcCode_Dout(ExcCode_Dout),
	 .BJ_E(BJ_E)
    );
//controller_E
wire ALUBSrc;
wire ALUASrc;
wire [3:0] ALUop;
wire [1:0] WD3sel_E;
wire mfsel;
wire [2:0] MDsel;
wire start;
controller controller_E(
    .Instr(Instr_E), 
	 .ALUASrc(ALUASrc), 	 
    .ALUBSrc(ALUBSrc), 
    .ALUop(ALUop),
	 .WD3sel_E(WD3sel_E),
	 .WBA(WBA_E),
	 .Tnew_E(Tnew_E),
	 .mfsel(mfsel),
	 .MDsel(MDsel),
	 .start(start)
    );
wire [31:0] B;
wire [31:0] A;
wire [31:0] result;
//ALUBSrcMUX
MUX2 ALUBSrcMUX (
    .in0(nRT_E), 
    .in1(EXT_E), 
    .out2(B), 
    .mux2op(ALUBSrc)
    );
wire [31:0] sha;
assign sha={27'b0,Instr_E[`shamt]};
//ALUASrcMUX
MUX2 ALUASrcMUX (
    .in0(nRS_E), 
    .in1(sha), 
    .out2(A), 
    .mux2op(ALUASrc)
    );
//ALU
wire overflow;
ALU ALUwire (
    .A(A), 
    .B(B), 
    .ALUop(ALUop), 
    .result(result),
	 .overflow(overflow)
    );
wire [31:0] WD3_E;
//WD3sel_EMUX
MUX4 WD3sel_EMUX(
    .in0(PC8_E), 
    .out4(WD3_E), 
    .mux4op(WD3sel_E)
    );
//MD
wire [31:0] MDout;
wire busy;
MD MDwire (
    .clk(clk), 
    .reset(reset), 
    .A(nRS_E), 
    .B(nRT_E), 
    .start(start&(~(IntExc|eret))), 
    .MDsel(((IntExc|eret)==0)?MDsel:3'b000), 
    .mfsel(mfsel), 
    .MDout(MDout), 
    .busy(busy)
    );
wire [4:0] ExcCode_E;
assign ExcCode_E=(
(Instr_E[`op]==6'b100011||
Instr_E[`op]==6'b100000||
Instr_E[`op]==6'b100100||
Instr_E[`op]==6'b100001||
Instr_E[`op]==6'b100101)&&overflow)?4:
(
(Instr_E[`op]==6'b101011||
Instr_E[`op]==6'b101000||
Instr_E[`op]==6'b101001)&&overflow)?5:
((
(Instr_E[`op]==6'b000000&&Instr_E[`funct]==6'b100000)||
(Instr_E[`op]==6'b000000&&Instr_E[`funct]==6'b100010)||
(Instr_E[`op]==6'b000000&&Instr_E[`funct]==6'b001000))&&overflow)?12:0;
////////////////////////////////M
//EM
wire BJ_M;
wire [4:0] ExcCode_Ein;
wire [4:0] ExcCode_Eout;
assign ExcCode_Ein=(ExcCode_Dout==0)?ExcCode_E:ExcCode_Dout;
em emwire (
    .clk(clk), 
    .reset(reset|IntExc|eret), 
    .Instr_E(Instr_E), 
    .RT_E(nRT_E), 
	 .MDout_E(MDout),
    .ALU_E(result), 
	 .PC_E(PC_E),
    .PC4_E(PC4_E), 
    .PC8_E(PC8_E), 
	 .WBA_E(WBA_E),
	 .BJ_E(BJ_E),
    .Instr_M(Instr_M), 
    .RT_M(RT_M), 
	 .MDout_M(MDout_M),
    .ALU_M(ALU_M), 
	 .PC_M(PC_M),
    .PC4_M(PC4_M), 
    .PC8_M(PC8_M),
	 .WBA_M(WBA_M),
	 .ExcCode_Ein(ExcCode_Ein),
	 .ExcCode_Eout(ExcCode_Eout),
	 .BJ_M(BJ_M)
    );
assign addr=((PC_M!=32'h00000000||ExcCode_Eout==4)?PC_M:(PC_E!=32'h00000000||ExcCode_Dout==4)?PC_E:(PC_D!=32'h00000000||ExcCode_Fout==4)?PC_D:PC);
//controller_M
wire [1:0] WD3sel_M;
wire [2:0] loadsel;
wire [1:0] storesel;
wire CP0We;
controller controller_M (
    .Instr(Instr_M),  
    .MemWrite(MemWrite),
	 .WD3sel_M(WD3sel_M),
	 .Tnew_M(Tnew_M),
	 .loadsel(loadsel),
	 .storesel(storesel),
	 .CP0We(CP0We)
    );
//DM
wire [31:0] DMPC;
assign DMPC=PC4_M-4;
wire [31:0] ReadData;
DM DMwire (
    .Address(ALU_M), 
    .WD(nRT_M), 
    .MemWrite(MemWrite&(~(IntExc|eret))&ALU_M<32'h00003000), 
    .clk(clk), 
    .reset(reset), 
    .PC(DMPC), 
    .ReadData(ReadData),
	 .loadsel(loadsel),
	 .storesel(storesel)
    );
//
wire [31:0] WD3_M;
//WD3sel_MMUX
MUX4 WD3sel_MMUX(
    .in0(PC8_M), 
    .in1(ALU_M),
    .in2(MDout_M),	 
    .out4(WD3_M), 
    .mux4op(WD3sel_M)
    );
wire [4:0] ExcCode_M;
assign ExcCode_M=((Instr_M[`op]==6'b100011&&ALU_M[1:0]!=2'b00)||
(Instr_M[`op]==6'b100001&&ALU_M[0]!=1'b0)||
(Instr_M[`op]==6'b100101&&ALU_M[0]!=1'b0)||
((Instr_M[`op]==6'b100011||
Instr_M[`op]==6'b100001||
Instr_M[`op]==6'b100101||
Instr_M[`op]==6'b100000||
Instr_M[`op]==6'b100100)&&
((ALU_M>32'h00002fff&&ALU_M<32'h00007f00)||
(ALU_M>32'h00007f0b&&ALU_M<32'h00007f10)||
ALU_M>32'h00007f1b))||
(
(Instr_M[`op]==6'b100001||
Instr_M[`op]==6'b100101||
Instr_M[`op]==6'b100000||
Instr_M[`op]==6'b100100)&&
((ALU_M>=32'h00007f00&&ALU_M<=32'h00007f0b)||
(ALU_M>=32'h00007f10&&ALU_M<=32'h00007f1b)))
)?4:
((Instr_M[`op]==6'b101011&&ALU_M[1:0]!=2'b00)||
(Instr_M[`op]==6'b101001&&ALU_M[0]!=1'b0)||
((Instr_M[`op]==6'b101011||
Instr_M[`op]==6'b101001||
Instr_M[`op]==6'b101000)&&
((ALU_M>32'h00002fff&&ALU_M<32'h00007f00)||
(ALU_M>32'h00007f07&&ALU_M<32'h00007f10)||
ALU_M>32'h00007f17))||
((Instr_M[`op]==6'b101000||
Instr_M[`op]==6'b101001)&&
((ALU_M>=32'h00007f00&&ALU_M<=32'h00007f0b)||
(ALU_M>=32'h00007f10&&ALU_M<=32'h00007f1b)))
)?5:0;
//
wire [4:0] ExcCodein;
assign ExcCodein=(|HWInt)?5'b0:(ExcCode_Eout==0)?ExcCode_M:ExcCode_Eout;
wire EXLSet=IntExc;
wire EXLCLr=(eret)?1:0;
wire [31:0] CP0Dout;
CP0 CP0wire (
    .Instr_M(Instr_M), 
    .Instr_W(Instr_W), 
    .A1(Instr_M[`rd]), 
    .A2(Instr_M[`rd]), 
    .Din(nRT_M), 
    .PC_M(((PC_M!=32'h00000000||ExcCode_Eout==4)?PC_M:(PC_E!=32'h00000000||ExcCode_Dout==4)?PC_E:(PC_D!=32'h00000000||ExcCode_Fout==4)?PC_D:PC)), 
    .ExcCodein(ExcCodein), 
    .HWInt(HWInt), 
    .We(CP0We), 
    .EXLSet(EXLSet), 
    .EXLCLr(EXLCLr), 
    .clk(clk), 
    .reset(reset), 
    .IntExc(IntExc), 
    .EPCout(EPCout), 
    .Dout(CP0Dout),
	 .BJ_M(((PC_M!=32'h00000000||ExcCode_Eout==4)?BJ_M:(PC_E!=32'h00000000||ExcCode_Dout==4)?BJ_E:(PC_D!=32'h00000000||ExcCode_Fout==4)?BJ_D:0))
    );
assign eret=(Instr_M[`op]==6'b010000&&Instr_M[`funct]==6'b011000)?1:0;
/////////////////////////////////W
//MW
wire [31:0] CP0Dout_W;
assign DM_M=(ALU_M>=32'h00000000&&ALU_M<32'h00003000)?ReadData:PrRD;
mw mwwire (
    .clk(clk), 
    .reset(reset|IntExc|eret), 
    .Instr_M(Instr_M), 
    .ALU_M(ALU_M), 
	 .MDout_M(MDout_M),
    .DM_M(DM_M), 
    .PC4_M(PC4_M), 
    .PC8_M(PC8_M), 
	 .WBA_M(WBA_M),
    .Instr_W(Instr_W), 
    .ALU_W(ALU_W),
    .MDout_W(MDout_W),	 
    .DM_W(DM_W), 
    .PC4_W(PC4_W), 
    .PC8_W(PC8_W),
	 .WBA_W(WBA_W),
	 .CP0Dout_M(CP0Dout),
	 .CP0Dout_W(CP0Dout_W)
    );
//controller_W
controller controller_W (
    .Instr(Instr_W), 
    .WD3sel_W(WD3sel_W), 
    .RegWrite(RegWrite)
    );
//WD3MUX
MUX8 WD3sel_WMUX (
    .in0(PC8_W), 
    .in1(ALU_W), 
	 .in2(MDout_W),	
    .in3(DM_W), 
	 .in4(CP0Dout_W),
    .out8(WD3_W), 
    .mux8op(WD3sel_W)
    );
/////////////////////////HAZARD
HAZARD HAZARDwire (
    .Instr_D(Instr_D), 
    .Instr_E(Instr_E), 
    .Instr_M(Instr_M), 
    .Instr_W(Instr_W), 
    .WBA_E(WBA_E), 
    .WD3_E(WD3_E), 
    .WBA_M(WBA_M), 
    .WD3_M(WD3_M), 
	 .WBA_W(WBA_W), 
    .WD3_W(WD3_W), 
    .RS_D(O1),
    .RT_D(O2),
    .RS_E(RS_E),
    .RT_E(RT_E),
    .RT_M(RT_M),
    .nRS_D(nRS_D), 
    .nRT_D(nRT_D), 
    .nRS_E(nRS_E), 
    .nRT_E(nRT_E), 
    .nRT_M(nRT_M), 
	 .Tuse_rs(Tuse_rs),
    .Tuse_rt(Tuse_rt),
    .Tnew_E(Tnew_E),
    .Tnew_M(Tnew_M),
	 .start(start),
	 .busy(busy),
    .stall(stall)
    );
assign PCEn=!stall;
assign clr=stall;
assign En=!stall;

assign PrAddr=ALU_M;
assign PrWD=nRT_M;
assign WeCPU=(MemWrite&(~(IntExc|eret)));
endmodule
