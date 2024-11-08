.686
.model flat

public _main
extern _printf: PROC
extern _ExitProcess@4: PROC

.data
format db "%d ", 0
newln  db 0DH, 0AH, 0

.code
sequence PROC
    push ebp
    mov ebp, esp

    mov eax, 1
    mov edi, 0

    while1:
        cmp edi, [ebp + 8]
        je end_while1

        add eax, edi

        push edi
        push eax
        push OFFSET format
        call _printf
        add esp, 4
        pop eax
        pop edi
        
        inc edi
        jmp while1
    end_while1:

    push OFFSET newln
    call _printf
    add esp, 4
    
    mov esp, ebp
    pop ebp
    ret
sequence ENDP

_main PROC
    push 50
    call sequence
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP

END
