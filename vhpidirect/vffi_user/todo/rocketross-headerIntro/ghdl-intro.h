#ifndef GHDL_TYPES_INTRO_H
#define GHDL_TYPES_INTRO_H

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// Range/bounds of a dimension of an unconstrained array with dimensions of type 'natural'
typedef struct {
  int32_t left;
  int32_t right;
  int32_t dir;
  int32_t len;
} bounds_t;

// Unconstrained array with dimensions of type 'natural'
typedef struct {
  void* array;
  bounds_t* bounds;
} ghdl_NaturalDimArr_t;

/*
*  Print custom types
*/

void printUnconstrained(ghdl_NaturalDimArr_t* ptr, int dims) {
  printf("array: %p\n", ptr->array);
  printf("bounds: %p\n", ptr->bounds);
  int i;
  for(i = 0; i < dims; i++){
    printf("bounds%d.left: %d\n", i, ptr->bounds[i].left);
    printf("bounds%d.right: %d\n", i, ptr->bounds[i].right);
    printf("bounds%d.dir: %d\n", i, ptr->bounds[i].dir);
    printf("bounds%d.len: %d\n", i, ptr->bounds[i].len);
  }
}

/*
*  Convert a fat pointer of an uncontrained array with (up to 3) dimensions of type 'natural', to C types
*/

void ghdlToArray(ghdl_NaturalDimArr_t* ptr, void** vec, int* len, int num) {
  assert(ptr != NULL);
  assert(ptr->bounds != NULL);
  *vec = ptr->array;

  for (int i = 0; i < num; i++)
  {
    len[i] = ptr->bounds[i].len;
  }
}

/*
*   Helper to setup the bounds_t for ghdlFromArray
*/

void ghdlSetRange(bounds_t* r, int len, bool reversed){
  if(!reversed){//to
    r->left = 0;
    r->right = len-1;
    r->dir = 0;
    r->len = len;
  }
  else{//downto
    r->left = len-1;
    r->right = 0;
    r->dir = 1;
    r->len = len;
  }
}

/*
*  Convert C types representing an unconstrained array with a dimension of type 'natural', to a fat pointer
*/


ghdl_NaturalDimArr_t ghdlFromPointer(void* vec, int* len, int dims) {
  bounds_t* b = malloc(sizeof(bounds_t)*dims);
  assert(b != NULL);

  for (int i = 0; i < dims; i++)
  {
    ghdlSetRange(b+i, len[i], false);
  }
  
  void *a = vec;
  return (ghdl_NaturalDimArr_t){.array= a, .bounds=b};
}

ghdl_NaturalDimArr_t ghdlFromArray(void* vec, int* len, int dims, int sizeOfDataType) {
  bounds_t* b = malloc(sizeof(bounds_t)*dims);
  int totalSize = 1;
  for (int i = 0; i < dims; i++)
  {
    totalSize *= len[i];
    ghdlSetRange(b+i, len[i], false);
  }

  void *a = malloc(sizeOfDataType * totalSize);
  memcpy(a, vec, sizeOfDataType * totalSize);

  return (ghdl_NaturalDimArr_t){.array= a, .bounds=b};
}

/*  
*   Handle C char for the appropriate values in std_ulogic and std_logic.
*/

// @RocketRoss
static const char HDL_LOGIC_CHAR[] = { 'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-'};

enum HDL_LOGIC_STATES {
HDL_U = 0,
HDL_X = 1,
HDL_0 = 2,
HDL_1 = 3,
HDL_Z = 4,
HDL_W = 5,
HDL_L = 6,
HDL_H = 7,
HDL_D = 8,
};

#endif
