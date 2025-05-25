# Simple-sparse-Ising-machine
Python and verilog code related to the article, "An improved update rule for probabilistic computers."

The related data can be found at Figshare at https://figshare.com/articles/dataset/All_project_data/29145572

All files related to multipliers are in the multiplier folder. A great deal of detail on how to use the code to build multipliers is there. The code to auto-generate arbitrarily large multipliers in python code is also in this folder.

We include both standard and 'size' verilog files that can be built in Xilinx's Vivado or adapted for other applications. 
- The standard files have an Integrated Logic Analyzer (ILA) intellectual property (IP) block instantiated in the code for sampling the virtual signals on-chip. Most also have a Virtual Input/Output (VIO) IP block instantiation code for controlling the system through the ILA GUI in Vivado. This allows the user to change parameters/inputs without recompiling the project, and reset the system without reprogramming the FPGA. 
- The size files have the ILA/VIO removed and are intended for bare-bones operation. This is to give some sense of the size of the actual Ising machine, as the IP blocks take up additional resources on-chip.

We also include the Jupyter notebook we used to generate all the figures in the manuscript.

python version: 3.9.13

FPGA: Xilinx Zynq Ultrascale+ RFSoC 4$\times$2 (XCZU48DR-2FFVG1517E)

Vivado version: 2023.2 Enterprise (enterprise required for this FPGA)

All of the code we present here is to aid readers of our manuscript in reproducing our results, and is presented as-is. There are several steps missing in generating real FPGA projects, but the Verilog code is the most important aspect to reproducing our work. We cannot guarantee that any other versions or brands of software will compile the Verilog code into the exact same form that we witnessed. The archived zip files from any of our Ising machine projects are $> 26$ MB and Github only allows up to 25 MB submissions, so we unfortunately cannot provide any here.
