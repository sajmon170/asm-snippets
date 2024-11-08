.686
.model flat

extern _count_matching: PROC
extern _printf:         PROC

.data
array dd 10, 12, 23, 243, 342, 21, 12, 0, 2
ARRSZ = ($ - OFFSET array) / 4
fmt   db "Liczba wystapien liczby 12: %d", 0Dh, 0Ah, 0

.code
; int cmp_to_int(void* ptr_to_int)
_cmp_to_int PROC
    push ebp
    mov ebp, esp

; wyzerowanie eax, porównanie, zapisanie wyniku
    xor eax, eax
    mov edx, [ebp + 8]
    cmp DWORD PTR [edx], 12
    sete al

    mov esp, ebp
    pop ebp
    ret
_cmp_to_int ENDP

; void funkcja_asemblera(void)
_funkcja_asemblera PROC
    push ebp
    mov ebp, esp

; szukanie w array wystąpień liczby 12
    push OFFSET _cmp_to_int
    push 4
    push ARRSZ
    push OFFSET array
    call _count_matching
    add esp, 16

; wyświetlenie wyniku na ekran
    push eax
    push OFFSET fmt
    call _printf
    add esp, 8

    mov esp, ebp
    pop ebp
    ret
_funkcja_asemblera ENDP

END
