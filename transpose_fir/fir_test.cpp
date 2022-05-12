//#define WSIZE 8
#include "ap_int.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<sys/time.h>

typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;

void readMatrix(FILE *inputFilePtr, int *matrix, int rows, int cols) {
	for(int i=0; i<rows; i++) {
		for(int j=0; j<cols; j++) {
			fscanf(inputFilePtr, "%d", &matrix[i*cols+j]);
		}
	}
}

void writeMatrix(FILE *outputFilePtr, int *matrix, int ksize, int isize) {

		for(int j=0; j<isize; j++) {
			fprintf(outputFilePtr, "%d\n", matrix[ksize +j]);
		}
		fprintf(outputFilePtr, "\n");
}

int main(){
    int *image, *kernel, *conv, *acc;
    int ISIZE,KSIZE;
    int retval=0;
    struct timeval t1, t2;
    double seconds, microSeconds;
    // FILE POINTERS
    FILE *imageFilePtr, *kernelFilePtr, *outputFilePtr;

    imageFilePtr = fopen("1Dinput.dat", "r");
	if(imageFilePtr == NULL) {
	    printf("Failed to open the image file.!!\n");
		return 0;
	}

    kernelFilePtr = fopen("1DKernel.dat", "r");
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

    gettimeofday(&t1, NULL);
    //================ Function call =====================//
    //convolution_2D(image,kernel,conv,ISIZE,KSIZE);
    for(int i = 0; i < ISIZE+WSIZE-1; ++i){
    	fir(image[i],kernel,conv,KSIZE);
    }
    //====================================================//
    gettimeofday(&t2, NULL);
    // print the time taken by the compute function
	seconds = t2.tv_sec - t1.tv_sec;
	microSeconds = t2.tv_usec - t1.tv_usec;
	printf("Time taken (ms): %.6f\n", 1000*seconds + microSeconds/1000);


    // Write output
    outputFilePtr = fopen("1Doutput.dat", "w");
	writeMatrix(outputFilePtr, conv, KSIZE, ISIZE);

	retval = system("diff -brief -w 1Doutput.dat 1Doutputgolden.dat");

	if(retval!=0){
		printf("Test failed");
		retval = 1;
	}
	if(retval==0) printf("Test successful");
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
