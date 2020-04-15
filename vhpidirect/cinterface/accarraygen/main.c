#include <stdio.h>
#include <malloc.h>

int* intArray;
int* getIntArr_ptr(){//function acts like a constructor so initialise the variable
    intArray = malloc(5*sizeof(int));
    for (int i = 0; i < 5; i++)
    {
        intArray[i] = 11*(i+1);
    }
    return intArray;
}

void freeIntArray(){
    for (int i = 0; i < 5; i++)
    {
        printf("intArray[%d] = %d\n", i, intArray[i]);
    }
    free(intArray);
}