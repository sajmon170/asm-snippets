#include <stdio.h>

int count_matching(void* mem,           // przeszukiwana przestrzeń pamięci
                   int size,            // ilość obiektów w pamięci
                   int stride,          // rozmiar pojedynczego obiektu
                   int (*cmp)(void*))   // funkcja sprawdzająca obiekt
{
	int count = 0;
	for (int i = 0; i < size; i++, mem += stride)
		count += cmp(mem);

	return count;
}

int cmp_to_double(void* mem) {
	return *(double*)mem == 10.0;
}

int main(void) {
	double arr[] = {
		1.0, -2.5, 10.0, -4.0, -2.5, 10.0, 13.0, 10.5, 10.0
	};

	int count_doubles = count_matching(arr,
	                                   sizeof(arr) / sizeof(double),
	                                   sizeof(double),
	                                   cmp_to_double);
	
	printf("Liczba wystapien liczby 10.0: %d\n", count_doubles);

	extern void funkcja_asemblera(void);
	funkcja_asemblera();
}
