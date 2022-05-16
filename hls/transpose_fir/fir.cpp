#include "ap_int.h"
#define WSIZE 16
#define BLOCKSIZE 4
//Enable this while sim
typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;

void fir(data_t in,acc_t *out) {
	#pragma HLS pipeline II=1
    //#pragma HLS INTERFACE ap_hs port=in register
    //#pragma HLS INTERFACE ap_hs port=out register

	static acc_t Acc1[WSIZE];
	//#pragma HLS bind_storage variable=Acc type=ram_t2p
	#pragma HLS array_partition variable=Acc1 complete
	coef_t w[WSIZE] = {11,24,48,83,130,181,226,252,252,226,181,130,83,48,24,11}; //weights are scaled by x256 and rounded
	ctr_t j;

		broadcast_loop:
		for (j = WSIZE - 1; j >0; --j)	// inspired from transpose form
		{
			#pragma HLS unroll factor=15
			#pragma HLS dependence variable=Acc1 inter true
			Acc1[j] = in*w[j] + Acc1[j-1];
		}
		Acc1[0] = in*w[0];
		*out = Acc1[WSIZE-1];
}

