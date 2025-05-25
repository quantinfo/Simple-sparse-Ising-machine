`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2025 09:50:41 AM
// Design Name: Synchronous FA
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Updates the input PBits of Full Adder.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// NOTE: FA PBits in order m[0:4] = In_1, In_2, C_in, Sum, C_out
//////////////////////////////////////////////////////////////////////////////////


module main(
    input SYS_CLK_100M_P,
    input SYS_CLK_100M_N,
    output W_LED_0,
    output W_LED_1,
    output W_LED_2
    );


wire sample_clk;
wire pbA_clk;
wire pbB_clk;
wire pbC_clk;

wire [45:0] LFSR_A;
wire [45:0] LFSR_B;
wire [45:0] LFSR_C;
reg [2:0] BiasedRNG;
reg [0:4] m;// = 5'b10001; //MSB is m[0] to match what I did in python
initial m[3]=0;
initial m[4]=1;

// Do the following or it synthesizes m away!
assign W_LED_0=m[0];
assign W_LED_1=m[1];
assign W_LED_2=m[2];

//Generate the pseudo-entropy source:
lfsr #(.seed(46'b0010110111100101000000011010101100110100010101)) LFSR0(.LFSRregister(LFSR_A[45:0]),.clk(sample_clk));
lfsr #(.seed(46'b0011110000101011000110100000101011100100010011)) LFSR1(.LFSRregister(LFSR_B[45:0]),.clk(pbA_clk));
lfsr #(.seed(46'b1100001101001100000011110100110010101011010011)) LFSR2(.LFSRregister(LFSR_C[45:0]),.clk(pbB_clk));

//NOTE: Put all the repetitive always blocks inside generate statements.

always @(posedge sample_clk) begin
    BiasedRNG[0] = (LFSR_A[6]&LFSR_A[24]&LFSR_A[15]&LFSR_A[43]&LFSR_A[27]);
end

always @(posedge pbA_clk) begin
    BiasedRNG[1] = (LFSR_B[6]&LFSR_B[24]&LFSR_B[15]&LFSR_B[43]&LFSR_B[27]);
end

always @(posedge pbB_clk) begin
    BiasedRNG[2] = (LFSR_C[6]&LFSR_C[24]&LFSR_C[15]&LFSR_C[43]&LFSR_C[27]);
end

always @(posedge pbA_clk) begin
    m[0] = ((((~m[1]&~m[2]&~m[3]&~m[4])|(~m[1]&m[2]&m[3]&~m[4])|(m[1]&~m[2]&m[3]&~m[4])|(m[1]&m[2]&~m[3]&m[4]))&BiasedRNG[0])|
                  (((~m[1]&~m[2]&m[3]&~m[4])|(~m[1]&m[2]&~m[3]&m[4])|(m[1]&~m[2]&~m[3]&m[4])|(m[1]&m[2]&m[3]&m[4]))&(~BiasedRNG[0]))|
                  ((~m[1]&~m[2]&~m[3]&m[4])|(~m[1]&~m[2]&m[3]&m[4])|(~m[1]&m[2]&m[3]&m[4])|(m[1]&~m[2]&m[3]&m[4])));
end 

always @(posedge pbB_clk) begin
    m[1] = ((((~m[0]&~m[2]&~m[3]&~m[4])|(~m[0]&m[2]&m[3]&~m[4])|(m[0]&~m[2]&m[3]&~m[4])|(m[0]&m[2]&~m[3]&m[4]))&BiasedRNG[1])|
                  (((~m[0]&~m[2]&m[3]&~m[4])|(~m[0]&m[2]&~m[3]&m[4])|(m[0]&~m[2]&~m[3]&m[4])|(m[0]&m[2]&m[3]&m[4]))&(~BiasedRNG[1]))|
                  ((~m[0]&~m[2]&~m[3]&m[4])|(~m[0]&~m[2]&m[3]&m[4])|(~m[0]&m[2]&m[3]&m[4])|(m[0]&~m[2]&m[3]&m[4])));
end

always @(posedge pbC_clk) begin
    m[2] = ((((~m[0]&~m[1]&~m[3]&~m[4])|(~m[0]&m[1]&m[3]&~m[4])||(m[0]&~m[1]&m[3]&~m[4])|(m[0]&m[1]&~m[3]&m[4]))&BiasedRNG[2])|
                  (((~m[0]&~m[1]&m[3]&~m[4])|(~m[0]&m[1]&~m[3]&m[4])|(m[0]&~m[1]&~m[3]&m[4])|(m[0]&m[1]&m[3]&m[4]))&(~BiasedRNG[2]))|
                  ((~m[0]&~m[1]&~m[3]&m[4])|(~m[0]&~m[1]&m[3]&m[4])|(~m[0]&m[1]&m[3]&m[4])|(m[0]&~m[1]&m[3]&m[4])));
end


// Instantiate PLL 
clk_wiz_0 myPLL(
    // Clock out ports
    .clk_out1(sample_clk),   // 350 MHz 0 deg
    .clk_out2(pbA_clk),  // 350 MHz 90 deg
    .clk_out3(pbB_clk),  // 350 MHz 180.00 deg
    .clk_out4(pbC_clk),   // 350 MHz 270. deg
   // Clock in ports
    .clk_in1_p(SYS_CLK_100M_P),.clk_in1_n(SYS_CLK_100M_N)      // input clk_in1, 100 MHz pair
);

//Instantiate ILA:

//To test the FA:
//ila_0 ILAinst (
//	.clk(sample_clk), 
//	.probe0(m[0:4]),
//	.probe1(LFSR_A[6]),
//	.probe2(LFSR_A[24]),
//	.probe3(LFSR_A[15]),
//	.probe4(LFSR_A[43]),
//	.probe5(LFSR_A[27]),
//	.probe6(BiasedRNG[0])
//);


endmodule

//Module for generating LFSR:
module lfsr #(parameter seed = 46'b1) (output reg[45:0] LFSRregister, input clk);

//Set it to the seed to begin:
initial begin
    LFSRregister = seed;
end

//Shift and replace zeroth bit:
always @(negedge clk) begin
    LFSRregister[45:0] = {LFSRregister[44:0],(LFSRregister[45] ^ LFSRregister[39] ^ LFSRregister[38] ^ LFSRregister[37])};
end
endmodule
