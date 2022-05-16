#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<sys/time.h>


__global__ void fir(int *in, int *kernel, int *out, int I, int K){
    __shared__ int Acc[17];
    Acc[threadIdx.x] = 0;
    int temp;
    int w = kernel[threadIdx.x];
    for(int i=0; i<I+K-1; i++){
        temp = in[i]*w + Acc[threadIdx.x];
        //if(threadIdx.x ==1) printf("%d %d %d\n", temp,in[i],w);
        //__syncthreads(); not required since #threads < warpsize=32
        Acc[threadIdx.x+1] = temp;
        if(threadIdx.x == 15) out[i] = temp;
        __syncthreads();
    }
}

void readMatrix(FILE *inputFilePtr, int *matrix, int rows, int cols) {
	for(int i=0; i<rows; i++) {
		for(int j=0; j<cols; j++) {
			fscanf(inputFilePtr, "%d", &matrix[i*cols+j]);
		}
	}
}

void writeMatrix(FILE *outputFilePtr, int *matrix, int ksize, int isize) {
	
		for(int j=0; j<isize; j++) {
			fprintf(outputFilePtr, "%d\n", matrix[ksize-1 +j]);
		}
		fprintf(outputFilePtr, "\n");
}



int main(){
    int *image, *kernel, *conv;
    int ISIZE,KSIZE;
    // FILE POINTERS
    FILE *imageFilePtr, *kernelFilePtr, *outputFilePtr;
    
    imageFilePtr = fopen("1Dinput.dat", "r");
	if(imageFilePtr == NULL) {
	    printf("Failed to open the image file.!!\n"); 
		return 0;
	}

    kernelFilePtr = fopen("1Dkernel.dat", "r");
	if(kernelFilePtr == NULL) {
	    printf("Failed to open the kernel file.!!\n"); 
		return 0;
	}
    // reads ISIZE
    fscanf(imageFilePtr, "%d",&ISIZE);
    // reads KSIZE
    fscanf(kernelFilePtr, "%d", &KSIZE);

    // allocate memory
    image = (int *)malloc((ISIZE+KSIZE-1)*sizeof(int));
    kernel = (int *)malloc(KSIZE*sizeof(int));
	//acc = (int *)malloc(KSIZE*sizeof(int));
    conv = (int *)malloc((ISIZE+KSIZE-1)*sizeof(int));
	memset(image,0,(ISIZE+KSIZE-1)*sizeof(int));
	//memset(acc,0,KSIZE*sizeof(int));
    // File io
    // read image and filter data
    readMatrix(imageFilePtr, image, 1, ISIZE);
	readMatrix(kernelFilePtr, kernel, 1, KSIZE);

    //=============================================================================
     cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    float milliseconds = 0;
    cudaEventRecord(start,0);

    // device arrays declaration

    int *dinput, *dkernel, *dconv;
    cudaMalloc(&dinput, (ISIZE+KSIZE-1)*sizeof(int));
    cudaMalloc(&dkernel, KSIZE*sizeof(int));
    cudaMalloc(&dconv, (ISIZE+KSIZE-1)*sizeof(int));

    // CUDA Memcpys
    cudaMemcpy(dinput, image, (ISIZE+KSIZE-1)*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dkernel, kernel, KSIZE*sizeof(int), cudaMemcpyHostToDevice);
    // kernel call
    fir<<<1,16>>>(dinput,dkernel,dconv,ISIZE,KSIZE);
    cudaMemcpy(conv,dconv,(ISIZE+KSIZE-1)*sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(dinput);
    cudaFree(dkernel);
    cudaFree(dconv);

    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("Time taken by function to execute is: %.6f ms\n", milliseconds);
    //======================================================================================
    


    // Write output
    outputFilePtr = fopen("1Doutputgolden.dat", "w");
	writeMatrix(outputFilePtr, conv, KSIZE, ISIZE);

    // close files
    fclose(imageFilePtr);
    fclose(kernelFilePtr);
    fclose(outputFilePtr);

	// deallocate memory
	free(image);
    free(kernel);
    free(conv);
    return 0;
}