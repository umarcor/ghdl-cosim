#include <stdio.h>
#define SIZE_ARRAY (sizeof(intArray)/sizeof(int))

int intArray[5];
int* getIntArr_ptr(){//function acts like a constructor so initialise the variable
    for (int i = 0; i < SIZE_ARRAY; i++)
    {
        intArray[i] = 11*(i+1);
    }
    return intArray;
}