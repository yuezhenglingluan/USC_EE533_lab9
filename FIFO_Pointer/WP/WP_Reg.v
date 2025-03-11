`timescale 1ns / 1ps

module WP_Reg
(
    input clk,
    input rst,
    input WP_en,
    input FIFO_FULL,
    input [7:0] WP_next,

    output reg [7:0] WP
);

    always @(posedge clk) begin
        if (rst) begin
            WP <= 0;
        end
        else if(WP_en && !FIFO_FULL) begin
            WP <= WP_next;
        end
    end

endmodule