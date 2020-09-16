#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include <ghdl-intro.h>

char* vec;
bounds_t* vec_bounds;
char* mat;
bounds_t* mat_bounds;
int* len;
int* len2;

int getFlatArrayIndex(int* dimIndex, int* lens, int dims){
  if(dims == 1){
    return dimIndex[0];
  }
  else{
    return dimIndex[dims-1] + (lens[dims-1]*getFlatArrayIndex(dimIndex, lens, dims-1));
  }
}

void testCinterface(
  ghdl_NaturalDimArr_t* v_vec_logic,
  ghdl_NaturalDimArr_t* v_mat_ulogic
) {

  //VECTOR 1D////////////////////////////////////////
  printf("\nvector\n");
  printUnconstrained(v_vec_logic, 1);
   len = malloc(1 * sizeof(int));

  char* vec;
  ghdlToArray(v_vec_logic, (void**)&vec, len, 1);
  for (int i = 0; i < len[0]; i++)
  {
    printf("C vec_logic[%d] = %c\n", i, HDL_LOGIC_CHAR[vec[i]]);
  }
  printf("v_vec_logic  : %p [%d]\n\n", vec, len[0]);

  //MATRIX 2D////////////////////////////////////////
  printf("\nmatrix\n");
  printUnconstrained(v_mat_ulogic, 2);
  len2 = malloc(2 * sizeof(int));

  char* mat_ulogic;
  ghdlToArray(v_mat_ulogic, (void**)&mat_ulogic, len2, 2);
  for (int i = 0; i < len2[0]; i++)
  {
    for (int j = 0; j < len2[1]; j++)
    { 
      int ind[] = {i, j};
      int flatIndex = getFlatArrayIndex(ind, len2, 2);
      printf("[%d][%d] = %c (%d)\t", i, j, HDL_LOGIC_CHAR[mat_ulogic[flatIndex]], flatIndex);
    }
    printf("\n");
  }
  printf("v_mat_ulogic  : %p [%d,%d]\n\n", mat_ulogic, len2[0], len2[1]);
   
  printf("end testCinterface\n\n");
}

void freePointers(){
  free(vec);
  free(vec_bounds);
  free(mat);
  free(mat_bounds);
  free(len);
  free(len2);
}

void getLogicVec(ghdl_NaturalDimArr_t* ptr){
  char vecArr[9];
  int32_t len[1] = {9};
  for(int i = 0; i < len[0]; i++){
    vecArr[i] = i;
  }
  printf("\n");

  *ptr = ghdlFromArray((void *)vecArr, len, 1, sizeof(char));
  vec_bounds = ptr->bounds;
  vec = ptr->array;
  printf("1D Array Logic Values [%d]:\n", len[0]);
  for(int x = 0; x < len[0]; x++){
    printf("[%d] = %c\t", x, HDL_LOGIC_CHAR[x]);
    assert(((char*)ptr->array)[x] == vecArr[x]);
    //ghdlFromArray creates a deep-copy of the information, so this change is not reflected in VHDL
    vecArr[x] = 0;
  }

}

void getULogicMat(ghdl_NaturalDimArr_t* ptr){
  mat = malloc(3*3*sizeof(int32_t));
  int32_t len[2] = {3, 3};
  int x, y, ind[2];
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      mat[flatIndex] = flatIndex%9;
    }
  }
  //ghdl_NaturalDimArr_t* ptr = malloc(sizeof(ghdl_NaturalDimArr_t));
  *ptr = ghdlFromPointer((void *)mat, len, 2);
  mat_bounds = ptr->bounds;
  assert(mat == ptr->array);
  printf("\n2D Array values [%d,%d]:\n", len[0], len[1]);
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      printf("mat[%d][%d] = %c\t", x, y, HDL_LOGIC_CHAR[mat[flatIndex]]);
      assert(((char*)ptr->array)[flatIndex] == mat[flatIndex]);
    }
    printf("\n");
  }
}