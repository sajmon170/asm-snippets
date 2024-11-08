#include <stdio.h>

typedef unsigned char byte;

extern void  nmemcpy(void*, void*, int);
extern void  memswp(void*, void*, int);
extern void  sort(void* mem, int sz, int str, int (*)(void*, void*));
extern void sort_ints(void*, int);
extern int nstrlen(char*);
extern int filter(void*, int, int, int (*)(void*), void*);
extern double avg(double*, int);

int cmp(void* a, void*b) {
	return *(double*)a < *(double*)b;
}

int main(void) {
	double arr[] = {-5.6, 2.0, 3.32, 4.0};
	int size = sizeof(arr)/sizeof(double);
	sort(arr, size, sizeof(double), cmp);
	for (int i=0; i<size; i++)
		printf("%f ", arr[i]);
	printf("\n");
}
