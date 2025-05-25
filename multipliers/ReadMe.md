# Building and running multipliers:
There are various types of files included here. For the majority of the multipliers, only the Verilog code is given. The code is well-commented, so it is clear what Xilinx Intellectual Property (IP) blocks need to be created by the user.

We include an example constraints (XDC) file. 

Unfortunately, Github does not allow file uploads larger than 25 MB, and the smallest archived Vivado project is just over that limit (even with the minimum number of included files).

## Auto-generation code in python:
**gen_sparse_j_h_verilog.py** has two main functions, each taking as input the size of the factors and the maximum number of nearest neighbors (minimum of 5). The function J_mult builds the weight matrix J, the bias vector h, and returns them along with several parameters that indicate how the multiplier has been structured. The function I_table also builds J and h, but returns the $I_i$ LUT for each P-Bit in the multiplier. Both functions return the size of the multiplier (total number of P-Bits), the zero-clamped indices (third input to Full adders that are nominally Half adders), and the output indices (the indices of product bits). In the structure of the multipliers, the P-Bits indexed $k-1$ through 0 are the most significant bit (MSB) to the least significant bit (LSB) of the first factor, and P-Bits indexed $2k-1$ through $k$ are the MSB through the LSB of the second factor. 

**Gen_VerilogRunTilDone_LFSR_3-25.ipynb** is a Jupyter notebook that calls gen_sparse_j_h_verilog.py to generate multiplier structures, and makes verilog code from it. 

- The first large block of code does various tasks: It builds the multiplier using gen_sparse_j_h_verilog.py, breaks the P-Bits into colors, and builds the verilog code that can be copy and pasted into a main.v file in a Vivado project to generate the corresponding multiplier. Note that while the code for initializing IP blocks is included in this Verilog code, one must still build the IP blocks inside of Vivado and make sure they have the same names (the names as given are default, so renaming IP blocks likely will not be necessary. 

- The second large block of code does a very similar task as the first, but it alters the verilog code so that only the Clock IP is still present. Without the VIO, only the product specified in the Verilog-generating function will be factored. Without the ILA, the way we know whether the system successfully factored the integer is by attaching "success" and "failure" (timeout) flags to user LEDs on the board.

## Make a project using the Verilog code in Xilinx's Vivado application:
All projects require a Clocking Wizard IP block to generate the shifted clocks.

For kxkvio verilog files (where k = bits in each factor), the user will need to build ILA, VIO and Clocking Wizard IP.
For kxksize verilog files, only the Clocking Wizard IP block is needed.

### Clocking Wizard IP block:
All the multipliers I consider here run with 6 clocks generated with an MMCM. They are set to 110 MHz (maximum speed for the 16x16 multiplier) and are given the following phase shifts: $0\degree$, $60\degree$, $120\degree$, $180\degree$, $240\degree$, $300\degree$. The first 5 are responsible for scheduling updates; The P-Bits of the 5 different colors update on the positive edge of their respective clocks. The last clock triggers the oracle to register the state of the system and check whether the factors multiply to the current product. The last clock also controls resets, flags, and other controls in the system. 

I used the Zynq Ultrascale+ RFSoC 4x2 board for this project. Other FPGAs may be able to run faster clocks and pass the timing analysis, and some may not be able to run quite as fast. The highest possible clock speeds, unfortunately, will need to be discovered using trial and error. The phase-shifts between clocks ($60 \degree$) are ideal and should not be altered. 

### Integrated Logic Analyzer (ILA) IP block:
The ILA allows the user to measure virtual signals on-chip. It measures 1,024 samples, reporting the number of full-system updates required for a solution. A full-system update happens every full clock cycle, so the time-to-solution is just the number of updates divided by the clock rate. The ILA should be built with capture control. This will allow two triggers for data point collection in the GUI: Update the trigger to "run = Boolean 1" so that the ILA begins measuring when the run flag goes high, and change the ILA capture settings to "Basic" so that 'solution_flag = Boolean 1' can be set as the capture condition. With these settings, the ILA will only measure when the solution_flag goes high, which happens when either a solution is found OR when the system times out (in which case, the 'failure' flag will also be high).

### Virtual Input/Output (VIO) IP block:
The VIO allows us to send virtual signals to the circuit from the ILA GUI while it is running. We are only interested in "output probes" which are in reality inputs from the user, read by the system. The system is designed so that when the VIO parameters change in the VIO window in the ILA GUI, nothing happens on the circuit until the 'reset' VIO signal is raised and then lowered. The VIO allows us to reset the system and set the product (in binary or unsigned integer form) that we wish to factorize, without recompiling the circuit. 
