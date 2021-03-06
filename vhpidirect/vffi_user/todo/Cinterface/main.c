#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "vffi_user.h"

ghdl_NaturalDimArr_t* getString() {
  ghdl_NaturalDimArr_t* fat = fatptrFromString("HELLO");
  printfat(fat);
  return fat;
}

ghdl_NaturalDimArr_t* getIntVec() {
  int32_t vec[5] = {11, 22, 33, 44, 55};
  int32_t len[1] = {5};
  ghdl_NaturalDimArr_t* fat = fatptrFromIntegerArray(vec, len, 1);
  printfat(fat);
  return fat;
}
