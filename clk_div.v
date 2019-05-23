`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:28:04 02/20/2018 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(input clk,
					output reg clkout=0
    );
	 
	 reg [23:0] count=0;
	 always @(posedge clk)
		if(count[4] ==1'b1)
		begin
			clkout <= ~clkout;
			count <=0;
		end
		else
			count <= count + 1;

endmodule
