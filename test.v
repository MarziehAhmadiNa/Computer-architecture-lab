`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:18:17 03/07/2018
// Design Name:   top
// Module Name:   E:/LLAB4/test.v
// Project Name:  LLAB4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg reset;
	//reg [31:0] inpc;
	// Outputs
	wire [31:0] outtop;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.reset(reset), 
		//.inpc (inpc),
		.outtop(outtop)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		//inpc =0;
		// Wait 100 ns for global reset to finish
		#10000;
       reset= 0; 
		 //inpc =0;
		// Add stimulus here

	end
    always #5 clk = ~clk;  
endmodule

