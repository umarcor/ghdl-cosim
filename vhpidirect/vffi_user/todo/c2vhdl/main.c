#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "vffi_user.h"

fat_t* getString() {
  fat_t* fat = fatptrFromString("HELLO");
  printfat(fat);
  return fat;
}

//fat_t* getIntVec() {
//  int32_t vec[5] = {11, 22, 33, 44, 55};
//  int32_t len[1] = {5};
//  fat_t* fat = fatptrFromIntegerArray(vec, len, 1);
//  printfat(fat);
//  return fat;
//}

//line_t* getLine() {
//  return lineFromString("HELLO WORLD");
//}

extern int ghdl_main(int argc, char **argv);

int main(int argc, char **argv) {
  return ghdl_main(argc, argv);
}
