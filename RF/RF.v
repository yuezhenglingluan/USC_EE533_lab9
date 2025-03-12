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
    input [1:0] thread,

    output reg [63:0] r0data,
    output reg [63:0] r1data
);

    reg signed [63:0] RF1 [7:0];
    reg signed [63:0] RF2 [7:0];
    reg signed [63:0] RF3 [7:0];
    reg signed [63:0] RF4 [7:0];

	integer i;

    always @(posedge clk) begin
        case(thread)
            2'b00: begin  // thread 1
                if (rst == 1) begin
                    for (i = 0; i < 8; i = i + 1) RF1[i] <= 64'b0;
                end else if (wena == 1) RF1[waddr] <= wdata;
            end
            2'b01: begin  // thread 2
                if (rst == 1) begin
                    for (i = 0; i < 8; i = i + 1) RF2[i] <= 64'b0;
                end else if (wena == 1) RF2[waddr] <= wdata;
            end
            2'b01: begin  // thread 3
                if (rst == 1) begin
                    for (i = 0; i < 8; i = i + 1) RF3[i] <= 64'b0;
                end else if (wena == 1) RF3[waddr] <= wdata;
            end
            2'b11: begin  // thread 4
                if (rst == 1) begin
                    for (i = 0; i < 8; i = i + 1) RF4[i] <= 64'b0;
                end else if (wena == 1) RF4[waddr] <= wdata;
            end
        endcase

    end

    always @(*) begin
        case(thread)
            2'b00: begin  // thread 1
                r0data = ((waddr == r0addr) && wena) ? RF1[waddr] : RF1[r0addr];
                r1data = ((waddr == r1addr) && wena) ? RF1[waddr] : RF1[r1addr];
            end
            2'b01: begin  // thread 2
                r0data = ((waddr == r0addr) && wena) ? RF2[waddr] : RF2[r0addr];
                r1data = ((waddr == r1addr) && wena) ? RF2[waddr] : RF2[r1addr];
            end
            2'b01: begin  // thread 3
                r0data = ((waddr == r0addr) && wena) ? RF3[waddr] : RF3[r0addr];
                r1data = ((waddr == r1addr) && wena) ? RF3[waddr] : RF3[r1addr];
            end
            2'b11: begin  // thread 4
                r0data = ((waddr == r0addr) && wena) ? RF4[waddr] : RF4[r0addr];
                r1data = ((waddr == r1addr) && wena) ? RF4[waddr] : RF4[r1addr];
            end
        endcase
    end
    // assign r0data = ((waddr == r0addr) && wena) ? RF[waddr] : RF[r0addr];
    // assign r1data = ((waddr == r1addr) && wena) ? RF[waddr] : RF[r1addr];

endmodule