#include <stdio.h>
typedef long long i64;
extern i64 suma_kwadratow(i64 a, i64 b);

int main(void) {
	printf("%lld\n", suma_kwadratow(100000, -3));
}
