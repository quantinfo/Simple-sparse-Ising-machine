`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 11:42:19 AM
// Design Name: 
// Module Name: ANDgate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Updates inputs A and B (m[0:1]) of the AND gate with output C clamped to 0
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ANDgate(
    input SYS_CLK_100M_P,
    input SYS_CLK_100M_N,
    output W_LED_0,
    output W_LED_1
    );

wire sample_clk;
wire color0_clk;
wire color1_clk;
reg run = 0;
wire [45:0] LFSRcolor0;
wire [45:0] LFSRcolor1;
reg [1:0] UnbiasedRNG;
reg [0:1] m;

wire C;

assign C = 0;
assign W_LED_0=m[0];
assign W_LED_1=m[1];

// Here is where I instantiate the RNG:
lfsr #(.seed(46'b0010110111100101000000011010101100110100010101)) LFSR0_0(.LFSRregister(LFSRcolor0[45:0]),.clk(sample_clk));
lfsr #(.seed(46'b0011110000101011000110100000101011100100010011)) LFSR0_1(.LFSRregister(LFSRcolor1[45:0]),.clk(color0_clk));

always @(posedge color0_clk) begin
    m[0] = (~m[1] & ~C & UnbiasedRNG[0]) | (~m[1] & C) | (m[1] & C);
end

always @(posedge color1_clk) begin
    m[1] = (~m[0] & ~C & UnbiasedRNG[1]) | (~m[0] & C) | (m[0] & C);
end

always @(posedge sample_clk) begin
    UnbiasedRNG[0] = LFSRcolor0[13];//LFSRcolor0[1] ^ LFSRcolor0[13] ^ LFSRcolor0[19] ^ LFSRcolor0[29] ^ LFSRcolor0[41];
end 

always @(posedge color0_clk) begin
    UnbiasedRNG[1] = LFSRcolor1[13];//LFSRcolor1[1] ^ LFSRcolor1[13] ^ LFSRcolor1[19] ^ LFSRcolor1[29] ^ LFSRcolor1[41];
end 

// Instantiate PLL 
clk_wiz_0 myPLL(
    // Clock out ports
	.clk_out1(sample_clk),     // output 400 MHz 0 deg
	.clk_out2(color0_clk),     // output 400 MHz, 120 deg
	.clk_out3(color1_clk),   // output 400 MHz, 240 deg
   // Clock in ports
    .clk_in1_p(SYS_CLK_100M_P),.clk_in1_n(SYS_CLK_100M_N)
);

//Instantiate ILA:
ila_0 ILAinst (
	.clk(sample_clk), // slow or sys clk
	.probe0(m[0:1]) // input wire [1:0]  probe0  
	);
    
    
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
