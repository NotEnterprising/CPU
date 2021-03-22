`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:02:05 11/07/2019 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] Address,
    input [31:0] WD,
	 input [2:0] loadsel,
	 input [1:0] storesel,
    input MemWrite,
    input clk,
    input reset,
	 input [31:0] PC,
    output reg [31:0] ReadData
    );
    reg [31:0] RAM [4095:0]; 
	 integer i;
initial begin
	for(i=0;i<=4095;i=i+1)begin
				RAM[i]=0;
	end
end
    always @(posedge clk)begin
		if(reset==1)begin
			for(i=0;i<=4095;i=i+1)begin
				RAM[i]=0;
			end
		end
		else if(MemWrite==1) begin
		   case(storesel)
			   0: case(Address[1:0])
						0: RAM[Address[13:2]][7:0]=WD[7:0];
						1: RAM[Address[13:2]][15:8]=WD[7:0];
						2: RAM[Address[13:2]][23:16]=WD[7:0];
						3: RAM[Address[13:2]][31:24]=WD[7:0];
					endcase
				1: case(Address[1])
						0: RAM[Address[13:2]][15:0]=WD[15:0];
						1: RAM[Address[13:2]][31:16]=WD[15:0];
					endcase
				2: RAM[Address[13:2]]=WD;
			endcase
			$display("%d@%h: *%h <= %h", $time,PC,{Address[31:2],2'b00},RAM[Address[13:2]]); 
		end
    end
always @(*)begin
	case(loadsel)
		0: case(Address[1:0])
				0:ReadData=$signed(RAM[Address[13:2]][7:0]);
				1:ReadData=$signed(RAM[Address[13:2]][15:8]);
				2:ReadData=$signed(RAM[Address[13:2]][23:16]);
				3:ReadData=$signed(RAM[Address[13:2]][31:24]);
		   endcase
		1: case(Address[1:0])
				0:ReadData=RAM[Address[13:2]][7:0];
				1:ReadData=RAM[Address[13:2]][15:8];
				2:ReadData=RAM[Address[13:2]][23:16];
				3:ReadData=RAM[Address[13:2]][31:24];
		   endcase
		2: case(Address[1])
		      0:ReadData=$signed(RAM[Address[13:2]][15:0]);
				1:ReadData=$signed(RAM[Address[13:2]][31:16]);
		   endcase
		3: case(Address[1])
		      0:ReadData=RAM[Address[13:2]][15:0];
				1:ReadData=RAM[Address[13:2]][31:16];
		   endcase
		4: ReadData=RAM[Address[13:2]];
	endcase
end
endmodule
