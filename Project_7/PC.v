`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:22 11/15/2019 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
    input PCEn,
    input [31:0] nPC,
	 input IntExc,
	 input eret,
	 input [31:0] EPCout,
	 output reg [31:0] PC,
	 output [4:0] ExcCode_F
    );
initial begin
	PC=32'h00003000;
end
always@(posedge clk)begin
	if(reset==1)begin
		PC=32'h00003000;
	end
	else if(PCEn==1)begin
		if(eret==1&&IntExc==0) begin 
		   PC=EPCout;
		end
		else if(IntExc==0&&eret==0) PC=nPC;
		else if(IntExc==1) PC=32'h00004180;
	end
end
assign ExcCode_F=(PC<32'h00003000||PC>32'h00004ffc||(PC[1:0]!=2'b00))?4:0;
endmodule
