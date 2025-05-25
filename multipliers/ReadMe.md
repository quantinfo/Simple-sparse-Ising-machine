# Building and running multipliers:
There are various types of files included here. For the majority of the multipliers, only the Verilog code is given. The code is well-commented, so it is clear what Xilinx Intellectual Property (IP) blocks need to be created by the user. 

## In python

## In Xilinx's Vivado application:
In Vivado, first the user must create a project

All projects require a Clocking Wizard IP block to generate the shifted clocks.
For kxkvio verilog files (where k = bits in each factor), the user will need to build ILA and VIO IP.

### Clocking Wizard IP block:
All the multipliers I consider here run with 6 clocks generated with an MMCM. They are set to 110 MHz (maximum speed for the 16x16 multiplier) and are given the following phase shifts: $0\degree$, $60\degree$, $120\degree$, $180\degree$, $240\degree$, $300\degree$. The first 5 are responsible for scheduling updates; The P-Bits of the 5 different colors update on the positive edge of their respective clocks. The last clock triggers the oracle to register the state of the system and check whether the factors multiply to the current product. The last clock also controls resets, flags, and other controls in the system. 

I used the Zynq Ultrascale+ RFSoC 4x2 board for this project. Other FPGAs may be able to run faster clocks and pass the timing analysis, and some may not be able to run quite as fast. The highest possible clock speeds, unfortunately, will need to be discovered using trial and error. The phase-shifts between clocks are ideal and should not be altered. 

### Integrated Logic Analyzer (ILA) IP block:
The ILA allows the user to measure virtual signals on-chip. It measures 1,024 samples, reporting the 
