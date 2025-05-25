//Generated automatically via 'Gen_VerilogRunTilDone_LFSR_3-25.ipynb python code'

`timescale 1ns / 1ps

module main(
    input SYS_CLK_100M_P,
    input SYS_CLK_100M_N,
    output W_LED_0,
    output W_LED_1,
    output W_LED_2,
    output W_LED_3
    );

wire sample_clk;
wire color0_clk;
wire color1_clk;
wire color2_clk;
wire color3_clk;
wire color4_clk;
reg [37:0] counter;
initial counter = 38'b0;
reg [5:0] solution;
reg [5:0] solution_check;
wire [5:0] solution_set;
initial solution_check = 6'b001010;
reg solution_flag;
initial solution_flag = 1'b0;
reg failure;
initial failure = 1'b0;
reg [0:53] InitCond;
reg run;
wire [45:0] LFSRcolor0;
wire [45:0] LFSRcolor1;
wire [45:0] LFSRcolor2;
wire [45:0] LFSRcolor3;
wire [45:0] LFSRcolor4;
reg [36:0] BiasedRNG;       //For I=+/-1 cases
reg [16:0] UnbiasedRNG;   //For I=0 cases
reg [0:62] m;
//To keep from synthesizing away:
assign W_LED_0=m[0];
assign W_LED_1=m[1];
assign W_LED_2=failure;
assign W_LED_3=solution_flag;

//Initialize the system for Reverse operation:
initial m[24] = 1'b0;
initial m[36] = 1'b1;
initial m[46] = 1'b0;
initial m[56] = 1'b1;
initial m[61] = 1'b0;
initial m[62] = 1'b0;

//Initialize the PBits clamped to zero:
initial m[35] = 1'b0;
initial m[45] = 1'b0;
initial m[48] = 1'b0;

//Generate the pseudo-entropy source:
lfsr #(.seed(46'b0010110111100101000000011010101100110100010101)) LFSR0_0(.LFSRregister(LFSRcolor0[45:0]),.clk(sample_clk));
lfsr #(.seed(46'b0011110000101011000110100000101011100100010011)) LFSR1_0(.LFSRregister(LFSRcolor1[45:0]),.clk(color0_clk));
lfsr #(.seed(46'b1100001101001100000011110100110010101011010011)) LFSR2_0(.LFSRregister(LFSRcolor2[45:0]),.clk(color1_clk));
lfsr #(.seed(46'b0100111000010101111101001000000000111010100010)) LFSR3_0(.LFSRregister(LFSRcolor3[45:0]),.clk(color2_clk));
lfsr #(.seed(46'b1000101000100100110001110001110111001101010101)) LFSR4_0(.LFSRregister(LFSRcolor4[45:0]),.clk(color3_clk));
//To control whether the system runs or resets using VIO and counter:
always @(posedge sample_clk) begin
    if (reset) begin
        run = 1'b0;
        counter = 38'b0;
        solution = 6'b0;
        failure = 1'b0;
        solution_check = solution_set;
        m[24] = solution_set[0];
        m[36] = solution_set[1];
        m[46] = solution_set[2];
        m[56] = solution_set[3];
        m[61] = solution_set[4];
        m[62] = solution_set[5];
    end else if (solution_flag) begin
        run = 1'b0;
        counter = 38'b0;
        solution = 6'b0;
        failure = 1'b0;
    end else if (counter < 38'b11111111111111111111111111111111111111) begin
        if (counter == 1) begin
            InitCond[0] = UnbiasedRNG[0];
            InitCond[1] = UnbiasedRNG[1];
            InitCond[2] = UnbiasedRNG[2];
            InitCond[3] = UnbiasedRNG[3];
            InitCond[4] = UnbiasedRNG[4];
            InitCond[5] = UnbiasedRNG[5];
            InitCond[6] = UnbiasedRNG[6];
            InitCond[7] = UnbiasedRNG[7];
            InitCond[8] = UnbiasedRNG[8];
            InitCond[9] = UnbiasedRNG[9];
            InitCond[10] = UnbiasedRNG[10];
            InitCond[11] = UnbiasedRNG[11];
            InitCond[12] = UnbiasedRNG[12];
            InitCond[13] = UnbiasedRNG[13];
            InitCond[14] = UnbiasedRNG[14];
            InitCond[15] = UnbiasedRNG[15];
            InitCond[16] = UnbiasedRNG[16];
        end
        else if (counter == 2) begin
            InitCond[17] = UnbiasedRNG[0];
            InitCond[18] = UnbiasedRNG[1];
            InitCond[19] = UnbiasedRNG[2];
            InitCond[20] = UnbiasedRNG[3];
            InitCond[21] = UnbiasedRNG[4];
            InitCond[22] = UnbiasedRNG[5];
            InitCond[23] = UnbiasedRNG[6];
            InitCond[24] = UnbiasedRNG[7];
            InitCond[25] = UnbiasedRNG[8];
            InitCond[26] = UnbiasedRNG[9];
            InitCond[27] = UnbiasedRNG[10];
            InitCond[28] = UnbiasedRNG[11];
            InitCond[29] = UnbiasedRNG[12];
            InitCond[30] = UnbiasedRNG[13];
            InitCond[31] = UnbiasedRNG[14];
            InitCond[32] = UnbiasedRNG[15];
            InitCond[33] = UnbiasedRNG[16];
        end
        else if (counter == 3) begin
            InitCond[34] = UnbiasedRNG[0];
            InitCond[35] = UnbiasedRNG[1];
            InitCond[36] = UnbiasedRNG[2];
            InitCond[37] = UnbiasedRNG[3];
            InitCond[38] = UnbiasedRNG[4];
            InitCond[39] = UnbiasedRNG[5];
            InitCond[40] = UnbiasedRNG[6];
            InitCond[41] = UnbiasedRNG[7];
            InitCond[42] = UnbiasedRNG[8];
            InitCond[43] = UnbiasedRNG[9];
            InitCond[44] = UnbiasedRNG[10];
            InitCond[45] = UnbiasedRNG[11];
            InitCond[46] = UnbiasedRNG[12];
            InitCond[47] = UnbiasedRNG[13];
            InitCond[48] = UnbiasedRNG[14];
            InitCond[49] = UnbiasedRNG[15];
            InitCond[50] = UnbiasedRNG[16];
        end
        else if (counter == 4) begin
            InitCond[51] = UnbiasedRNG[0];
            InitCond[52] = UnbiasedRNG[1];
            InitCond[53] = UnbiasedRNG[2];
        end
        else if (counter==6)
            run = 1'b1;
        counter = counter+38'b1;
        solution = {m[2],m[1],m[0]}*{m[5],m[4],m[3]};
    end else begin 
        counter = 38'b0;
        failure = 1'b1;
        run = 1'b0;
    end
end

//To measure on only the last step using ILA:
always @(negedge sample_clk) begin
    if (solution_flag)
        solution_flag = 1'b0;
    else if ((run & (solution == solution_check)) | failure)
        solution_flag = 1'b1;
end

//Update the outputs by color:
always @(posedge color0_clk) begin
    m[0] = run?((((m[6]&~m[7]&~m[8])|(~m[6]&m[7]&~m[8])|(~m[6]&~m[7]&m[8]))&BiasedRNG[0])|(((m[6]&m[7]&~m[8])|(m[6]&~m[7]&m[8])|(~m[6]&m[7]&m[8]))&~BiasedRNG[0])|((m[6]&m[7]&m[8]))):InitCond[0];
    m[1] = run?((((m[9]&~m[10]&~m[11])|(~m[9]&m[10]&~m[11])|(~m[9]&~m[10]&m[11]))&BiasedRNG[1])|(((m[9]&m[10]&~m[11])|(m[9]&~m[10]&m[11])|(~m[9]&m[10]&m[11]))&~BiasedRNG[1])|((m[9]&m[10]&m[11]))):InitCond[1];
    m[2] = run?((((m[12]&~m[13]&~m[14])|(~m[12]&m[13]&~m[14])|(~m[12]&~m[13]&m[14]))&BiasedRNG[2])|(((m[12]&m[13]&~m[14])|(m[12]&~m[13]&m[14])|(~m[12]&m[13]&m[14]))&~BiasedRNG[2])|((m[12]&m[13]&m[14]))):InitCond[2];
    m[3] = run?((((m[15]&~m[16]&~m[17])|(~m[15]&m[16]&~m[17])|(~m[15]&~m[16]&m[17]))&BiasedRNG[3])|(((m[15]&m[16]&~m[17])|(m[15]&~m[16]&m[17])|(~m[15]&m[16]&m[17]))&~BiasedRNG[3])|((m[15]&m[16]&m[17]))):InitCond[3];
    m[4] = run?((((m[18]&~m[19]&~m[20])|(~m[18]&m[19]&~m[20])|(~m[18]&~m[19]&m[20]))&BiasedRNG[4])|(((m[18]&m[19]&~m[20])|(m[18]&~m[19]&m[20])|(~m[18]&m[19]&m[20]))&~BiasedRNG[4])|((m[18]&m[19]&m[20]))):InitCond[4];
    m[5] = run?((((m[21]&~m[22]&~m[23])|(~m[21]&m[22]&~m[23])|(~m[21]&~m[22]&m[23]))&BiasedRNG[5])|(((m[21]&m[22]&~m[23])|(m[21]&~m[22]&m[23])|(~m[21]&m[22]&m[23]))&~BiasedRNG[5])|((m[21]&m[22]&m[23]))):InitCond[5];
    m[25] = run?((((m[9]&~m[16]&m[33])|(~m[9]&m[16]&m[33]))&BiasedRNG[6])|(((m[9]&m[16]&~m[33]))&~BiasedRNG[6])|((m[9]&m[16]&m[33]))):InitCond[6];
    m[26] = run?((((m[12]&~m[17]&m[38])|(~m[12]&m[17]&m[38]))&BiasedRNG[7])|(((m[12]&m[17]&~m[38]))&~BiasedRNG[7])|((m[12]&m[17]&m[38]))):InitCond[7];
    m[27] = run?((((m[7]&~m[18]&m[34])|(~m[7]&m[18]&m[34]))&BiasedRNG[8])|(((m[7]&m[18]&~m[34]))&~BiasedRNG[8])|((m[7]&m[18]&m[34]))):InitCond[8];
    m[28] = run?((((m[10]&~m[19]&m[39])|(~m[10]&m[19]&m[39]))&BiasedRNG[9])|(((m[10]&m[19]&~m[39]))&~BiasedRNG[9])|((m[10]&m[19]&m[39]))):InitCond[9];
    m[29] = run?((((m[13]&~m[20]&m[49])|(~m[13]&m[20]&m[49]))&BiasedRNG[10])|(((m[13]&m[20]&~m[49]))&~BiasedRNG[10])|((m[13]&m[20]&m[49]))):InitCond[10];
    m[30] = run?((((m[8]&~m[21]&m[44])|(~m[8]&m[21]&m[44]))&BiasedRNG[11])|(((m[8]&m[21]&~m[44]))&~BiasedRNG[11])|((m[8]&m[21]&m[44]))):InitCond[11];
    m[31] = run?((((m[11]&~m[22]&m[54])|(~m[11]&m[22]&m[54]))&BiasedRNG[12])|(((m[11]&m[22]&~m[54]))&~BiasedRNG[12])|((m[11]&m[22]&m[54]))):InitCond[12];
    m[32] = run?((((m[14]&~m[23]&m[59])|(~m[14]&m[23]&m[59]))&BiasedRNG[13])|(((m[14]&m[23]&~m[59]))&~BiasedRNG[13])|((m[14]&m[23]&m[59]))):InitCond[13];
    m[40] = run?((((m[37]&~m[38]&~m[39]&~m[41]&~m[42])|(~m[37]&~m[38]&~m[39]&m[41]&~m[42])|(m[37]&m[38]&~m[39]&m[41]&~m[42])|(m[37]&~m[38]&m[39]&m[41]&~m[42])|(~m[37]&m[38]&~m[39]&~m[41]&m[42])|(~m[37]&~m[38]&m[39]&~m[41]&m[42])|(m[37]&m[38]&m[39]&~m[41]&m[42])|(~m[37]&m[38]&m[39]&m[41]&m[42]))&UnbiasedRNG[0])|((m[37]&~m[38]&~m[39]&m[41]&~m[42])|(~m[37]&~m[38]&~m[39]&~m[41]&m[42])|(m[37]&~m[38]&~m[39]&~m[41]&m[42])|(m[37]&m[38]&~m[39]&~m[41]&m[42])|(m[37]&~m[38]&m[39]&~m[41]&m[42])|(~m[37]&~m[38]&~m[39]&m[41]&m[42])|(m[37]&~m[38]&~m[39]&m[41]&m[42])|(~m[37]&m[38]&~m[39]&m[41]&m[42])|(m[37]&m[38]&~m[39]&m[41]&m[42])|(~m[37]&~m[38]&m[39]&m[41]&m[42])|(m[37]&~m[38]&m[39]&m[41]&m[42])|(m[37]&m[38]&m[39]&m[41]&m[42]))):InitCond[14];
    m[43] = run?((((m[41]&~m[44]&~m[45]&~m[46]&~m[47])|(~m[41]&~m[44]&~m[45]&m[46]&~m[47])|(m[41]&m[44]&~m[45]&m[46]&~m[47])|(m[41]&~m[44]&m[45]&m[46]&~m[47])|(~m[41]&m[44]&~m[45]&~m[46]&m[47])|(~m[41]&~m[44]&m[45]&~m[46]&m[47])|(m[41]&m[44]&m[45]&~m[46]&m[47])|(~m[41]&m[44]&m[45]&m[46]&m[47]))&UnbiasedRNG[1])|((m[41]&~m[44]&~m[45]&m[46]&~m[47])|(~m[41]&~m[44]&~m[45]&~m[46]&m[47])|(m[41]&~m[44]&~m[45]&~m[46]&m[47])|(m[41]&m[44]&~m[45]&~m[46]&m[47])|(m[41]&~m[44]&m[45]&~m[46]&m[47])|(~m[41]&~m[44]&~m[45]&m[46]&m[47])|(m[41]&~m[44]&~m[45]&m[46]&m[47])|(~m[41]&m[44]&~m[45]&m[46]&m[47])|(m[41]&m[44]&~m[45]&m[46]&m[47])|(~m[41]&~m[44]&m[45]&m[46]&m[47])|(m[41]&~m[44]&m[45]&m[46]&m[47])|(m[41]&m[44]&m[45]&m[46]&m[47]))):InitCond[15];
    m[53] = run?((((m[51]&~m[54]&~m[55]&~m[56]&~m[57])|(~m[51]&~m[54]&~m[55]&m[56]&~m[57])|(m[51]&m[54]&~m[55]&m[56]&~m[57])|(m[51]&~m[54]&m[55]&m[56]&~m[57])|(~m[51]&m[54]&~m[55]&~m[56]&m[57])|(~m[51]&~m[54]&m[55]&~m[56]&m[57])|(m[51]&m[54]&m[55]&~m[56]&m[57])|(~m[51]&m[54]&m[55]&m[56]&m[57]))&UnbiasedRNG[2])|((m[51]&~m[54]&~m[55]&m[56]&~m[57])|(~m[51]&~m[54]&~m[55]&~m[56]&m[57])|(m[51]&~m[54]&~m[55]&~m[56]&m[57])|(m[51]&m[54]&~m[55]&~m[56]&m[57])|(m[51]&~m[54]&m[55]&~m[56]&m[57])|(~m[51]&~m[54]&~m[55]&m[56]&m[57])|(m[51]&~m[54]&~m[55]&m[56]&m[57])|(~m[51]&m[54]&~m[55]&m[56]&m[57])|(m[51]&m[54]&~m[55]&m[56]&m[57])|(~m[51]&~m[54]&m[55]&m[56]&m[57])|(m[51]&~m[54]&m[55]&m[56]&m[57])|(m[51]&m[54]&m[55]&m[56]&m[57]))):InitCond[16];
    m[58] = run?((((m[52]&~m[59]&~m[60]&~m[61]&~m[62])|(~m[52]&~m[59]&~m[60]&m[61]&~m[62])|(m[52]&m[59]&~m[60]&m[61]&~m[62])|(m[52]&~m[59]&m[60]&m[61]&~m[62])|(~m[52]&m[59]&~m[60]&~m[61]&m[62])|(~m[52]&~m[59]&m[60]&~m[61]&m[62])|(m[52]&m[59]&m[60]&~m[61]&m[62])|(~m[52]&m[59]&m[60]&m[61]&m[62]))&UnbiasedRNG[3])|((m[52]&~m[59]&~m[60]&m[61]&~m[62])|(~m[52]&~m[59]&~m[60]&~m[61]&m[62])|(m[52]&~m[59]&~m[60]&~m[61]&m[62])|(m[52]&m[59]&~m[60]&~m[61]&m[62])|(m[52]&~m[59]&m[60]&~m[61]&m[62])|(~m[52]&~m[59]&~m[60]&m[61]&m[62])|(m[52]&~m[59]&~m[60]&m[61]&m[62])|(~m[52]&m[59]&~m[60]&m[61]&m[62])|(m[52]&m[59]&~m[60]&m[61]&m[62])|(~m[52]&~m[59]&m[60]&m[61]&m[62])|(m[52]&~m[59]&m[60]&m[61]&m[62])|(m[52]&m[59]&m[60]&m[61]&m[62]))):InitCond[17];
end

always @(posedge color1_clk) begin
    m[6] = run?((((~m[0]&~m[15]&~m[24])|(m[0]&m[15]&~m[24]))&BiasedRNG[14])|(((m[0]&~m[15]&~m[24])|(~m[0]&m[15]&m[24]))&~BiasedRNG[14])|((~m[0]&~m[15]&m[24])|(m[0]&~m[15]&m[24])|(m[0]&m[15]&m[24]))):InitCond[18];
    m[7] = run?((((~m[0]&~m[18]&~m[27])|(m[0]&m[18]&~m[27]))&BiasedRNG[15])|(((m[0]&~m[18]&~m[27])|(~m[0]&m[18]&m[27]))&~BiasedRNG[15])|((~m[0]&~m[18]&m[27])|(m[0]&~m[18]&m[27])|(m[0]&m[18]&m[27]))):InitCond[19];
    m[8] = run?((((~m[0]&~m[21]&~m[30])|(m[0]&m[21]&~m[30]))&BiasedRNG[16])|(((m[0]&~m[21]&~m[30])|(~m[0]&m[21]&m[30]))&~BiasedRNG[16])|((~m[0]&~m[21]&m[30])|(m[0]&~m[21]&m[30])|(m[0]&m[21]&m[30]))):InitCond[20];
    m[9] = run?((((~m[1]&~m[16]&~m[25])|(m[1]&m[16]&~m[25]))&BiasedRNG[17])|(((m[1]&~m[16]&~m[25])|(~m[1]&m[16]&m[25]))&~BiasedRNG[17])|((~m[1]&~m[16]&m[25])|(m[1]&~m[16]&m[25])|(m[1]&m[16]&m[25]))):InitCond[21];
    m[10] = run?((((~m[1]&~m[19]&~m[28])|(m[1]&m[19]&~m[28]))&BiasedRNG[18])|(((m[1]&~m[19]&~m[28])|(~m[1]&m[19]&m[28]))&~BiasedRNG[18])|((~m[1]&~m[19]&m[28])|(m[1]&~m[19]&m[28])|(m[1]&m[19]&m[28]))):InitCond[22];
    m[11] = run?((((~m[1]&~m[22]&~m[31])|(m[1]&m[22]&~m[31]))&BiasedRNG[19])|(((m[1]&~m[22]&~m[31])|(~m[1]&m[22]&m[31]))&~BiasedRNG[19])|((~m[1]&~m[22]&m[31])|(m[1]&~m[22]&m[31])|(m[1]&m[22]&m[31]))):InitCond[23];
    m[12] = run?((((~m[2]&~m[17]&~m[26])|(m[2]&m[17]&~m[26]))&BiasedRNG[20])|(((m[2]&~m[17]&~m[26])|(~m[2]&m[17]&m[26]))&~BiasedRNG[20])|((~m[2]&~m[17]&m[26])|(m[2]&~m[17]&m[26])|(m[2]&m[17]&m[26]))):InitCond[24];
    m[13] = run?((((~m[2]&~m[20]&~m[29])|(m[2]&m[20]&~m[29]))&BiasedRNG[21])|(((m[2]&~m[20]&~m[29])|(~m[2]&m[20]&m[29]))&~BiasedRNG[21])|((~m[2]&~m[20]&m[29])|(m[2]&~m[20]&m[29])|(m[2]&m[20]&m[29]))):InitCond[25];
    m[14] = run?((((~m[2]&~m[23]&~m[32])|(m[2]&m[23]&~m[32]))&BiasedRNG[22])|(((m[2]&~m[23]&~m[32])|(~m[2]&m[23]&m[32]))&~BiasedRNG[22])|((~m[2]&~m[23]&m[32])|(m[2]&~m[23]&m[32])|(m[2]&m[23]&m[32]))):InitCond[26];
    m[33] = run?((((m[25]&~m[34]&~m[35]&~m[36]&~m[37])|(~m[25]&~m[34]&~m[35]&m[36]&~m[37])|(m[25]&m[34]&~m[35]&m[36]&~m[37])|(m[25]&~m[34]&m[35]&m[36]&~m[37])|(~m[25]&m[34]&~m[35]&~m[36]&m[37])|(~m[25]&~m[34]&m[35]&~m[36]&m[37])|(m[25]&m[34]&m[35]&~m[36]&m[37])|(~m[25]&m[34]&m[35]&m[36]&m[37]))&UnbiasedRNG[4])|((m[25]&~m[34]&~m[35]&m[36]&~m[37])|(~m[25]&~m[34]&~m[35]&~m[36]&m[37])|(m[25]&~m[34]&~m[35]&~m[36]&m[37])|(m[25]&m[34]&~m[35]&~m[36]&m[37])|(m[25]&~m[34]&m[35]&~m[36]&m[37])|(~m[25]&~m[34]&~m[35]&m[36]&m[37])|(m[25]&~m[34]&~m[35]&m[36]&m[37])|(~m[25]&m[34]&~m[35]&m[36]&m[37])|(m[25]&m[34]&~m[35]&m[36]&m[37])|(~m[25]&~m[34]&m[35]&m[36]&m[37])|(m[25]&~m[34]&m[35]&m[36]&m[37])|(m[25]&m[34]&m[35]&m[36]&m[37]))):InitCond[27];
    m[38] = run?((((m[26]&~m[39]&~m[40]&~m[41]&~m[42])|(~m[26]&~m[39]&~m[40]&m[41]&~m[42])|(m[26]&m[39]&~m[40]&m[41]&~m[42])|(m[26]&~m[39]&m[40]&m[41]&~m[42])|(~m[26]&m[39]&~m[40]&~m[41]&m[42])|(~m[26]&~m[39]&m[40]&~m[41]&m[42])|(m[26]&m[39]&m[40]&~m[41]&m[42])|(~m[26]&m[39]&m[40]&m[41]&m[42]))&UnbiasedRNG[5])|((m[26]&~m[39]&~m[40]&m[41]&~m[42])|(~m[26]&~m[39]&~m[40]&~m[41]&m[42])|(m[26]&~m[39]&~m[40]&~m[41]&m[42])|(m[26]&m[39]&~m[40]&~m[41]&m[42])|(m[26]&~m[39]&m[40]&~m[41]&m[42])|(~m[26]&~m[39]&~m[40]&m[41]&m[42])|(m[26]&~m[39]&~m[40]&m[41]&m[42])|(~m[26]&m[39]&~m[40]&m[41]&m[42])|(m[26]&m[39]&~m[40]&m[41]&m[42])|(~m[26]&~m[39]&m[40]&m[41]&m[42])|(m[26]&~m[39]&m[40]&m[41]&m[42])|(m[26]&m[39]&m[40]&m[41]&m[42]))):InitCond[28];
    m[44] = run?((((m[30]&~m[43]&~m[45]&~m[46]&~m[47])|(~m[30]&~m[43]&~m[45]&m[46]&~m[47])|(m[30]&m[43]&~m[45]&m[46]&~m[47])|(m[30]&~m[43]&m[45]&m[46]&~m[47])|(~m[30]&m[43]&~m[45]&~m[46]&m[47])|(~m[30]&~m[43]&m[45]&~m[46]&m[47])|(m[30]&m[43]&m[45]&~m[46]&m[47])|(~m[30]&m[43]&m[45]&m[46]&m[47]))&UnbiasedRNG[6])|((m[30]&~m[43]&~m[45]&m[46]&~m[47])|(~m[30]&~m[43]&~m[45]&~m[46]&m[47])|(m[30]&~m[43]&~m[45]&~m[46]&m[47])|(m[30]&m[43]&~m[45]&~m[46]&m[47])|(m[30]&~m[43]&m[45]&~m[46]&m[47])|(~m[30]&~m[43]&~m[45]&m[46]&m[47])|(m[30]&~m[43]&~m[45]&m[46]&m[47])|(~m[30]&m[43]&~m[45]&m[46]&m[47])|(m[30]&m[43]&~m[45]&m[46]&m[47])|(~m[30]&~m[43]&m[45]&m[46]&m[47])|(m[30]&~m[43]&m[45]&m[46]&m[47])|(m[30]&m[43]&m[45]&m[46]&m[47]))):InitCond[29];
    m[49] = run?((((m[29]&~m[48]&~m[50]&~m[51]&~m[52])|(~m[29]&~m[48]&~m[50]&m[51]&~m[52])|(m[29]&m[48]&~m[50]&m[51]&~m[52])|(m[29]&~m[48]&m[50]&m[51]&~m[52])|(~m[29]&m[48]&~m[50]&~m[51]&m[52])|(~m[29]&~m[48]&m[50]&~m[51]&m[52])|(m[29]&m[48]&m[50]&~m[51]&m[52])|(~m[29]&m[48]&m[50]&m[51]&m[52]))&UnbiasedRNG[7])|((m[29]&~m[48]&~m[50]&m[51]&~m[52])|(~m[29]&~m[48]&~m[50]&~m[51]&m[52])|(m[29]&~m[48]&~m[50]&~m[51]&m[52])|(m[29]&m[48]&~m[50]&~m[51]&m[52])|(m[29]&~m[48]&m[50]&~m[51]&m[52])|(~m[29]&~m[48]&~m[50]&m[51]&m[52])|(m[29]&~m[48]&~m[50]&m[51]&m[52])|(~m[29]&m[48]&~m[50]&m[51]&m[52])|(m[29]&m[48]&~m[50]&m[51]&m[52])|(~m[29]&~m[48]&m[50]&m[51]&m[52])|(m[29]&~m[48]&m[50]&m[51]&m[52])|(m[29]&m[48]&m[50]&m[51]&m[52]))):InitCond[30];
    m[54] = run?((((m[31]&~m[53]&~m[55]&~m[56]&~m[57])|(~m[31]&~m[53]&~m[55]&m[56]&~m[57])|(m[31]&m[53]&~m[55]&m[56]&~m[57])|(m[31]&~m[53]&m[55]&m[56]&~m[57])|(~m[31]&m[53]&~m[55]&~m[56]&m[57])|(~m[31]&~m[53]&m[55]&~m[56]&m[57])|(m[31]&m[53]&m[55]&~m[56]&m[57])|(~m[31]&m[53]&m[55]&m[56]&m[57]))&UnbiasedRNG[8])|((m[31]&~m[53]&~m[55]&m[56]&~m[57])|(~m[31]&~m[53]&~m[55]&~m[56]&m[57])|(m[31]&~m[53]&~m[55]&~m[56]&m[57])|(m[31]&m[53]&~m[55]&~m[56]&m[57])|(m[31]&~m[53]&m[55]&~m[56]&m[57])|(~m[31]&~m[53]&~m[55]&m[56]&m[57])|(m[31]&~m[53]&~m[55]&m[56]&m[57])|(~m[31]&m[53]&~m[55]&m[56]&m[57])|(m[31]&m[53]&~m[55]&m[56]&m[57])|(~m[31]&~m[53]&m[55]&m[56]&m[57])|(m[31]&~m[53]&m[55]&m[56]&m[57])|(m[31]&m[53]&m[55]&m[56]&m[57]))):InitCond[31];
    m[59] = run?((((m[32]&~m[58]&~m[60]&~m[61]&~m[62])|(~m[32]&~m[58]&~m[60]&m[61]&~m[62])|(m[32]&m[58]&~m[60]&m[61]&~m[62])|(m[32]&~m[58]&m[60]&m[61]&~m[62])|(~m[32]&m[58]&~m[60]&~m[61]&m[62])|(~m[32]&~m[58]&m[60]&~m[61]&m[62])|(m[32]&m[58]&m[60]&~m[61]&m[62])|(~m[32]&m[58]&m[60]&m[61]&m[62]))&UnbiasedRNG[9])|((m[32]&~m[58]&~m[60]&m[61]&~m[62])|(~m[32]&~m[58]&~m[60]&~m[61]&m[62])|(m[32]&~m[58]&~m[60]&~m[61]&m[62])|(m[32]&m[58]&~m[60]&~m[61]&m[62])|(m[32]&~m[58]&m[60]&~m[61]&m[62])|(~m[32]&~m[58]&~m[60]&m[61]&m[62])|(m[32]&~m[58]&~m[60]&m[61]&m[62])|(~m[32]&m[58]&~m[60]&m[61]&m[62])|(m[32]&m[58]&~m[60]&m[61]&m[62])|(~m[32]&~m[58]&m[60]&m[61]&m[62])|(m[32]&~m[58]&m[60]&m[61]&m[62])|(m[32]&m[58]&m[60]&m[61]&m[62]))):InitCond[32];
end

always @(posedge color2_clk) begin
    m[15] = run?((((~m[3]&~m[6]&~m[24])|(m[3]&m[6]&~m[24]))&BiasedRNG[23])|(((m[3]&~m[6]&~m[24])|(~m[3]&m[6]&m[24]))&~BiasedRNG[23])|((~m[3]&~m[6]&m[24])|(m[3]&~m[6]&m[24])|(m[3]&m[6]&m[24]))):InitCond[33];
    m[16] = run?((((~m[3]&~m[9]&~m[25])|(m[3]&m[9]&~m[25]))&BiasedRNG[24])|(((m[3]&~m[9]&~m[25])|(~m[3]&m[9]&m[25]))&~BiasedRNG[24])|((~m[3]&~m[9]&m[25])|(m[3]&~m[9]&m[25])|(m[3]&m[9]&m[25]))):InitCond[34];
    m[17] = run?((((~m[3]&~m[12]&~m[26])|(m[3]&m[12]&~m[26]))&BiasedRNG[25])|(((m[3]&~m[12]&~m[26])|(~m[3]&m[12]&m[26]))&~BiasedRNG[25])|((~m[3]&~m[12]&m[26])|(m[3]&~m[12]&m[26])|(m[3]&m[12]&m[26]))):InitCond[35];
    m[18] = run?((((~m[4]&~m[7]&~m[27])|(m[4]&m[7]&~m[27]))&BiasedRNG[26])|(((m[4]&~m[7]&~m[27])|(~m[4]&m[7]&m[27]))&~BiasedRNG[26])|((~m[4]&~m[7]&m[27])|(m[4]&~m[7]&m[27])|(m[4]&m[7]&m[27]))):InitCond[36];
    m[19] = run?((((~m[4]&~m[10]&~m[28])|(m[4]&m[10]&~m[28]))&BiasedRNG[27])|(((m[4]&~m[10]&~m[28])|(~m[4]&m[10]&m[28]))&~BiasedRNG[27])|((~m[4]&~m[10]&m[28])|(m[4]&~m[10]&m[28])|(m[4]&m[10]&m[28]))):InitCond[37];
    m[20] = run?((((~m[4]&~m[13]&~m[29])|(m[4]&m[13]&~m[29]))&BiasedRNG[28])|(((m[4]&~m[13]&~m[29])|(~m[4]&m[13]&m[29]))&~BiasedRNG[28])|((~m[4]&~m[13]&m[29])|(m[4]&~m[13]&m[29])|(m[4]&m[13]&m[29]))):InitCond[38];
    m[21] = run?((((~m[5]&~m[8]&~m[30])|(m[5]&m[8]&~m[30]))&BiasedRNG[29])|(((m[5]&~m[8]&~m[30])|(~m[5]&m[8]&m[30]))&~BiasedRNG[29])|((~m[5]&~m[8]&m[30])|(m[5]&~m[8]&m[30])|(m[5]&m[8]&m[30]))):InitCond[39];
    m[22] = run?((((~m[5]&~m[11]&~m[31])|(m[5]&m[11]&~m[31]))&BiasedRNG[30])|(((m[5]&~m[11]&~m[31])|(~m[5]&m[11]&m[31]))&~BiasedRNG[30])|((~m[5]&~m[11]&m[31])|(m[5]&~m[11]&m[31])|(m[5]&m[11]&m[31]))):InitCond[40];
    m[23] = run?((((~m[5]&~m[14]&~m[32])|(m[5]&m[14]&~m[32]))&BiasedRNG[31])|(((m[5]&~m[14]&~m[32])|(~m[5]&m[14]&m[32]))&~BiasedRNG[31])|((~m[5]&~m[14]&m[32])|(m[5]&~m[14]&m[32])|(m[5]&m[14]&m[32]))):InitCond[41];
    m[34] = run?((((m[27]&~m[33]&~m[35]&~m[36]&~m[37])|(~m[27]&~m[33]&~m[35]&m[36]&~m[37])|(m[27]&m[33]&~m[35]&m[36]&~m[37])|(m[27]&~m[33]&m[35]&m[36]&~m[37])|(~m[27]&m[33]&~m[35]&~m[36]&m[37])|(~m[27]&~m[33]&m[35]&~m[36]&m[37])|(m[27]&m[33]&m[35]&~m[36]&m[37])|(~m[27]&m[33]&m[35]&m[36]&m[37]))&UnbiasedRNG[10])|((m[27]&~m[33]&~m[35]&m[36]&~m[37])|(~m[27]&~m[33]&~m[35]&~m[36]&m[37])|(m[27]&~m[33]&~m[35]&~m[36]&m[37])|(m[27]&m[33]&~m[35]&~m[36]&m[37])|(m[27]&~m[33]&m[35]&~m[36]&m[37])|(~m[27]&~m[33]&~m[35]&m[36]&m[37])|(m[27]&~m[33]&~m[35]&m[36]&m[37])|(~m[27]&m[33]&~m[35]&m[36]&m[37])|(m[27]&m[33]&~m[35]&m[36]&m[37])|(~m[27]&~m[33]&m[35]&m[36]&m[37])|(m[27]&~m[33]&m[35]&m[36]&m[37])|(m[27]&m[33]&m[35]&m[36]&m[37]))):InitCond[42];
    m[39] = run?((((m[28]&~m[38]&~m[40]&~m[41]&~m[42])|(~m[28]&~m[38]&~m[40]&m[41]&~m[42])|(m[28]&m[38]&~m[40]&m[41]&~m[42])|(m[28]&~m[38]&m[40]&m[41]&~m[42])|(~m[28]&m[38]&~m[40]&~m[41]&m[42])|(~m[28]&~m[38]&m[40]&~m[41]&m[42])|(m[28]&m[38]&m[40]&~m[41]&m[42])|(~m[28]&m[38]&m[40]&m[41]&m[42]))&UnbiasedRNG[11])|((m[28]&~m[38]&~m[40]&m[41]&~m[42])|(~m[28]&~m[38]&~m[40]&~m[41]&m[42])|(m[28]&~m[38]&~m[40]&~m[41]&m[42])|(m[28]&m[38]&~m[40]&~m[41]&m[42])|(m[28]&~m[38]&m[40]&~m[41]&m[42])|(~m[28]&~m[38]&~m[40]&m[41]&m[42])|(m[28]&~m[38]&~m[40]&m[41]&m[42])|(~m[28]&m[38]&~m[40]&m[41]&m[42])|(m[28]&m[38]&~m[40]&m[41]&m[42])|(~m[28]&~m[38]&m[40]&m[41]&m[42])|(m[28]&~m[38]&m[40]&m[41]&m[42])|(m[28]&m[38]&m[40]&m[41]&m[42]))):InitCond[43];
    m[50] = run?((((m[42]&~m[48]&~m[49]&~m[51]&~m[52])|(~m[42]&~m[48]&~m[49]&m[51]&~m[52])|(m[42]&m[48]&~m[49]&m[51]&~m[52])|(m[42]&~m[48]&m[49]&m[51]&~m[52])|(~m[42]&m[48]&~m[49]&~m[51]&m[52])|(~m[42]&~m[48]&m[49]&~m[51]&m[52])|(m[42]&m[48]&m[49]&~m[51]&m[52])|(~m[42]&m[48]&m[49]&m[51]&m[52]))&UnbiasedRNG[12])|((m[42]&~m[48]&~m[49]&m[51]&~m[52])|(~m[42]&~m[48]&~m[49]&~m[51]&m[52])|(m[42]&~m[48]&~m[49]&~m[51]&m[52])|(m[42]&m[48]&~m[49]&~m[51]&m[52])|(m[42]&~m[48]&m[49]&~m[51]&m[52])|(~m[42]&~m[48]&~m[49]&m[51]&m[52])|(m[42]&~m[48]&~m[49]&m[51]&m[52])|(~m[42]&m[48]&~m[49]&m[51]&m[52])|(m[42]&m[48]&~m[49]&m[51]&m[52])|(~m[42]&~m[48]&m[49]&m[51]&m[52])|(m[42]&~m[48]&m[49]&m[51]&m[52])|(m[42]&m[48]&m[49]&m[51]&m[52]))):InitCond[44];
    m[55] = run?((((m[47]&~m[53]&~m[54]&~m[56]&~m[57])|(~m[47]&~m[53]&~m[54]&m[56]&~m[57])|(m[47]&m[53]&~m[54]&m[56]&~m[57])|(m[47]&~m[53]&m[54]&m[56]&~m[57])|(~m[47]&m[53]&~m[54]&~m[56]&m[57])|(~m[47]&~m[53]&m[54]&~m[56]&m[57])|(m[47]&m[53]&m[54]&~m[56]&m[57])|(~m[47]&m[53]&m[54]&m[56]&m[57]))&UnbiasedRNG[13])|((m[47]&~m[53]&~m[54]&m[56]&~m[57])|(~m[47]&~m[53]&~m[54]&~m[56]&m[57])|(m[47]&~m[53]&~m[54]&~m[56]&m[57])|(m[47]&m[53]&~m[54]&~m[56]&m[57])|(m[47]&~m[53]&m[54]&~m[56]&m[57])|(~m[47]&~m[53]&~m[54]&m[56]&m[57])|(m[47]&~m[53]&~m[54]&m[56]&m[57])|(~m[47]&m[53]&~m[54]&m[56]&m[57])|(m[47]&m[53]&~m[54]&m[56]&m[57])|(~m[47]&~m[53]&m[54]&m[56]&m[57])|(m[47]&~m[53]&m[54]&m[56]&m[57])|(m[47]&m[53]&m[54]&m[56]&m[57]))):InitCond[45];
    m[60] = run?((((m[57]&~m[58]&~m[59]&~m[61]&~m[62])|(~m[57]&~m[58]&~m[59]&m[61]&~m[62])|(m[57]&m[58]&~m[59]&m[61]&~m[62])|(m[57]&~m[58]&m[59]&m[61]&~m[62])|(~m[57]&m[58]&~m[59]&~m[61]&m[62])|(~m[57]&~m[58]&m[59]&~m[61]&m[62])|(m[57]&m[58]&m[59]&~m[61]&m[62])|(~m[57]&m[58]&m[59]&m[61]&m[62]))&UnbiasedRNG[14])|((m[57]&~m[58]&~m[59]&m[61]&~m[62])|(~m[57]&~m[58]&~m[59]&~m[61]&m[62])|(m[57]&~m[58]&~m[59]&~m[61]&m[62])|(m[57]&m[58]&~m[59]&~m[61]&m[62])|(m[57]&~m[58]&m[59]&~m[61]&m[62])|(~m[57]&~m[58]&~m[59]&m[61]&m[62])|(m[57]&~m[58]&~m[59]&m[61]&m[62])|(~m[57]&m[58]&~m[59]&m[61]&m[62])|(m[57]&m[58]&~m[59]&m[61]&m[62])|(~m[57]&~m[58]&m[59]&m[61]&m[62])|(m[57]&~m[58]&m[59]&m[61]&m[62])|(m[57]&m[58]&m[59]&m[61]&m[62]))):InitCond[46];
end

always @(posedge color3_clk) begin
    m[41] = run?((((m[38]&~m[39]&~m[40]&~m[42]&~m[43])|(~m[38]&m[39]&~m[40]&~m[42]&~m[43])|(~m[38]&~m[39]&m[40]&~m[42]&~m[43])|(m[38]&m[39]&m[40]&m[42]&~m[43])|(~m[38]&~m[39]&~m[40]&~m[42]&m[43])|(m[38]&m[39]&~m[40]&m[42]&m[43])|(m[38]&~m[39]&m[40]&m[42]&m[43])|(~m[38]&m[39]&m[40]&m[42]&m[43]))&UnbiasedRNG[15])|((m[38]&m[39]&~m[40]&~m[42]&~m[43])|(m[38]&~m[39]&m[40]&~m[42]&~m[43])|(~m[38]&m[39]&m[40]&~m[42]&~m[43])|(m[38]&m[39]&m[40]&~m[42]&~m[43])|(m[38]&~m[39]&~m[40]&~m[42]&m[43])|(~m[38]&m[39]&~m[40]&~m[42]&m[43])|(m[38]&m[39]&~m[40]&~m[42]&m[43])|(~m[38]&~m[39]&m[40]&~m[42]&m[43])|(m[38]&~m[39]&m[40]&~m[42]&m[43])|(~m[38]&m[39]&m[40]&~m[42]&m[43])|(m[38]&m[39]&m[40]&~m[42]&m[43])|(m[38]&m[39]&m[40]&m[42]&m[43]))):InitCond[47];
    m[51] = run?((((m[48]&~m[49]&~m[50]&~m[52]&~m[53])|(~m[48]&m[49]&~m[50]&~m[52]&~m[53])|(~m[48]&~m[49]&m[50]&~m[52]&~m[53])|(m[48]&m[49]&m[50]&m[52]&~m[53])|(~m[48]&~m[49]&~m[50]&~m[52]&m[53])|(m[48]&m[49]&~m[50]&m[52]&m[53])|(m[48]&~m[49]&m[50]&m[52]&m[53])|(~m[48]&m[49]&m[50]&m[52]&m[53]))&UnbiasedRNG[16])|((m[48]&m[49]&~m[50]&~m[52]&~m[53])|(m[48]&~m[49]&m[50]&~m[52]&~m[53])|(~m[48]&m[49]&m[50]&~m[52]&~m[53])|(m[48]&m[49]&m[50]&~m[52]&~m[53])|(m[48]&~m[49]&~m[50]&~m[52]&m[53])|(~m[48]&m[49]&~m[50]&~m[52]&m[53])|(m[48]&m[49]&~m[50]&~m[52]&m[53])|(~m[48]&~m[49]&m[50]&~m[52]&m[53])|(m[48]&~m[49]&m[50]&~m[52]&m[53])|(~m[48]&m[49]&m[50]&~m[52]&m[53])|(m[48]&m[49]&m[50]&~m[52]&m[53])|(m[48]&m[49]&m[50]&m[52]&m[53]))):InitCond[48];
end

always @(posedge color4_clk) begin
    m[37] = run?((((m[33]&~m[34]&~m[35]&~m[36]&~m[40])|(~m[33]&m[34]&~m[35]&~m[36]&~m[40])|(~m[33]&~m[34]&m[35]&~m[36]&~m[40])|(m[33]&m[34]&~m[35]&m[36]&~m[40])|(m[33]&~m[34]&m[35]&m[36]&~m[40])|(~m[33]&m[34]&m[35]&m[36]&~m[40]))&BiasedRNG[32])|(((m[33]&~m[34]&~m[35]&~m[36]&m[40])|(~m[33]&m[34]&~m[35]&~m[36]&m[40])|(~m[33]&~m[34]&m[35]&~m[36]&m[40])|(m[33]&m[34]&~m[35]&m[36]&m[40])|(m[33]&~m[34]&m[35]&m[36]&m[40])|(~m[33]&m[34]&m[35]&m[36]&m[40]))&~BiasedRNG[32])|((m[33]&m[34]&~m[35]&~m[36]&~m[40])|(m[33]&~m[34]&m[35]&~m[36]&~m[40])|(~m[33]&m[34]&m[35]&~m[36]&~m[40])|(m[33]&m[34]&m[35]&~m[36]&~m[40])|(m[33]&m[34]&m[35]&m[36]&~m[40])|(m[33]&m[34]&~m[35]&~m[36]&m[40])|(m[33]&~m[34]&m[35]&~m[36]&m[40])|(~m[33]&m[34]&m[35]&~m[36]&m[40])|(m[33]&m[34]&m[35]&~m[36]&m[40])|(m[33]&m[34]&m[35]&m[36]&m[40]))):InitCond[49];
    m[42] = run?((((m[38]&~m[39]&~m[40]&~m[41]&~m[50])|(~m[38]&m[39]&~m[40]&~m[41]&~m[50])|(~m[38]&~m[39]&m[40]&~m[41]&~m[50])|(m[38]&m[39]&~m[40]&m[41]&~m[50])|(m[38]&~m[39]&m[40]&m[41]&~m[50])|(~m[38]&m[39]&m[40]&m[41]&~m[50]))&BiasedRNG[33])|(((m[38]&~m[39]&~m[40]&~m[41]&m[50])|(~m[38]&m[39]&~m[40]&~m[41]&m[50])|(~m[38]&~m[39]&m[40]&~m[41]&m[50])|(m[38]&m[39]&~m[40]&m[41]&m[50])|(m[38]&~m[39]&m[40]&m[41]&m[50])|(~m[38]&m[39]&m[40]&m[41]&m[50]))&~BiasedRNG[33])|((m[38]&m[39]&~m[40]&~m[41]&~m[50])|(m[38]&~m[39]&m[40]&~m[41]&~m[50])|(~m[38]&m[39]&m[40]&~m[41]&~m[50])|(m[38]&m[39]&m[40]&~m[41]&~m[50])|(m[38]&m[39]&m[40]&m[41]&~m[50])|(m[38]&m[39]&~m[40]&~m[41]&m[50])|(m[38]&~m[39]&m[40]&~m[41]&m[50])|(~m[38]&m[39]&m[40]&~m[41]&m[50])|(m[38]&m[39]&m[40]&~m[41]&m[50])|(m[38]&m[39]&m[40]&m[41]&m[50]))):InitCond[50];
    m[47] = run?((((m[43]&~m[44]&~m[45]&~m[46]&~m[55])|(~m[43]&m[44]&~m[45]&~m[46]&~m[55])|(~m[43]&~m[44]&m[45]&~m[46]&~m[55])|(m[43]&m[44]&~m[45]&m[46]&~m[55])|(m[43]&~m[44]&m[45]&m[46]&~m[55])|(~m[43]&m[44]&m[45]&m[46]&~m[55]))&BiasedRNG[34])|(((m[43]&~m[44]&~m[45]&~m[46]&m[55])|(~m[43]&m[44]&~m[45]&~m[46]&m[55])|(~m[43]&~m[44]&m[45]&~m[46]&m[55])|(m[43]&m[44]&~m[45]&m[46]&m[55])|(m[43]&~m[44]&m[45]&m[46]&m[55])|(~m[43]&m[44]&m[45]&m[46]&m[55]))&~BiasedRNG[34])|((m[43]&m[44]&~m[45]&~m[46]&~m[55])|(m[43]&~m[44]&m[45]&~m[46]&~m[55])|(~m[43]&m[44]&m[45]&~m[46]&~m[55])|(m[43]&m[44]&m[45]&~m[46]&~m[55])|(m[43]&m[44]&m[45]&m[46]&~m[55])|(m[43]&m[44]&~m[45]&~m[46]&m[55])|(m[43]&~m[44]&m[45]&~m[46]&m[55])|(~m[43]&m[44]&m[45]&~m[46]&m[55])|(m[43]&m[44]&m[45]&~m[46]&m[55])|(m[43]&m[44]&m[45]&m[46]&m[55]))):InitCond[51];
    m[52] = run?((((m[48]&~m[49]&~m[50]&~m[51]&~m[58])|(~m[48]&m[49]&~m[50]&~m[51]&~m[58])|(~m[48]&~m[49]&m[50]&~m[51]&~m[58])|(m[48]&m[49]&~m[50]&m[51]&~m[58])|(m[48]&~m[49]&m[50]&m[51]&~m[58])|(~m[48]&m[49]&m[50]&m[51]&~m[58]))&BiasedRNG[35])|(((m[48]&~m[49]&~m[50]&~m[51]&m[58])|(~m[48]&m[49]&~m[50]&~m[51]&m[58])|(~m[48]&~m[49]&m[50]&~m[51]&m[58])|(m[48]&m[49]&~m[50]&m[51]&m[58])|(m[48]&~m[49]&m[50]&m[51]&m[58])|(~m[48]&m[49]&m[50]&m[51]&m[58]))&~BiasedRNG[35])|((m[48]&m[49]&~m[50]&~m[51]&~m[58])|(m[48]&~m[49]&m[50]&~m[51]&~m[58])|(~m[48]&m[49]&m[50]&~m[51]&~m[58])|(m[48]&m[49]&m[50]&~m[51]&~m[58])|(m[48]&m[49]&m[50]&m[51]&~m[58])|(m[48]&m[49]&~m[50]&~m[51]&m[58])|(m[48]&~m[49]&m[50]&~m[51]&m[58])|(~m[48]&m[49]&m[50]&~m[51]&m[58])|(m[48]&m[49]&m[50]&~m[51]&m[58])|(m[48]&m[49]&m[50]&m[51]&m[58]))):InitCond[52];
    m[57] = run?((((m[53]&~m[54]&~m[55]&~m[56]&~m[60])|(~m[53]&m[54]&~m[55]&~m[56]&~m[60])|(~m[53]&~m[54]&m[55]&~m[56]&~m[60])|(m[53]&m[54]&~m[55]&m[56]&~m[60])|(m[53]&~m[54]&m[55]&m[56]&~m[60])|(~m[53]&m[54]&m[55]&m[56]&~m[60]))&BiasedRNG[36])|(((m[53]&~m[54]&~m[55]&~m[56]&m[60])|(~m[53]&m[54]&~m[55]&~m[56]&m[60])|(~m[53]&~m[54]&m[55]&~m[56]&m[60])|(m[53]&m[54]&~m[55]&m[56]&m[60])|(m[53]&~m[54]&m[55]&m[56]&m[60])|(~m[53]&m[54]&m[55]&m[56]&m[60]))&~BiasedRNG[36])|((m[53]&m[54]&~m[55]&~m[56]&~m[60])|(m[53]&~m[54]&m[55]&~m[56]&~m[60])|(~m[53]&m[54]&m[55]&~m[56]&~m[60])|(m[53]&m[54]&m[55]&~m[56]&~m[60])|(m[53]&m[54]&m[55]&m[56]&~m[60])|(m[53]&m[54]&~m[55]&~m[56]&m[60])|(m[53]&~m[54]&m[55]&~m[56]&m[60])|(~m[53]&m[54]&m[55]&~m[56]&m[60])|(m[53]&m[54]&m[55]&~m[56]&m[60])|(m[53]&m[54]&m[55]&m[56]&m[60]))):InitCond[53];
end

//Update the registered value of RNGs one shifted clock before its needed:
always @(posedge sample_clk) begin
    BiasedRNG[0] = (LFSRcolor0[9]&LFSRcolor0[13]&LFSRcolor0[38]);
    BiasedRNG[1] = (LFSRcolor0[18]&LFSRcolor0[36]&LFSRcolor0[27]);
    BiasedRNG[2] = (LFSRcolor0[31]&LFSRcolor0[30]&LFSRcolor0[25]);
    BiasedRNG[3] = (LFSRcolor0[28]&LFSRcolor0[45]&LFSRcolor0[23]);
    BiasedRNG[4] = (LFSRcolor0[14]&LFSRcolor0[3]&LFSRcolor0[19]);
    BiasedRNG[5] = (LFSRcolor0[4]&LFSRcolor0[32]&LFSRcolor0[20]);
    BiasedRNG[6] = (LFSRcolor0[39]&LFSRcolor0[40]&LFSRcolor0[0]);
    BiasedRNG[7] = (LFSRcolor0[29]&LFSRcolor0[44]&LFSRcolor0[8]);
    BiasedRNG[8] = (LFSRcolor0[21]&LFSRcolor0[43]&LFSRcolor0[41]);
    BiasedRNG[9] = (LFSRcolor0[37]&LFSRcolor0[17]&LFSRcolor0[35]);
    BiasedRNG[10] = (LFSRcolor0[42]&LFSRcolor0[24]&LFSRcolor0[2]);
    BiasedRNG[11] = (LFSRcolor0[33]&LFSRcolor0[1]&LFSRcolor0[34]);
    BiasedRNG[12] = (LFSRcolor0[22]&LFSRcolor0[16]&LFSRcolor0[5]);
    BiasedRNG[13] = (LFSRcolor0[7]&LFSRcolor0[10]&LFSRcolor0[6]);
    UnbiasedRNG[0] = LFSRcolor0[12];
    UnbiasedRNG[1] = LFSRcolor0[11];
    UnbiasedRNG[2] = LFSRcolor0[15];
    UnbiasedRNG[3] = LFSRcolor0[26];
end

always @(posedge color0_clk) begin
    BiasedRNG[14] = (LFSRcolor1[29]&LFSRcolor1[16]&LFSRcolor1[17]);
    BiasedRNG[15] = (LFSRcolor1[30]&LFSRcolor1[23]&LFSRcolor1[18]);
    BiasedRNG[16] = (LFSRcolor1[14]&LFSRcolor1[37]&LFSRcolor1[20]);
    BiasedRNG[17] = (LFSRcolor1[39]&LFSRcolor1[45]&LFSRcolor1[33]);
    BiasedRNG[18] = (LFSRcolor1[5]&LFSRcolor1[7]&LFSRcolor1[11]);
    BiasedRNG[19] = (LFSRcolor1[22]&LFSRcolor1[41]&LFSRcolor1[32]);
    BiasedRNG[20] = (LFSRcolor1[27]&LFSRcolor1[19]&LFSRcolor1[31]);
    BiasedRNG[21] = (LFSRcolor1[15]&LFSRcolor1[42]&LFSRcolor1[3]);
    BiasedRNG[22] = (LFSRcolor1[12]&LFSRcolor1[36]&LFSRcolor1[9]);
    UnbiasedRNG[4] = LFSRcolor1[35];
    UnbiasedRNG[5] = LFSRcolor1[44];
    UnbiasedRNG[6] = LFSRcolor1[8];
    UnbiasedRNG[7] = LFSRcolor1[4];
    UnbiasedRNG[8] = LFSRcolor1[38];
    UnbiasedRNG[9] = LFSRcolor1[26];
end

always @(posedge color1_clk) begin
    BiasedRNG[23] = (LFSRcolor2[42]&LFSRcolor2[37]&LFSRcolor2[38]);
    BiasedRNG[24] = (LFSRcolor2[19]&LFSRcolor2[27]&LFSRcolor2[25]);
    BiasedRNG[25] = (LFSRcolor2[11]&LFSRcolor2[1]&LFSRcolor2[13]);
    BiasedRNG[26] = (LFSRcolor2[14]&LFSRcolor2[18]&LFSRcolor2[41]);
    BiasedRNG[27] = (LFSRcolor2[32]&LFSRcolor2[10]&LFSRcolor2[15]);
    BiasedRNG[28] = (LFSRcolor2[39]&LFSRcolor2[2]&LFSRcolor2[43]);
    BiasedRNG[29] = (LFSRcolor2[34]&LFSRcolor2[26]&LFSRcolor2[45]);
    BiasedRNG[30] = (LFSRcolor2[22]&LFSRcolor2[5]&LFSRcolor2[30]);
    BiasedRNG[31] = (LFSRcolor2[36]&LFSRcolor2[31]&LFSRcolor2[35]);
    UnbiasedRNG[10] = LFSRcolor2[23];
    UnbiasedRNG[11] = LFSRcolor2[44];
    UnbiasedRNG[12] = LFSRcolor2[0];
    UnbiasedRNG[13] = LFSRcolor2[3];
    UnbiasedRNG[14] = LFSRcolor2[40];
end

always @(posedge color2_clk) begin
    UnbiasedRNG[15] = LFSRcolor3[36];
    UnbiasedRNG[16] = LFSRcolor3[26];
end

always @(posedge color3_clk) begin
    BiasedRNG[32] = (LFSRcolor4[6]&LFSRcolor4[20]&LFSRcolor4[41]);
    BiasedRNG[33] = (LFSRcolor4[8]&LFSRcolor4[21]&LFSRcolor4[18]);
    BiasedRNG[34] = (LFSRcolor4[25]&LFSRcolor4[17]&LFSRcolor4[27]);
    BiasedRNG[35] = (LFSRcolor4[9]&LFSRcolor4[1]&LFSRcolor4[37]);
    BiasedRNG[36] = (LFSRcolor4[22]&LFSRcolor4[33]&LFSRcolor4[5]);
end

//Generate the 40MHz shifted clocks:
clk_wiz_0 myPLL(.clk_out1(sample_clk),.clk_out2(color0_clk),.clk_out3(color1_clk),.clk_out4(color2_clk),.clk_out5(color3_clk),.clk_out6(color4_clk),.clk_in1_p(SYS_CLK_100M_P),.clk_in1_n(SYS_CLK_100M_N));

//Generate the ILA for data collection:
ila_0 ILAinst(.clk(sample_clk),.probe0(run),.probe1(solution_flag),.probe2(failure),.probe3(counter[37:0]));

//Instantiate VIO:
vio_0 VIOinst (.clk(sample_clk),.probe_out0(reset),.probe_out1(solution_set[5:0]));

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