#include <stdio.h>
#include <wchar.h>

extern long long rozmiar(wchar_t*);
extern int envvar(wchar_t*);

int main(void) {
	printf(" %d\n", envvar(L"UWU"));
	printf(" %d\n", envvar(L"WINEDEBUG"));
}
