`timescale 1ns / 1ps

module Thread_PC_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] thread;
    reg PC_ctrl_in;
    reg [63:0] BTA_in;

	// Outputs
	wire [63:0] PC_out;

	// Instantiate the Unit Under Test (UUT)
	Thread_PC uut(.clk(clk), .rst(rst), .thread(thread), .PC_ctrl_in(PC_ctrl_in), .BTA_in(BTA_in), .PC_out(PC_out));
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		#0  clk = 0; rst = 1; PC_ctrl_in = 1'b0; BTA_in = 64'b0;
        #0  thread = 2'b00;
        #20 thread = 2'b01;
        #20 thread = 2'b10;
        #20 thread = 2'b11;

		#0  rst = 0;    // Wait 10 ns for global reset to finish

        // Let it run for 12 clock cycles
        #10 thread = 2'b00;
        #10 thread = 2'b01;
        #10 thread = 2'b10;
        #10 thread = 2'b11;
        #10 thread = 2'b00;
        #10 thread = 2'b01;
        #10 thread = 2'b10;
        #10 thread = 2'b11;
        #10 thread = 2'b00;
        #10 thread = 2'b01;
        #10 thread = 2'b10;
        #10 thread = 2'b11;


        // Testing PC_MUX
        #10 PC_ctrl_in = 1'b1;
        #10 BTA_in = 64'd10; thread = 2'b00;
        #10 BTA_in = 64'd22; thread = 2'b01;
        #10 BTA_in = 64'd44; thread = 2'b10;
        #10 BTA_in = 64'd99; thread = 2'b11;
        #10 BTA_in = 64'd11; thread = 2'b00;

        $stop;

	end
      
endmodule
