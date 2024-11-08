#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int** data;
	int x;
	int y;
} Matrix;

extern Matrix make_matrix(int x, int y);
extern void print_matrix(Matrix m);
extern Matrix multiply(Matrix a, Matrix b);

void delete_matrix(Matrix m) {
	for (int i = 0; i < m.y; i++)
		free(m.data[i]);
	free(m.data);
	m.data = NULL;
}

int main(void) {
	int i;
	
	Matrix a = make_matrix(4, 5);
	i = 0;
	for (int y = 0; y < a.y; y++)
		for (int x = 0; x < a.x; x++)
			a.data[y][x] = i++;
	
	Matrix b = make_matrix(5, 3);
	i = 0;
	for (int y = 0; y < b.y; y++)
		for (int x = 0; x < b.x; x++)
			b.data[y][x] = i++;

	print_matrix(a);
	printf("\n");
	print_matrix(b);
	printf("\n");
	
	Matrix c = multiply(a, b);
	print_matrix(c);
	printf("\n");
}
