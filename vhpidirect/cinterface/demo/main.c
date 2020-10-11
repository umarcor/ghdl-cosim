#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>

#include <ghdl.h>

typedef struct rec_t {
  char    r_char;
  int32_t r_int;
} rec_t;

typedef enum {standby, start, busy, done} enum_t;

int32_t* vec;
bounds_t* vec_bounds;
int32_t* mat;
bounds_t* mat_bounds;
int32_t* d3_ptr;
bounds_t* d3_bounds;
int* len;
int* len2;
int* len3;
bounds_t* string_bounds;
ghdl_AccNaturalDimArr_t* line;

int getFlatArrayIndex(int* dimIndices, int* dimLengths, int dims){
  int indx = dimIndices[0];
	for (int i = 1; i < dims; i++)//Dimension-Indices listed in decreasing dimensionality (Big-Endian)
		indx = indx*dimLengths[i] + dimIndices[i];
	return indx;
}

void testCinterface(
  char     v_logic,
  char     v_ulogic,
  char     v_char,
  int32_t  v_int,
  uint32_t v_nat,
  uint32_t v_pos,
  double   v_real,
  bool     v_bool,
  bool     v_bit,
  int64_t  v_time,
  rec_t*   v_rec,
  uint8_t  v_enum,
  ghdl_NaturalDimArr_t* v_str,
  ghdl_NaturalDimArr_t* v_vec_int,
  ghdl_NaturalDimArr_t* v_vec_real,
  ghdl_NaturalDimArr_t* v_vec_bool,
  ghdl_NaturalDimArr_t* v_vec_bit,
  ghdl_NaturalDimArr_t* v_vec_phy,
  ghdl_NaturalDimArr_t* v_vec_rec,
  ghdl_NaturalDimArr_t* v_vec_enum,
  ghdl_NaturalDimArr_t* v_2vec_real,
  ghdl_NaturalDimArr_t* v_mat_int,
  ghdl_NaturalDimArr_t* v_3d_int
) {
  assert(v_logic == HDL_H);
  printf("v_logic  : %c\n", HDL_LOGIC_CHAR[v_logic]);

  assert(v_ulogic == HDL_Z);
  printf("v_ulogic : %c\n", HDL_LOGIC_CHAR[v_ulogic]);

  assert(v_char == 'k');
  printf("v_char : %c\n", v_char);

  assert(v_int == -6);
  printf("v_int  : %d\n", v_int);

  assert(v_nat == 9);
  printf("v_nat  : %d\n", v_nat);

  assert(v_pos == 3);
  printf("v_pos  : %d\n", v_pos);

  assert(v_real == 3.34);
  printf("v_real : %f\n", v_real);

  assert(v_bool == true);
  printf("v_bool : %d\n", v_bool);

  assert(v_bit == true);
  printf("v_bit  : %d\n", v_bit);

  assert(v_time == 20e6);
  printf("v_time : %ld\n", v_time);

  assert(v_rec != NULL);
  assert(v_rec->r_char == 'y');
  assert(v_rec->r_int == 5);
  printf("v_rec  : %p %c %d\n", v_rec, v_rec->r_char, v_rec->r_int);

  assert(v_enum == busy);
  printf("v_enum : %d %d\n", v_enum, busy);

  char* str = ghdlToString(v_str);
  printf("v_str  : %p '%s' \tlength [%ld]\n", v_str->array, str, strlen(str));
  free(str);

  int* len = malloc(2 * sizeof(int));

  int32_t* vec_int;
  ghdlToArray(v_vec_int, (void**)&vec_int, len, 1);
  assert(vec_int[0] == 11);
  assert(vec_int[1] == 22);
  assert(vec_int[2] == 33);
  assert(vec_int[3] == 44);
  assert(vec_int[4] == 55);
  printf("v_vec_int  : %p \tlength [%d]\n", vec_int, len[0]);

  double* vec_real;
  ghdlToArray(v_vec_real, (void**)&vec_real, len, 1);
  assert(vec_real[0] == 0.5);
  assert(vec_real[1] == 1.75);
  assert(vec_real[2] == 3.33);
  assert(vec_real[3] == -0.125);
  assert(vec_real[4] == -0.67);
  assert(vec_real[5] == -2.21);
  printf("v_vec_real : %p \tlength [%d]\n", vec_real, len[0]);

  bool* vec_bool;
  ghdlToArray(v_vec_bool, (void**)&vec_bool, len, 1);
  assert(vec_bool[0] == 0);
  assert(vec_bool[1] == 1);
  assert(vec_bool[2] == 1);
  assert(vec_bool[3] == 0);
  printf("v_vec_bool : %p \tlength [%d]\n", vec_bool, len[0]);

  bool* vec_bit;
  ghdlToArray(v_vec_bit, (void**)&vec_bit, len, 1);
  assert(vec_bit[0] == 1);
  assert(vec_bit[1] == 0);
  assert(vec_bit[2] == 1);
  assert(vec_bit[3] == 0);
  printf("v_vec_bit  : %p \tlength [%d]\n", vec_bit, len[0]);

  int64_t* vec_phy;
  ghdlToArray(v_vec_phy, (void**)&vec_phy, len, 1);
  assert(vec_phy[0] == 1e6);
  assert(vec_phy[1] == 50e3);
  assert(vec_phy[2] == 1.34e9);
  printf("v_vec_phy  : %p \tlength [%d]\n", vec_phy, len[0]);

  rec_t* vec_rec;
  ghdlToArray(v_vec_rec, (void**)&vec_rec, len, 1);
  assert(vec_rec[0].r_char == 'x');
  assert(vec_rec[0].r_int == 17);
  assert(vec_rec[1].r_char == 'y');
  assert(vec_rec[1].r_int == 25);
  printf("v_vec_rec  : %p \tlength [%d]\n", vec_rec, len[0]);

  uint8_t* vec_enum;
  ghdlToArray(v_vec_enum, (void**)&vec_enum, len, 1);
  assert(vec_enum[0] == start);
  assert(vec_enum[1] == busy);
  assert(vec_enum[2] == standby);
  printf("v_vec_enum : %p \tlength [%d]\n", vec_enum, len[0]);

  double* vec2_real_base;
  ghdlToArray(v_2vec_real, (void**)&vec2_real_base, len, 2);
  double (*vec2_real)[len[1]] = (double(*)[len[1]])vec2_real_base;
  assert(vec2_real[0][0] == 0.1);
  assert(vec2_real[0][1] == 0.25);
  assert(vec2_real[0][2] == 0.5);
  assert(vec2_real[1][0] == 3.33);
  assert(vec2_real[1][1] == 4.25);
  assert(vec2_real[1][2] == 5.0);
  printf("v_2vec_real : %p \tlengths [%d,%d]\n", vec_enum, len[1], len[0]);

  printf("\nVerify GHDL Matrix in C\n");
  printAttributes(v_mat_int, 2);
  len2 = malloc(2 * sizeof(int));

  int32_t* mat_int;
  ghdlToArray(v_mat_int, (void**)&mat_int, len2, 2);
  printf("C assert mat_int[x][y] == A\n");
  for (int i = 0; i < len2[0]; i++)
  {
    for (int j = 0; j < len2[1]; j++)
    {
      int ind[] = {i, j};
      int flatIndex = getFlatArrayIndex(ind, len2, 2);
      printf("[%d,%d](%d): %d == %d \t\t", i, j, flatIndex, mat_int[flatIndex], 11*(flatIndex+1));
      assert(mat_int[flatIndex] == 11*(flatIndex+1));
    }
    printf("\n");
  }
  printf("v_mat_int  : %p \tlengths [%d,%d]\n\n", mat_int, len2[0], len2[1]);

  printf("\nVerify the 3D GHDL array in C\n");
  printAttributes(v_3d_int, 3);
  len3 = malloc(3 * sizeof(int));

  int32_t* d3_int;
  ghdlToArray(v_3d_int, (void**)&d3_int, len3, 3);
  printf("C assert d3_int[x][y][z] == A\n");
  for(int i = 0; i < len3[0]; i++)
  {
    for (int j = 0; j < len3[1]; j++)
    {
      for (int k = 0; k < len3[2]; k++)
      {
        int ind[] = {i, j, k};
        int flatIndex = getFlatArrayIndex(ind, len3, 3);
        printf("[%d,%d,%d](%d): %d == %d\t", i, j, k, flatIndex, d3_int[flatIndex], 11*(flatIndex+1));
        assert(d3_int[flatIndex] == 11*(flatIndex+1));
      }
      printf("\n");
    }
    printf("\n");
  }
  printf("v_3d_int  : %p [%d,%d,%d]\n\n", d3_int, len3[0], len3[1], len3[2]);

  printf("end testCinterface\n\n");
}

