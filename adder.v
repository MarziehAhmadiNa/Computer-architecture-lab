`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:46 02/21/2018 
// Design Name: 
// Module Name:    adder 
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
module pc(input clk,
			 input reset,
			 input [31:0] in,
			 output reg [31:0] out
    );
	 
	 wire myclk;
	// wire [31:0] ins;
	// reg [31:0] outs;

	 clk_div c1( clk, myclk );
	 
	 always @(posedge myclk)
		if(reset)
			out = 32'd0;
		else
			out = in;
	 
	// inc inc1( outs, ins );
	// assign out = (reset) ? 0 : in;
	 
	
endmodule
