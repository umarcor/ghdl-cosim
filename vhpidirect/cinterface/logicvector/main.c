#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include <ghdl.h>

int32_t* vec;
bounds_t* vec_bounds;
int32_t* mat;
bounds_t* mat_bounds;
int32_t* d3_ptr;
bounds_t* d3_bounds;
int* len;
int* len2;
int* len3;

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
    printf("C vec_logic[%d] = %c\n", i, HDL_LOGIC_STATE[vec[i]]);
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
      printf("[%d][%d] = %c (%d)\t", i, j, HDL_LOGIC_STATE[mat_ulogic[flatIndex]], flatIndex);
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
  free(d3_ptr);
  free(d3_bounds);
  free(len);
  free(len2);
  free(len3);
}

void getLogicVec(ghdl_NaturalDimArr_t* ptr){
  mat = malloc(2*3*sizeof(int32_t));
  int32_t len[2] = {2, 3};
  int x, y, ind[2];
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      mat[flatIndex] = 11*(flatIndex+1);
    }
  }
  //ghdl_NaturalDimArr_t* ptr = malloc(sizeof(ghdl_NaturalDimArr_t));
  *ptr = ghdlFromPointer((void *)mat, len, 2);
  mat_bounds = ptr->bounds;
  printf("\n2D Array values [%d,%d]:\n", len[0], len[1]);
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      printf("mat[%d][%d] = %d\t", x, y, mat[flatIndex]);
    }
    printf("\n");
  }
  //return ptr;
}

void getULogicMat(ghdl_NaturalDimArr_t* ptr){
  int32_t d3[2][4][3];
  int32_t len[3] = {2, 4, 3};
  int x, y, z, ind[3];
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      for ( z=0 ; z<len[2] ; z++ ) {
        ind[2] = z;
        int flatIndex = getFlatArrayIndex(ind, len, 3);
        d3[x][y][z] = 11*(flatIndex+1);
      }
    }
  }
  //ghdl_NaturalDimArr_t* ptr = malloc(sizeof(ghdl_NaturalDimArr_t));
  *ptr = ghdlFromArray((void *)d3, len, 3, sizeof(int32_t));
  d3_ptr = ptr->array;
  d3_bounds = ptr->bounds;
  printf("\n3D Array values [%d,%d,%d]:\n", len[0], len[1], len[2]);
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      for ( z=0 ; z<len[2] ; z++ ) {
        ind[2] = z;
        int flatIndex = getFlatArrayIndex(ind, len, 3);
        printf("d3[%d][%d][%d] = %d\t", x, y, z, d3[x][y][z]);
      }
      printf("\n");
    }
    printf("\n");
  }
  //return ptr;
}