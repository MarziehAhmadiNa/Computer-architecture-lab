`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:41 02/21/2018 
// Design Name: 
// Module Name:    memory 
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
module memory(input clk,
				  input reset,
				  input we,re,
				  input [31:0] wData,
				  input [2:0] add,
				  output reg [31:0] rData
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
		ram [2] <= 3;
		
		if (we)
			ram[add] <= wData;
		else if (re)
			rData <= ram[add];
	end

endmodule
