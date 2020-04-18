#include <stdio.h>
#include <malloc.h>

#include "caux.h"

extern int ghdl_main(char argc, char* argv[]);

int main(char argc, char* argv[]){
	char strIn[3];

	printf("Enter the length of the integer array [1-99]: ");
	fgets(strIn, 3, stdin);
	printf("\n");
	sscanf(strIn, "%d", &arraySize);

	intArray = malloc(arraySize*sizeof(int));
	for(int i = 0; i < arraySize; i++){
		intArray[i] = 11*(i+1);
	}

	printf("GHDL Simulation Begin\n*****************************************\n");
	int ghdlReturn = ghdl_main(argc, argv);
	printf("*****************************************\nGHDL Simulation End\n");

	free(intArray);
}