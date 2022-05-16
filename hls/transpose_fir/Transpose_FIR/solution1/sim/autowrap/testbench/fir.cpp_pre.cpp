# 1 "C:/Users/bsksh/Documents/Vitis/transpose_fir/fir.cpp"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "C:/Users/bsksh/Documents/Vitis/transpose_fir/fir.cpp"




typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;






void fir(data_t in,acc_t *out) {
#pragma HLS pipeline II=1



 static acc_t Acc1[16];

#pragma HLS array_partition variable=Acc1 complete
 coef_t w[16] = {11,24,48,83,130,181,226,252,252,226,181,130,83,48,24,11};
 ctr_t j;

  broadcast_loop:
  for (j = 16 - 1; j >0; --j)
  {
#pragma HLS unroll factor=15
#pragma HLS dependence variable=Acc1 inter true
   Acc1[j] = in*w[j] + Acc1[j-1];
  }
  Acc1[0] = in*w[0];
  *out = Acc1[16 -1];
}
