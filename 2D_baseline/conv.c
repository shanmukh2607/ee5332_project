#include <stdio.h>
#include <stdlib.h>
#include<sys/time.h>


void readMatrix(FILE *inputFilePtr, int *matrix, int rows, int cols) {
	for(int i=0; i<rows; i++) {
		for(int j=0; j<cols; j++) {
			fscanf(inputFilePtr, "%d", &matrix[i*cols+j]);
		}
	}
}

void writeMatrix(FILE *outputFilePtr, int *matrix, int rows, int cols) {
	for(int i=0; i<rows; i++) {
		for(int j=0; j<cols; j++) {
			fprintf(outputFilePtr, "%d ", matrix[i*cols+j]);
		}
		fprintf(outputFilePtr, "\n");
	}
}

void convolution_2D(int *N, int *M, int *P, int ISIZE, int KSIZE) {

    // find center position of kernel (half of kernel size)
    int kCenterX = KSIZE / 2;
    int kCenterY = KSIZE / 2;

    for (int i = 0; i < ISIZE; ++i)              // rows
    {
        for (int j = 0; j < ISIZE; ++j)          // columns
        {
            for (int m = 0; m < KSIZE; ++m)     // kernel rows
            {
				int ii = i + (m - kCenterY);
                for (int n = 0; n < KSIZE; ++n) // kernel columns
                {
                    // index of input signal, used for checking boundary
                    int jj = j + (n - kCenterX);
                    // ignore input samples which are out of bound
                    if (ii >= 0 && ii < ISIZE && jj >= 0 && jj < ISIZE)
                        P[i*ISIZE + j] += N[ii*ISIZE + jj] * M[m*KSIZE + n]/16;
                }
            }
        }
    }
}

int main(){
    int *image, *kernel, *conv;
    int ISIZE,KSIZE;
    struct timeval t1, t2;
    double seconds, microSeconds;
    // FILE POINTERS
    FILE *imageFilePtr, *kernelFilePtr, *outputFilePtr;
    
    imageFilePtr = fopen("image.txt", "r");
	if(imageFilePtr == NULL) {
	    printf("Failed to open the image file.!!\n"); 
		return 0;
	}

    kernelFilePtr = fopen("kernel.txt", "r");
	if(kernelFilePtr == NULL) {
	    printf("Failed to open the kernel file.!!\n"); 
		return 0;
	}
    // reads ISIZE
    fscanf(imageFilePtr, "%d",&ISIZE);
    // reads KSIZE
    fscanf(kernelFilePtr, "%d", &KSIZE);

    // allocate memory
    image = (int *)malloc(ISIZE*ISIZE*sizeof(int));
    kernel = (int *)malloc(KSIZE*KSIZE*sizeof(int));
    conv = (int *)malloc(ISIZE*ISIZE*sizeof(int));
    // File io
    // read image and filter data
    readMatrix(imageFilePtr, image, ISIZE, ISIZE);
	readMatrix(kernelFilePtr, kernel, KSIZE, KSIZE);

    gettimeofday(&t1, NULL);
    //================ Function call =====================//
    convolution_2D(image,kernel,conv,ISIZE,KSIZE);
    //====================================================//
    gettimeofday(&t2, NULL);
    // print the time taken by the compute function
	seconds = t2.tv_sec - t1.tv_sec;
	microSeconds = t2.tv_usec - t1.tv_usec;
	printf("Time taken (ms): %.3f\n", 1000*seconds + microSeconds/1000);


    // Write output
    outputFilePtr = fopen("output.txt", "w");
	writeMatrix(outputFilePtr, conv, ISIZE, ISIZE);

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