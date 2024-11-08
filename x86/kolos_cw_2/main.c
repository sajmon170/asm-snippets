#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define size(arr) (sizeof(arr) / sizeof(arr[0]))
#define nthbit(num, n) ((num >> n) & 1)

typedef unsigned int u32;
typedef unsigned char byte;

void zadanie1() {
	extern int roznica(int* odjemna, int** odjemnik);

	int x = 10;
	int y = 20;
	int* ptr_y = &y;

	printf("%d\n", roznica(&x, &ptr_y));
}

void zadanie2() {
	extern int* kopia_tablicy(int tabl1[], u32 n);

	int arr[] = {1, 2, 3, 4, 5};
	int* copy = kopia_tablicy(arr, size(arr));
	for (int i=0; i<size(arr); i++)
		printf("%d ", copy[i]);
	printf("\n");
}

void zadanie3() {
	extern char* komunikat(char* tekst);
	
	char tekst[] = "Przekroczono limit czasu";
	printf("%s\n", komunikat(tekst));
}

void zadanie4() {
	extern int szukaj_elem_min(int tablica[], int n);

	int arr[] = {200, 4, 5, 12, 20, 30, 50, 1, 300};
	printf("%d\n", szukaj_elem_min(arr, size(arr)));
}

int get_random() {
	static int num = 0x52525252;
	int sum = nthbit(num, 30) ^ nthbit(num, 31);
	return num = (num << 1) & sum; 
}

void encrypt(char* str) {
	for (int i=0; i<strlen(str); i++)
		str[i] ^= get_random();
}

void zadanie5() {
	extern int szyfruj(char* tekst);
	
	char tekst1[] = "Tekst do zaszyfrowania";
	encrypt(tekst1);

	char tekst2[] = "Tekst do zaszyfrowania";
	szyfruj(tekst2);

	bool matching = true;

	for (int i=0; i<size(tekst1) && matching; i++)
		matching = (tekst1[i] == tekst2[i]);

	printf("%s\n", matching? "Correct!" : "False");
}

void zadanie6() {
	extern u32 kwadrat(u32 a);

	for (u32 i=0; i<10; i++)
		printf("%u ", kwadrat(i));
	printf("\n");
}

void zadanie7() {
	extern byte iteracja(byte a);
	
	int odp = 131;
	printf("%s\n", iteracja(32) == odp ? "OK" : "Źle");
}

void zadanie12() {
	extern float iloraz();
	printf("%f\n", iloraz());
}

void zadanie13() {
	extern void f32to64(float*, double*);

	float a = 543.213;
	double b;

	f32to64(&a, &b);
	printf("%f\n", *(float*)(&b));
}

void zadanie14() {
	extern void pole_kola(float*);

	float f = 16.32;
	pole_kola(&f);
	printf("Pole: %f\n", f);
}

void zadanie16() {
	extern u32 liczba_procesorow();
	printf("Liczba procesorow: %u\n", liczba_procesorow());
}


int main(void) {
	extern double test();
	printf("%f\n", test());
}
