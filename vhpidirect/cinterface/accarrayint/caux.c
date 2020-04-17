#include <stdio.h>
#define SIZE_ARRAY (sizeof(intArray)/sizeof(int))

int intArray[6];

int getIntArrSize(){//function acts like a constructor so initialise the variable
    return SIZE_ARRAY;
}

int* getIntArr_ptr(){//function acts like a constructor so initialise the variable
    for (int i = 0; i < SIZE_ARRAY; i++)
    {
        intArray[i] = 11*(i+1);
    }
    return intArray;
}