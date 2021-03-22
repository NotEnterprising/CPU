`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:44 11/16/2019 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC4,
    input [31:0] immbeq,
    input [25:0] imm26,
    input [31:0] cmp1,
    input [31:0] cmp2,
	 input [2:0] Branchop,
    output reg [31:0] branch,
    output [31:0] jump
    );
	assign jump={PC4[31:28],imm26,2'b00};
	always@(*)begin
		case(Branchop)
			0: branch=($signed(cmp1)==$signed(cmp2))?(PC4+(immbeq<<2)):(PC4+4);
			1: branch=($signed(cmp1)!=$signed(cmp2))?(PC4+(immbeq<<2)):(PC4+4);
			2: branch=($signed(cmp1)<=0)?(PC4+(immbeq<<2)):(PC4+4);
			3: branch=($signed(cmp1)>0)?(PC4+(immbeq<<2)):(PC4+4);
			4: branch=($signed(cmp1)<0)?(PC4+(immbeq<<2)):(PC4+4);
			5: branch=($signed(cmp1)>=0)?(PC4+(immbeq<<2)):(PC4+4);
		endcase
	end
endmodule
