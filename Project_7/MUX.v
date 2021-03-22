`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:27 11/08/2019 
// Design Name: 
// Module Name:    MUX 
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

module MUX8(in0,in1,in2,in3,in4,in5,in6,in7,out8,mux8op
    );
	 parameter width=32;
	 input [width-1:0] in0;
    input [width-1:0] in1;
    input [width-1:0] in2;
    input [width-1:0] in3;
	 input [width-1:0] in4;
	 input [width-1:0] in5;
	 input [width-1:0] in6;
	 input [width-1:0] in7;
    output reg [width-1:0] out8;
    input [2:0] mux8op;
always@(*)begin
	case(mux8op)
			0:out8=in0;
			1:out8=in1;
			2:out8=in2;
			3:out8=in3;
			4:out8=in4;
			5:out8=in5;
			6:out8=in6;
			7:out8=in7;
	endcase
end
endmodule

module MUX2(in0,in1,out2,mux2op);
	 parameter width=32;
	 input [width-1:0] in0;
    input [width-1:0] in1;
    output reg [width-1:0] out2;
    input mux2op;
    always@(*)begin
		case(mux2op)
			0:out2=in0;
			1:out2=in1;
		endcase
	 end
endmodule

module MUX4(in0,in1,in2,in3,out4,mux4op);
	 parameter width=32;
	 input [width-1:0] in0;
    input [width-1:0] in1;
    input [width-1:0] in2;
    input [width-1:0] in3;
	 output reg [width-1:0] out4;
    input [1:0] mux4op;
always@(*)begin
	case(mux4op)
			0:out4=in0;
			1:out4=in1;
			2:out4=in2;
			3:out4=in3;
	endcase
end
endmodule