void freePointers(){
  free(vec);
  free(vec_bounds);
  free(mat);
  free(mat_bounds);
  free(d3_ptr);
  free(d3_bounds);
  free(string_bounds);
  free(line);
  free(len);
  free(len2);
  free(len3);
}

void getString(ghdl_NaturalDimArr_t* ptr) {
  if(string_bounds != NULL){//this handles a second call//this handles a second call
    free(string_bounds);
  }
  *ptr = ghdlFromString("HELLO WORLD");
  string_bounds = ptr->bounds;
}

void getIntVec(ghdl_NaturalDimArr_t *ptr) {//Notice how similar this is to getIntMat() which is supposedly a 2D array (it is also actually just a flat (1D) array)
  vec = malloc(2*3*sizeof(int32_t));
  int32_t len[1] = {2*3};
  int x, y;
  for ( x=0 ; x<2 ; x++ ) {
    for ( y=0 ; y<3 ; y++ ) {
      int flatIndex = x*3+y;
      vec[flatIndex] = 11*(flatIndex+1);
    }
  }

  *ptr = ghdlFromPointer((void *)vec, len, 1);
  vec_bounds = ptr->bounds;
  assert(ptr->array == vec);

  printf("\n1D Array values [%d]:\n", len[0]);
  for ( x=0 ; x<len[0] ; x++ ) {
    printf("[%d]: %d\n", x, vec[x]);
    assert(vec[x] == ((int32_t*)ptr->array)[x]);
  }

}

