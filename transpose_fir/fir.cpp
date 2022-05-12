#include "ap_int.h"
#define WSIZE 16
typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;

void fir(data_t in,data_t *out) {
	static acc_t Acc[WSIZE];
	//#pragma HLS array_partition variable=Acc complete
	coef_t w[WSIZE] = {11,24,48,83,130,181,226,252,252,226,181,130,83,48,24,11}; //weights are scaled by x256 and rounded
	ctr_t j;
	broadcast_loop:
    for (j = WSIZE - 1; j >0; --j)	// inspired from transpose form
    {
		Acc[j] = in*w[j] + Acc[j-1];
	}
	Acc[0] = in*w[0];
	*out = Acc[WSIZE-1]>>8;
}

