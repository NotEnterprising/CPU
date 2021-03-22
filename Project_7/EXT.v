`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:01 11/07/2019 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    output reg [31:0] EXTimm16,
    input [1:0] EXTop
    );
	 
    always @(*)begin
		case(EXTop)
		0:EXTimm16={16'h0000,imm16};
		1:EXTimm16={{16{imm16[15]}},imm16};
		2:EXTimm16={imm16,16'h0000};
		endcase
	 end

endmodule
