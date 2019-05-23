`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:37 02/21/2018 
// Design Name: 
// Module Name:    alu 
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
module alu(input [31:0] a,b,
			  input [2:0] mod,
			  output reg [31:0] out,
			  output zero
    );
	
	assign zero = 0; // = (a-b == 32'b0) ? 1 : 0;
	
	always @(*)
		case(mod)
			3'b010: out = a+b;
			3'b110: out = a-b;
			3'b000: out = a&b;
			//3'b001: out = !(a|b);
			3'b111: out = (a<b) ? 1:0;
			3'b001: out = a|b;
		endcase
endmodule
