.686
.model flat

public _main
extern _ExitProcess@4: PROC

.data
pqr dw 257, 129, 65

.code
_main PROC
    mov ebx, OFFSET pqr
    lea edi, [ebx + 1]
    mov eax, [edi]

    push 0
    call _ExitProcess@4
_main ENDP

END
