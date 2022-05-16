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
