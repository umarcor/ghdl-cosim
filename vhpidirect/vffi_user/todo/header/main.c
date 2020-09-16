#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include "vffi_user.h"

void getString(ghdl_NaturalDimArr_t* ptr) {
  *ptr = ghdlFromString("HELLO WORLD");
}

void getIntVec(ghdl_NaturalDimArr_t* ptr) {
  int32_t vec[6] = {11, 22, 33, 44, 55};
  int32_t len[1] = {5};
  int x;
  for ( x=0 ; x<len[0] ; x++ ) {
    printf("%d: %d\n", x, vec[x]);
  }
  *ptr = ghdlFromArray(vec, len, 1);
}

ghdl_AccNaturalDimArr_t* getLine() {
  return ghdlAccFromString("HELLO WORLD");
}
