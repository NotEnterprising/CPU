`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:50 12/06/2019 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:0] PrAddr,
    output [31:0] PrRD,
    input [31:0] PrWD,
    input WeCPU,
    output [31:0] DEV_Addr,
    input [31:0] DEV0_RD,
    input [31:0] DEV1_RD,
    output [31:0] DEV_WD,
    output WeDEV0,
    output WeDEV1
    );
    wire Hit0;
	 wire Hit1;
	 
	 assign Hit0=(PrAddr[31:4]==28'h00007f0)?1:0;
    assign Hit1=(PrAddr[31:4]==28'h00007f1)?1:0;
	 assign PrRD=(Hit0)?DEV0_RD:
	             (Hit1)?DEV1_RD:
					 32'h00000000;
	 assign WeDEV0=WeCPU&Hit0;
	 assign WeDEV1=WeCPU&Hit1;
	 assign DEV_WD=PrWD;
	 assign DEV_Addr=PrAddr;
endmodule
