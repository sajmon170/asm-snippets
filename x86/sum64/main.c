#include <stdio.h>
#include <stdint.h>

extern uint64_t argsum(uint64_t argc, ...);

int main(void) {
	printf("%lu\n", argsum(5, 1, 2, 3, 4, 5));
}
