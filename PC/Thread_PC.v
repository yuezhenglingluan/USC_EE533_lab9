module Thread_PC(
    input clk,
    input rst,
    //input [63:0] PC_next,
    input [1:0] thread,

    // Inputs for PC_MUX
    input PC_ctrl_in,
    input [63:0] BTA_in,

    output reg [63:0] PC_out
);

    reg [63:0] PC1, PC2, PC3, PC4;
    reg PC_ctrl1, PC_ctrl2, PC_ctrl3, PC_ctrl4;
    reg [63:0] BTA1, BTA2, BTA3, BTA4;
    reg [63:0] PC_next1, PC_next2, PC_next3, PC_next4;
    reg [63:0] PC_next_to_mux1, PC_next_to_mux2, PC_next_to_mux3, PC_next_to_mux4;
    reg Counter_Enable1, Counter_Enable2, Counter_Enable3, Counter_Enable4;

    PC PC1(.clk(clk),.rst(rst),.PC_next(PC_next1),.PC(PC1));
    PC PC2(.clk(clk),.rst(rst),.PC_next(PC_next2),.PC(PC2));
    PC PC3(.clk(clk),.rst(rst),.PC_next(PC_next3),.PC(PC3));
    PC PC4(.clk(clk),.rst(rst),.PC_next(PC_next4),.PC(PC4));

    PC_plus_1 PC_plus_1_1(.PC(PC1), .enable(Counter_Enable1), .PC_next(PC_next_to_mux1));
    PC_plus_1 PC_plus_1_2(.PC(PC2), .enable(Counter_Enable2), .PC_next(PC_next_to_mux2));
    PC_plus_1 PC_plus_1_3(.PC(PC3), .enable(Counter_Enable3), .PC_next(PC_next_to_mux3));
    PC_plus_1 PC_plus_1_4(.PC(PC4), .enable(Counter_Enable4), .PC_next(PC_next_to_mux4));

    PC_MUX PC_MUX_1 (.BTA(BTA1), .PC_ctrl(PC_ctrl1), .PC_next_in(PC_next_to_mux1), .PC_next_out(PC_next1));
    PC_MUX PC_MUX_2 (.BTA(BTA2), .PC_ctrl(PC_ctrl2), .PC_next_in(PC_next_to_mux2), .PC_next_out(PC_next2));
    PC_MUX PC_MUX_3 (.BTA(BTA3), .PC_ctrl(PC_ctrl3), .PC_next_in(PC_next_to_mux3), .PC_next_out(PC_next3));
    PC_MUX PC_MUX_4 (.BTA(BTA4), .PC_ctrl(PC_ctrl4), .PC_next_in(PC_next_to_mux4), .PC_next_out(PC_next4));

    always @(*) begin
        case(thread)
            2'b00: begin
                PC_out = PC1;
                PC_ctrl4 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                BTA4 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                Counter_Enable1 = 1'b1;
                Counter_Enable2 = 1'b0;
                Counter_Enable3 = 1'b0;
                Counter_Enable4 = 1'b0;
            end
            2'b01: begin
                PC_out = PC2;
                PC_ctrl1 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                BTA1 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                Counter_Enable1 = 1'b0;
                Counter_Enable2 = 1'b1;
                Counter_Enable3 = 1'b0;
                Counter_Enable4 = 1'b0;
            end
            2'b10: begin
                PC_out = PC3;
                PC_ctrl2 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                BTA2 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                Counter_Enable1 = 1'b0;
                Counter_Enable2 = 1'b0;
                Counter_Enable3 = 1'b1;
                Counter_Enable4 = 1'b0;
            end
            2'b11: begin
                PC_out = PC4;
                PC_ctrl3 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                BTA3 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                Counter_Enable1 = 1'b0;
                Counter_Enable2 = 1'b0;
                Counter_Enable3 = 1'b0;
                Counter_Enable4 = 1'b1;
            end
        endcase
    end
endmodule