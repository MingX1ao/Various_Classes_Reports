// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:24:04 MST 2014
// Date        : Fri Dec 29 22:16:21 2023
// Host        : DESKTOP-1LQGH74 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/bme317/Desktop/major_assignment/project_1/project_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in1, clk_out1, clk_out2, clk_out3)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,clk_out2,clk_out3" */;
  input clk_in1;
  output clk_out1;
  output clk_out2;
  output clk_out3;
endmodule
