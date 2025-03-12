`timescale 1ns / 1ps

module PC_plus_1
(
    input [63:0] PC,
    //input [63:0] ONE,
    input enable,

    output [63:0] PC_next
);

    assign PC_next = enable ? (PC + 1'b1) : PC;

endmodule