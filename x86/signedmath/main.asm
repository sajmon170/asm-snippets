.686
.model flat

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
fmt  db "%d", 0Dh, 0Ah, 0
num1 dd -232643
num2 dd 2343

.code
_main PROC
    mov eax, num1
    cdq
    idiv num2

    imul eax

    push eax
    push OFFSET fmt
    call _printf
    add esp, 8

    push 0
    call _ExitProcess@4
_main ENDP
END
