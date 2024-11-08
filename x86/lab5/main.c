#include <stdio.h>

extern void mul_at_once(int* dest, int* one, int* two);
extern float find_max_range(float v, int alpha);

int main(void) {
	int arr1[4] = {0, 1, 2, 3};
	int arr2[4] = {5, 6, 7, 8};
	int dest[4];

	mul_at_once(dest, arr1, arr2);

	printf("mul at once:\n");
	for (int i=0; i<4; i++)
		printf("%d ", dest[i]);
	printf("\n\n");

	printf("find_max_range:\n");
	printf("%f\n", find_max_range(11.3, 30));
}
