#include <malloc.h>

int* intArray;

int* getIntArr_ptr(int size){
    intArray = malloc(size*sizeof(int));
    for (int i = 0; i < size; i++)
    {
        intArray[i] = 11*(i+1);
    }
    return intArray;
}

void freeArr(){
    free(intArray);
}
