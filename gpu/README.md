# GPU Implementation of FIR filter
Author: Bachotti Sai Krishna Shanmukh EE19B009 <br>
In the above code, a 16 tap filter is implemented.<br>
To compile the code and see the results: $nvcc fir.cu -arch=sm_35<br>
To use nvprof: $nvprof ./a.out<br>
To run the code: $./a.out<br>
Make sure that the input.dat and kernel.dat files are present