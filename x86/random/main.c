#include <stdio.h>
#include <stdint.h>

extern uint32_t generate(void);

#define M (1U << 31)

int main(void) {
	int count[10];
	for (int i=0; i<10; i++)
		count[i] = 0;

	for (int i=0; i<100000; i++)
		count[(uint32_t)((generate()*(uint64_t)10) / M)]++;

	for (int i=0; i<10; i++)
		printf("%u ", count[i]);
	printf("\n");
}
