`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:49 11/08/2019 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] WriteAdd,
    input clk,
    input reset,
    input RegWrite,
    input [31:0] WD3,
	 input [31:0] PC,
    output [31:0] O1,
    output [31:0] O2
    );
	 reg [31:0] Register[31:0];
	 integer i;
initial begin
	for(i=0;i<=31;i=i+1)begin
		Register[i]=0;
	end
end
assign O1=(WriteAdd==A1&&RegWrite&&WriteAdd!=0)?WD3:Register[A1];
assign O2=(WriteAdd==A2&&RegWrite&&WriteAdd!=0)?WD3:Register[A2];
always@(posedge clk)begin
	if(reset==1)begin
		for(i=0;i<=31;i=i+1)begin
		Register[i]=0;
	   end
	end
	else if(RegWrite==1&&WriteAdd!=0)begin
		Register[WriteAdd]=WD3;
		$display("%d@%h: $%d <= %h", $time, PC, WriteAdd,WD3); 
	end
end
endmodule
