#include <stdio.h>
#include <xmmintrin.h>

extern void szybki_max(int* t1, int* t2, int* w, int n);
extern __m128i szybki_max2(short int* t1, short int* t2);

int main(void) {
	/*
	  int val1[8] = {1,  -1,  2, -2, 3, -3, 4, -4};
	  int val2[8] = {-4, -3, -2, -1, 0,  1, 2,  3};
	  int wynik[8];

	  szybki_max(val1, val2, wynik, 8);

	  for (int i=0; i<8; i++)
		printf("%d\n", wynik[i]);
	*/
	
	short int val1[8] = {1,  -1,  2, -2, 3, -3, 4, -4};
	short int val2[8] = {-4, -3, -2, -1, 0,  1, 2,  3};
	__m128i t1 = szybki_max2(val1, val2);

	for (int i=0; i<8; i++)
		printf("%d\n", t1[i]);
}
