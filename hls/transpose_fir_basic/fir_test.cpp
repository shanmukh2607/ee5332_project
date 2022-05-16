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

void fir(data_t,data_t *);

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
    data_t *image;
    acc_t *conv;
    int *gold;
    coef_t *coef;
    int ISIZE;
    int wSIZE;
    int retval=0;
    struct timeval t1, t2;
    double seconds, microSeconds;
    // FILE POINTERS
    FILE *imageFilePtr, *outputFilePtr, *goldFilePtr, *coefFilePtr;

    imageFilePtr = fopen("1Dinput.dat", "r");
	if(imageFilePtr == NULL) {
	    printf("Failed to open the input signal file.!!\n");
		return 0;
	}

	goldFilePtr = fopen("1Doutputgolden.dat", "r");
		if(goldFilePtr == NULL) {
		    printf("Failed to open the golden output file.!!\n");
			return 0;
		}

	coefFilePtr = fopen("1Dkernel.dat", "r");
	if(coefFilePtr == NULL){
		printf("Failed to open the coef file.!!\n");
	}


    fscanf(imageFilePtr, "%d",&ISIZE);
    fscanf(coefFilePtr, "%d", &wSIZE);

    if(wSIZE != WSIZE) printf("fixed weight size is incorrect\n");

    // allocate memory
    image = (int *)malloc((ISIZE+WSIZE-1)*sizeof(data_t));
    coef = (int *)malloc(WSIZE*sizeof(coef_t));
    conv = (int *)malloc((ISIZE+WSIZE-1)*sizeof(acc_t));
    gold = (int *)malloc((ISIZE)*sizeof(int));
	memset(image,0,(ISIZE+WSIZE-1)*sizeof(int));


    // File io
    // read image and filter data
    readMatrix(imageFilePtr, image, 1, ISIZE);
    readMatrix(coefFilePtr,coef,1,WSIZE);
    readMatrix(goldFilePtr, gold, 1, ISIZE);

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

	//retval = system("diff --brief -w 1Doutput.dat 1Doutputgolden.dat");
	for (int k = 0; k < ISIZE; k++){
		if(conv[WSIZE-1+k] != gold[k]) {printf("%d %d %d\n",k,conv[WSIZE-1+k],gold[k]);retval++;}
	}


	if(retval!=0){
		printf("Test failed");
		retval = 1;
	}
	if(retval==0) printf("Test successful");
    // close files
    fclose(imageFilePtr);
    fclose(coefFilePtr);
    fclose(outputFilePtr);
    fclose(goldFilePtr);

	// deallocate memory
	free(image);
    free(coef);
    free(conv);
    free(gold);
    return retval;
}
