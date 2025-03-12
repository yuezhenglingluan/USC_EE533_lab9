`timescale 1ns / 1ps

module Thread_Controller_tb();
    reg clk;
    reg rst;
    reg enable;

    wire [1:0] thread;

    Thread_Controller uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),

        .thread(thread)
    );

    always #10 clk = ~clk;

    initial begin
        #0  rst = 1; enable = 1; clk = 0;  // initial reset
        #20 rst = 0; 
        #20;
        #20;
        #20;
        #20;
        #20;
        #20 enable = 0;
        #20 rst = 1;
        #20;
        #20;
        #20 rst = 0; enable = 1;
        #20;
        #20;
        #20;
        #20 rst = 1;
        #20 $stop;
    end
endmodule