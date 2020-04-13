#include "cSharedVar.h"

int getIntArrSize(){//function acts like a constructor so initialise the variable
    sizeInt = 5;
    return sizeInt;
}

int* getIntArr_ptr(){//function acts like a constructor so initialise the variable
    intArray = malloc(sizeInt*sizeof(int));
    for (int i = 0; i < sizeInt; i++)
    {
        intArray[i] = 11*(i+1);
    }
    return intArray;
}

void freeIntArray(){
    for (int i = 0; i < sizeInt; i++)
    {
        printf("intArray[%d] = %d\n", i, intArray[i]);
    }
    free(intArray);
}