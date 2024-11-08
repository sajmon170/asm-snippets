#include <stdio.h>

extern int isPalindrome(char* string, unsigned len);

int main() {
	char napis[] = "kajak";
	int size = sizeof(napis) - 1;
	printf("%d\n", isPalindrome(napis, size));
}
