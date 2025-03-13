`timescale 1ns / 1ps

module PC_plus_1_tb;

	// Inputs
	reg [63:0] PC;
	reg enable;

	// Outputs
	wire [63:0] PC_next;

	// Instantiate the Unit Under Test (UUT)
	PC_plus_1 uut (.PC(PC), .enable(enable), .PC_next(PC_next));

	initial begin
		PC = 0; enable = 1;	// Initialize Inputs
		#100; 	// Wait 100 ns for global reset to finish
		#100 PC = 1;
		#100 PC = 2;
		#100 PC = 3;
		#100 enable = 0;
		#200 $stop;
	end
      
endmodule

