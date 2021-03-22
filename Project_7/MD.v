`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:14 11/23/2019 
// Design Name: 
// Module Name:    MD 
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
module MD(
    input clk,
    input reset,
    input [31:0] A,
    input [31:0] B,
    input start,
    input [2:0] MDsel,
    input mfsel,
    output [31:0] MDout,
    output reg busy
    );
    reg [31:0] LO=0;
	 reg [31:0] HI=0;
    integer mcount=0;
	 integer dcount=0;
	 assign MDout=(mfsel==0)?HI:LO;
    always @(posedge clk)begin
		if(reset==1)begin
			HI=0;
			LO=0;
			mcount=0;
			dcount=0;
			busy=0;
		end
		else begin
			case(MDsel)
				1: {HI,LO}=$signed(A)*$signed(B);
				2: {HI,LO}=A*B;
				3: if(B!=0)begin
						LO=$signed(A)/$signed(B);
						HI=$signed(A)%$signed(B);
			      end
				4: if(B!=0)begin
						LO=A/B;
						HI=A%B;
			      end
				5: HI=A;
				6: LO=A;
			endcase
			if(start==1)begin
				if(MDsel==1||MDsel==2)begin
					mcount=1;
					busy=1;
				end
				else if(MDsel==3||MDsel==4)begin
				   dcount=1;
					busy=1;
				end
			end
			else begin
				if(mcount==5)begin
					mcount=0;
					busy=0;
				end
				else if(dcount==10)begin
					dcount=0;
					busy=0;
				end
				else if(mcount!=0)begin
					mcount=mcount+1;
				end
				else if(dcount!=0)begin
					dcount=dcount+1;
				end
			end
		end
	 end	 
endmodule
