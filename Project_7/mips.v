`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:52 12/06/2019 
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
module mips(
    input clk,
	 input reset,
	 input interrupt,
	 output [31:0] addr
    );
wire [31:0] PrAddr;
wire [31:0] PrRD;
wire [31:0] PrWD;
wire [5:0] HWInt;
wire [31:0] DEV_Addr;
wire WeCPU;
wire [31:0] DEV0_RD;
wire [31:0] DEV1_RD;
wire [31:0] DEV_WD;
wire WeDEV0;
wire WeDEV1;
wire IRQ0;
wire IRQ1;
assign HWInt[5:0]={3'b0,interrupt,IRQ1,IRQ0};
wire [31:0] PC_M;
assign addr=PC_M;
Bridge Bridgewire (
    .PrAddr(PrAddr), 
    .PrRD(PrRD), 
    .PrWD(PrWD), 
    .WeCPU(WeCPU), 
    .DEV_Addr(DEV_Addr), 
    .DEV0_RD(DEV0_RD), 
    .DEV1_RD(DEV1_RD), 
    .DEV_WD(DEV_WD), 
    .WeDEV0(WeDEV0), 
    .WeDEV1(WeDEV1)
    );
CPU CPUwire (
    .clk(clk), 
    .reset(reset), 
    .PrRD(PrRD), 
    .HWInt(HWInt), 
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .WeCPU(WeCPU),
	 .addr(PC_M)
    );
TC0 TC0wire (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEV_Addr[31:2]), 
    .WE(WeDEV0), 
    .Din(DEV_WD), 
    .Dout(DEV0_RD), 
    .IRQ(IRQ0)
    );
TC1 TC1wire (
    .clk(clk), 
    .reset(reset), 
    .Addr(DEV_Addr[31:2]), 
    .WE(WeDEV1), 
    .Din(DEV_WD), 
    .Dout(DEV1_RD), 
    .IRQ(IRQ1)
    );
endmodule
