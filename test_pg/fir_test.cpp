#define WSIZE 16
//#include "ap_int.h"
//#include "fir.cpp"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include<sys/time.h>

typedef int coef_t;
typedef int data_t;
typedef int acc_t;
typedef int ctr_t;

void fir(data_t, data_t *);

void readMatrix(FILE *inputFilePtr, int *matrix, int rows, int cols) {
	for(int i=0; i<rows; i++) {
		for(int j=0; j<cols; j++) {
			fscanf(inputFilePtr, "%d", &matrix[i*cols+j]);
		}
	}
}

void writeMatrix(FILE *outputFilePtr, int *matrix, int ksize, int isize) {

		for(int j=0; j<isize; j++) {
			fprintf(outputFilePtr, "%d ", matrix[ksize-1 +j]);
		}
		fprintf(outputFilePtr, "\n");
}

int main(){
    int *image, *conv;
    int ISIZE;
    int retval=0;
    struct timeval t1, t2;
    double seconds, microSeconds;
    // FILE POINTERS
    FILE *imageFilePtr, *outputFilePtr;

    imageFilePtr = fopen("1Dinput.dat", "r");
	if(imageFilePtr == NULL) {
	    printf("Failed to open the image file.!!\n");
		return 0;
	}

    fscanf(imageFilePtr, "%d",&ISIZE);

    // allocate memory
    image = (int *)malloc((ISIZE+WSIZE-1)*sizeof(int));
    conv = (int *)malloc((ISIZE+WSIZE-1)*sizeof(int));
	memset(image,0,(ISIZE+WSIZE-1)*sizeof(int));


    // File io
    // read image and filter data
    readMatrix(imageFilePtr, image, 1, ISIZE);
	//readMatrix(kernelFilePtr, kernel, 1, KSIZE);

    gettimeofday(&t1, NULL);
    //================ Function call =====================//
    //convolution_2D(image,kernel,conv,ISIZE,KSIZE);
    for(int i = 0; i < ISIZE+WSIZE-1; ++i){
    	fir(image[i],conv + i);
    }
    //====================================================//
    gettimeofday(&t2, NULL);
    // print the time taken by the compute function
	seconds = t2.tv_sec - t1.tv_sec;
	microSeconds = t2.tv_usec - t1.tv_usec;
	printf("Time taken (ms): %.6f\n", 1000*seconds + microSeconds/1000);


    // Write output
    outputFilePtr = fopen("1Doutput.dat", "w");
	writeMatrix(outputFilePtr, conv, WSIZE, ISIZE);

	//retval = system("python3 C:/msys64/mingw64/lib/python3.9/Tools/scripts/diff.py -u 1Doutput.dat 1Doutputgolden.dat");
    retval = system("diff --brief -w 1Doutput.dat 1Doutputgolden.dat");
	if(retval!=0){
		printf("Test failed");
		retval = 1;
	}
	if(retval==0) printf("Test successful");
    // close files
    fclose(imageFilePtr);
    //fclose(kernelFilePtr);
    fclose(outputFilePtr);

	// deallocate memory
	free(image);
    //free(kernel);
    free(conv);
    return retval;
}
