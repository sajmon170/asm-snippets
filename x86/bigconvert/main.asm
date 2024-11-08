.686
.model flat

public _main

extern ntobigbin: PROC

extern _ExitProcess@4: PROC
extern _printf:        PROC
extern _free:          PROC

.data
max_64 db "12345", 0
format db "%u", 0
newln  db 0DH, 0AH, 0

.code
_main PROC
    push 10
    push OFFSET max_64
    call ntobigbin
    add esp, 8

    mov esi, 0
    while1:
        cmp esi, 1
        je end_while1

        push eax
        push esi

        mov ebx, [eax + esi + 1]
        push ebx
        push OFFSET format
        call _printf
        add esp, 8

        pop esi
        pop eax

        inc esi
        jmp while1
    end_while1:

    push OFFSET newln
    call _printf
    add esp, 4
    
    push 0
    call _ExitProcess@4
_main ENDP
END
