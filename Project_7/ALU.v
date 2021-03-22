`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:27 11/08/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	input [31:0] A,
	input [31:0] B,
	input [3:0] ALUop,
	output reg [31:0] result,
	output overflow
    );
initial begin
	over=0;
end
reg [32:0] over;
assign overflow=(over[32]==over[31])?0:1;
always @(*)begin
	case(ALUop)
	0: result=A&B;
	1: result=A|B;
	2: begin 
	   result=A+B;
		over={A[31],A}+{B[31],B};
	end
	3: begin 
	   result=A-B;
	   over={A[31],A}-{B[31],B};
	end 
	4: result=A^B;
	5: result=~(A|B);
	6: result=($signed(A)<$signed(B))?1:0;
	7: result=(A<B)?1:0;
	8: result=B<<A[4:0];
	9: result=B>>A[4:0];
	10: result=$signed(B)>>>A[4:0];
	endcase
end

endmodule
