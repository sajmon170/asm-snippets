#include <stdio.h>

typedef struct {
	double x1;
	double x2;
} Solution;

extern Solution quadratic(double a, double b, double c);

int main(void) {
	Solution roots = quadratic(
		3.56438349, 12.2344156, 1.34512314
	);

	printf("x1: %f, x2: %f\n", roots.x1, roots.x2);
}
