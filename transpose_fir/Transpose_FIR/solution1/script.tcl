############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project Transpose_FIR
set_top fir
add_files fir.cpp
add_files -tb fir_test.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7a35tcpg236-1}
create_clock -period 5.690 -name default
source "./Transpose_FIR/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
