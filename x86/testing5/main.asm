.686
.model flat

public _main

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
stale dw 2, 1
napis dw 10 dup (3), 2
tekst db 7
      dq 1

.code
_main PROC
    mov cx, napis-1
    sub tekst, ch
    mov edi, 1
    mov tekst[4*edi], ch
    mov ebx, DWORD PTR tekst+1

    push 0
    call _ExitProcess@4
_main ENDP
END
