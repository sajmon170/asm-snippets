#include <stdio.h>
typedef unsigned char byte;

extern void print_array(const byte* array, int size);

int main(void) {
	byte array[] = {5, 2, 0, -3, 5};
	print_array(array, sizeof(array));
}
