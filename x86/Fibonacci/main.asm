.686
.model flat

extern _printf: PROC
extern _ExitProcess@4: PROC

.data
format db "%d", 0DH, 0AH, 0

.code
fibonacci PROC
    push ebp
    mov ebp, esp
    sub esp, 4

    cmp DWORD PTR [ebp + 8], 1
    je initial
    cmp DWORD PTR [ebp + 8], 2
    je initial
    
    mov ebx, [ebp + 8]
    sub ebx, 1
    push ebx
    call fibonacci
    add esp, 4
    mov [ebp - 4], eax

    mov ebx, [ebp + 8]
    sub ebx, 2
    push ebx
    call fibonacci
    add esp, 4

    add eax, [ebp - 4]
    jmp exit
initial:
    mov eax, 1
exit:
    mov esp, ebp
    pop ebp
    ret
fibonacci ENDP

_main PROC
    push 10
    call fibonacci
    add esp, 4

    push eax
    push OFFSET format
    call _printf
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP
END
