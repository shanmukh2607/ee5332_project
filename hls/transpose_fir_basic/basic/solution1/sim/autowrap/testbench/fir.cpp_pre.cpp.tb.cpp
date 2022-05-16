// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
# 1 "C:/Users/bsksh/Documents/Vitis/transpose_fir_basic/fir.cpp"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "C:/Users/bsksh/Documents/Vitis/transpose_fir_basic/fir.cpp"


typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;

void fir(data_t in, acc_t *out) {

 static acc_t Acc[16];
 coef_t w[16] = {11,24,48,83,130,181,226,252,252,226,181,130,83,48,24,11};
 ctr_t j;
 broadcast_loop:
    for (j = 16 - 1; j >0; --j)
    {
#pragma HLS pipeline II=2

     Acc[j] = in*w[j] + Acc[j-1];
 }
 Acc[0] = in*w[0];
 *out = Acc[16 -1];
}
#ifndef HLS_FASTSIM
#ifdef __cplusplus
extern "C"
#endif
void apatb_fir_ir(int, int *);
#ifdef __cplusplus
extern "C"
#endif
void fir_hw_stub(int in, int *out){
fir(in, out);
return ;
}
#ifdef __cplusplus
extern "C"
#endif
void apatb_fir_sw(int in, int *out){
apatb_fir_ir(in, out);
return ;
}
#endif
# 22 "C:/Users/bsksh/Documents/Vitis/transpose_fir_basic/fir.cpp"

