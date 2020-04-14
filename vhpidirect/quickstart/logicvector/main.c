#include <stdio.h>
static const char HDL_LOGIC_STATE[] = { 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-'};

char logic_vec[9];
int logic_vec_size = 9;

int getLogicVecSize(){
  return logic_vec_size;
}

char* getLogicVec(){
  printf("1D Array Logic Values [%d]:\n", logic_vec_size);
  for(int i = 0; i < logic_vec_size; i++){
    logic_vec[i] = i;
    printf("[%d] = %c\t", i, HDL_LOGIC_STATE[i]);
  }
  printf("\n");
  return logic_vec;
}

/* char* getULogicMat(){
  mat = malloc(3*3*sizeof(int));
  int x, y;
  printf("\n2D Array values [%d,%d]:\n", len[0], len[1]);
  for ( x=0 ; x<len[0] ; x++ ) {
    for ( y=0 ; y<len[1] ; y++ ) {
      int flatIndex = x*len[1] + y;
      mat[flatIndex] = flatIndex%9;
      printf("mat[%d][%d] = %c\t", x, y, HDL_LOGIC_STATE[mat[flatIndex]]);
    }
  }
  return mat;
} */