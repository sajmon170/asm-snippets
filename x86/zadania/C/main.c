#include <stdio.h>

unsigned char p;
unsigned short int proba = 0x1234;
unsigned char * wsk = (unsigned char *) &proba;

int main(void) {
	p = *wsk;
	printf("%X", p);
} 
