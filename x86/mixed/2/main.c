#include <stdio.h>
extern int szukaj4_max(int a, int b, int c, int d);
extern void liczba_przeciwna(int*);
extern void odejmij_jeden(int**);

int main(void) {
	printf("Max: %d\n", szukaj4_max(3, 1, 0, 5));

	int num = 20;
	liczba_przeciwna(&num);
	printf("Przeciwna: %d\n", num);

	num = 10;
	int* wsk = &num;
	odejmij_jeden(&wsk);
	printf("10-1 = %d\n", num);
}
