`timescale 1ns / 1ps

module RF
(
    input clk,
    input rst,
    input wena,
    input [63:0] wdata,
    input [2:0] waddr,
    input [2:0] r0addr,
    input [2:0] r1addr,

    output signed [63:0] r0data,
    output signed [63:0] r1data
);

    reg signed [63:0] RF [7:0];
	 
	integer i;

    assign r0data = ((waddr == r0addr) && wena) ? RF[waddr] : RF[r0addr];
    assign r1data = ((waddr == r1addr) && wena) ? RF[waddr] : RF[r1addr];

    always @(posedge clk) begin
        if (rst == 1)
        begin
            for (i = 0; i < 8; i = i + 1) begin
                RF[i] <= 64'b0;
            end
        end
        else if (wena == 1)
        begin
            RF[waddr] <= wdata;
        end
    end



endmodule