`timescale 1ns / 1ps

module Thread_Controller
(
    input clk,
    input rst,
    input enable,

    output reg [1:0] thread
);
    always @(posedge clk) begin
        if(rst && enable) thread = 0;
        else if(enable) thread = thread + 1'b1;
    end
endmodule