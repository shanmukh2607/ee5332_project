#define N 16
#include "ap_int.h"
typedef int coef_t;//ap_int<10> coef_t;
typedef int data_t; //ap_int<16> data_t;
typedef int acc_t; //ap_int<16> acc_t;
void fir(data_t *y, data_t x) {
	coef_t c[N] = {11,24,48,83,130,181,226,252,252,226,181,130,83,48,24,11}; //weights are scaled by x256 and rounded
    static data_t shift_reg[N];
    acc_t acc;
    int i;
    acc = 0;
    acc += x * c[0];
    shift_accum_loop:
    for (i = N - 1; i > 0; i--) {
#pragma HLS pipeline off
        shift_reg[i] = shift_reg[i-1];
        acc += shift_reg[i] * c[i];
    }
    *y = acc;
}
