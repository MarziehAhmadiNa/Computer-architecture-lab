`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:57 02/21/2018 
// Design Name: 
// Module Name:    RegBank 
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
module RegBank(input clk,
					input reset,
					input [2:0] readReg1,
					input [2:0] readReg2,
					input [2:0] writeReg,
					input [31:0] writeData,
					input regWrite,
					output reg [31:0] readData1,
					output reg [31:0] readData2 
					
    );
	 
	reg [31:0] ram [7:0];
	 
	always @(posedge clk)
	begin 
		if(reset)
			begin
				ram [0] <= 0;
				ram [1] <= 0;
				ram [2] <= 0;
				ram [3] <= 0;
				ram [4] <= 0;
				ram [5] <= 0;
				ram [6] <= 0;
				ram [7] <= 0;
			end
		ram [0] <= 1;
		ram [1] <= 2;
		//ram [2] <= 3;
				
		if (regWrite == 1'b1)
			ram [writeReg] <= writeData;
		
		readData1 <= ram [readReg1];
		readData2 <= ram [readReg2];
		
	end

endmodule
