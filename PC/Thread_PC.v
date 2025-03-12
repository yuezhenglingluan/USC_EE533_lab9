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
    reg PC_ctrl_1, PC_ctrl_2, PC_ctrl_3, PC_ctrl_4;
    reg [63:0] BTA1, BTA2, BTA3, BTA4;
    reg [63:0] PC_next_1, PC_next_2, PC_next_3, PC_next_4;
    reg [63:0] PC_next_to_mux_1, PC_next_to_mux_2, PC_next_to_mux_3, PC_next_to_mux_4;
    reg Counter_Enable_1, Counter_Enable_2, Counter_Enable_3, Counter_Enable_4;
    reg rst_1, rst_2, rst_3, rst_4;

    PC PC1(.clk(clk),.rst(rst),.PC_next(PC_next_1),.PC(PC1));
    PC PC2(.clk(clk),.rst(rst),.PC_next(PC_next_2),.PC(PC2));
    PC PC3(.clk(clk),.rst(rst),.PC_next(PC_next_3),.PC(PC3));
    PC PC4(.clk(clk),.rst(rst),.PC_next(PC_next_4),.PC(PC4));

    PC_plus_1 PC_plus_1_1(.PC(PC1), .enable(Counter_Enable_1), .PC_next(PC_next_to_mux_1));
    PC_plus_1 PC_plus_1_2(.PC(PC2), .enable(Counter_Enable_2), .PC_next(PC_next_to_mux_2));
    PC_plus_1 PC_plus_1_3(.PC(PC3), .enable(Counter_Enable_3), .PC_next(PC_next_to_mux_3));
    PC_plus_1 PC_plus_1_4(.PC(PC4), .enable(Counter_Enable_4), .PC_next(PC_next_to_mux_4));

    PC_MUX PC_MUX_1 (.BTA(BTA1), .PC_ctrl(PC_ctrl_1), .PC_next_in(PC_next_to_mux_1), .PC_next_out(PC_next_1));
    PC_MUX PC_MUX_2 (.BTA(BTA2), .PC_ctrl(PC_ctrl_2), .PC_next_in(PC_next_to_mux_2), .PC_next_out(PC_next_2));
    PC_MUX PC_MUX_3 (.BTA(BTA3), .PC_ctrl(PC_ctrl_3), .PC_next_in(PC_next_to_mux_3), .PC_next_out(PC_next_3));
    PC_MUX PC_MUX_4 (.BTA(BTA4), .PC_ctrl(PC_ctrl_4), .PC_next_in(PC_next_to_mux_4), .PC_next_out(PC_next_4));

    always @(*) begin
        case(rst)
            1'b1: begin
                // reset each PC individually
                case(thread)
                    2'b00: begin
                        rst_1 = 1'b1;
                        rst_2 = 1'b0;
                        rst_3 = 1'b0;
                        rst_4 = 1'b0;
                    end
                    2'b01: begin
                        rst_1 = 1'b0;
                        rst_2 = 1'b1;
                        rst_3 = 1'b0;
                        rst_4 = 1'b0;
                    end
                    2'b10: begin
                        rst_1 = 1'b0;
                        rst_2 = 1'b0;
                        rst_3 = 1'b1;
                        rst_4 = 1'b0;
                    end
                    2'b11: begin
                        rst_1 = 1'b0;
                        rst_2 = 1'b0;
                        rst_3 = 1'b0;
                        rst_4 = 1'b1;
                    end
                endcase
            end
            1'b0: begin

                // reset signal all clear
                rst_1 = 1'b0;
                rst_2 = 1'b0;
                rst_3 = 1'b0;
                rst_4 = 1'b0;

                case(thread)
                    2'b00: begin
                        PC_out = PC1;
                        PC_ctrl_4 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                        BTA4 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                        Counter_Enable_1 = 1'b1;
                        Counter_Enable_2 = 1'b0;
                        Counter_Enable_3 = 1'b0;
                        Counter_Enable_4 = 1'b0;
                
                    end
                    2'b01: begin
                        PC_out = PC2;
                        PC_ctrl_1 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                        BTA1 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                        Counter_Enable_1 = 1'b0;
                        Counter_Enable_2 = 1'b1;
                        Counter_Enable_3 = 1'b0;
                        Counter_Enable_4 = 1'b0;
                    end
                    2'b10: begin
                        PC_out = PC3;
                        PC_ctrl_2 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                        BTA2 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                        Counter_Enable_1 = 1'b0;
                        Counter_Enable_2 = 1'b0;
                        Counter_Enable_3 = 1'b1;
                        Counter_Enable_4 = 1'b0;
                    end
                    2'b11: begin
                        PC_out = PC4;
                        PC_ctrl_3 = PC_ctrl_in;  // Control signal is given by Branch Decision Unit in ID stage, hence it is one cycle behind
                        BTA3 = BTA_in;  // BTA_in is given by Offset Extend Unit in ID stage, hence it is one cycle behind

                        Counter_Enable_1 = 1'b0;
                        Counter_Enable_2 = 1'b0;
                        Counter_Enable_3 = 1'b0;
                        Counter_Enable_4 = 1'b1;
                    end
                endcase
            end
        endcase
    end
endmodule