void getIntMat(ghdl_NaturalDimArr_t* ptr){//Notice how similar this is to getIntVec() (mat is also actually just a flat (1D) array, accessed as if 2D)
  mat = malloc(2*3*sizeof(int32_t));
  int32_t len[2] = {2, 3};
  int x, y, ind[2];
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      mat[flatIndex] = -1;//set to the expected value after ghdlFromPointer to confirm that C-side data changes are reflected in vhdl
    }
  }

  *ptr = ghdlFromPointer((void *)mat, len, 2);
  mat_bounds = ptr->bounds;
  printf("\n2D Array values [%d,%d]:\n", len[0], len[1]);
  for ( x=0 ; x<len[0] ; x++ ) {
    ind[0] = x;
    for ( y=0 ; y<len[1] ; y++ ) {
      ind[1] = y;
      int flatIndex = getFlatArrayIndex(ind, len, 2);
      mat[flatIndex] = 11*(flatIndex+1);
      printf("mat[%d][%d] = %d\t", x, y, mat[flatIndex]);
      assert(mat[flatIndex] == ((uint32_t*)ptr->array)[flatIndex]);
    }
    printf("\n");
  }

}

void getInt3d(ghdl_NaturalDimArr_t* ptr){
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
        assert(d3[x][y][z] == ((uint32_t*)ptr->array)[flatIndex]);
        d3[x][y][z] = -1;//ghdlFromArray creates a deep-copy of the information, so this change is not reflected in VHDL
      }
      printf("\n");
    }
    printf("\n");
  }
  printf("###NOTE###\nThe 3D array's values have been set to -1 after ghdlFromArray().");
  printf("\nThis change is decoupled from the VHDL unconstrained array\nbecause ghdlFromArray() makes a deep copy.");
  printf("\nSo the assertions of 3D values in tb.vhd will still succeed.\n");
  printf("d3[%d][%d][%d] = %d\n\n", x, y, z, d3[x][y][z]);
}

ghdl_AccNaturalDimArr_t* getLine() {
  if(line != NULL){//this handles a second call
    free(line);
  }
  line = ghdlAccFromString("HELLO WORLD");
  return line;
}

int getLogicIntValue(char logic){
  return 0 + logic;
}