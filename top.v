`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:46:14 02/20/2018 
// Design Name: 
// Module Name:    top 
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
module top(input clk,reset,
			  output reg [31:0]outtop
    );
	
	wire [31:0] out_inst,
					outalu1,
					outalu2,
					outmux1,
					outmux2,
					outmux3,
					outmux4,
					outmux5,
					rDatamem;
					
	wire [31:0] outpc,
					outinc;
					
	wire [31:0] readData1,
					readData2,
					outsign;
					
	wire zero, zero1;
				
	reg [1:0]ALUOp;
	reg [2:0] mod;
	reg RegDst,
		 MemRead,
	    MemToReg,
	    PcSrc,
		 MemWrite,
		 ALUSrc,
		 RegWrite,
		 Branch,
		 Jump,
		 sel;	
	
	pc mpc (
    .clk(clk), 
	 .reset(reset),
    .in(outmux5), 
    .out(outpc)
    );
	 
	inc minc (
    .in(outpc), 
    .out(outinc)
    );
	 
	 signExtend sign (
    .in(out_inst[15:0]), 
    .out(outsign)
    );
	 
	 alu myalu1 (          // jame pc ba address branch 
	 .a(outinc),            //address jump
	 .b(outsign), 
    .mod(3'b010), 
    .out(outalu1),        //a+b
	 .zero(zero1)
    );
	 
	  mux mux4 (           //entekhab beyne address branch ke ba pc jam shode va khode pc
	 .in1(outinc),        
    .in2(outalu1),      
	 .s(Branch & zero),
    .out(outmux4)
    );
	 
	mux mux5 (                //mux baraye entekhab beyne (pc ya branch) ba jump
    .in1(outmux4), 
    .in2({6'b0,out_inst[25:0]}), 
	 .s(Jump),               //if jump=1 add jump  else jump=0 add branch ya pc 
    .out(outmux5)
    );
	
	instruction myinstruction (
    .readAdd(outpc), 
    .out(out_inst)
    );

	mux mux1 (                //mux ghabl az regbank
    .in1({27'b0,out_inst[20:16]}), 
    .in2({27'b0,out_inst[15:11]}), 
    .s(RegDst), 
    .out(outmux1)
    ); 
	 
	RegBank myRegBank (
    .clk(clk), 
	 .reset(reset),
    .readReg1(out_inst[23:21]), 
    .readReg2(out_inst[18:16]), 
    .writeReg(outmux1), 
    .writeData(outmux3), 
    .regWrite(RegWrite), 
    .readData1(readData1), 
    .readData2(readData2)
    );
		
	mux mux2 (          //mux ghabl az aluasli
    .in1(readData2), 
    .in2(outsign), 
    .s(ALUSrc), 
    .out(outmux2)
    );
	 	
	alu aluasli (
    .a(readData1), 
    .b(outmux2), 
    .mod(mod), 
    .out(outalu2),
	 .zero(zero)
    );
	 
	 memory Mem (
    .clk(clk), 
	 .reset(reset),
    .we(MemWrite), 
    .re(MemRead), 
    .wData(readData2), 
    .add(outalu2), 
	 .rData(rDatamem)
    );

	 mux mux3 (     // mux bad az memory
    .in1(outalu2), 
    .in2(rDatamem), 
    .s(MemToReg), 
    .out(outmux3)
    );
	 

	 always @(posedge clk)
	 begin
		case(out_inst[31:26])
			6'b0://R_Type
			begin	
				RegDst <= 1;
				MemRead <= 0;
				MemToReg <= 0;
				ALUOp <= 2'b10;
				MemWrite <= 0;
				ALUSrc <= 0;
				RegWrite <= 1;	
				PcSrc <= 0;
				Branch <= 0;
				Jump <= 0;
			end
			
			
			6'b100011: //load
			begin	
				RegDst <= 0;
				MemRead <= 1;
				MemToReg <= 1;
				ALUOp <= 2'b00;
				MemWrite <= 0;
				ALUSrc <= 1;
				RegWrite <= 1;	
				PcSrc <= 0;
				Branch <= 0;
				Jump <= 0;
			end
			
			6'b101011: //store
			begin	
				RegDst <= 1'bx;
				MemRead <= 0;
				MemToReg <= 1'bx;
				ALUOp <= 2'b00;
				MemWrite <= 1;
				ALUSrc <= 1;
				RegWrite <= 0;	
				PcSrc <= 0;
				Branch <= 0;
				Jump <= 0;
			end
			
			6'b000010://jump
			begin	
					RegDst <= 1'bx;
					MemRead <= 1'bx;
					MemToReg <= 1'bx;
					ALUOp <= 2'bxx;
					MemWrite <= 1'bx;
					ALUSrc <= 1'bx;
					RegWrite <= 1'bx;	
					PcSrc <= 1;
					Branch <= 0;
					Jump <= 1;
			end
			
			6'b000100://branch
			begin	
					RegDst <= 1'bx;
					MemRead <= 1'b0;
					MemToReg <= 1'bx;
					ALUOp <= 2'b01;
					MemWrite <= 1'b0;
					ALUSrc <= 1'b0;
					RegWrite <= 1'b0;	
					PcSrc <= 1;
					Branch <= 1;
					Jump <= 0;
			end
			
			default
				begin	
					RegDst <= 0;
					MemRead <= 0;
					MemToReg <= 0;
					ALUOp <= 2'b0;
					MemWrite <= 0;
					ALUSrc <= 0;
					RegWrite <= 0;	
					PcSrc <= 0;
					Branch <= 0;
					Jump <= 0;
			end
		endcase
		
		case (ALUOp)
			2'b0: mod <= 3'b010;
			2'b10: 
			begin
					if(out_inst[5:0] == 6'b100000)
						mod <= 3'b010;
					if(out_inst[5:0] == 6'b100010)
						mod <= 3'b110;
					if(out_inst[5:0] == 6'b100100)
						mod <= 3'b000;
					if(out_inst[5:0] == 6'b100101)
						mod <= 3'b001;
					if(out_inst[5:0] == 6'b101010)
						mod <= 3'b111;
			end
			default mod <= 3'b011;
		endcase
		
			outtop <= outalu2;
	end
	
endmodule
