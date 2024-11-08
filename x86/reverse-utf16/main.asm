.686
.model flat

public _main

extern _wprintf: PROC
extern atoutf16: PROC
extern _ExitProcess@4: PROC

.data
message db "1234", 0

.code
_main PROC
    push OFFSET message
    call atoutf16
    add esp, 4
    
    mov esi, eax
    mov edx, eax

    mov edi, esi
    while1:
        cmp WORD PTR [edi], 0
        je end_while1
        add edi, 2
        jmp while1
    end_while1:

    sub edi, 2

    while2:
        cmp esi, edi
        jnb end_while2
        mov ax, [esi]
        xchg ax, [edi]
        xchg [esi], ax

        add esi, 2
        sub edi, 2
        jmp while2
    end_while2:

    push edx
    call _wprintf
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP
END
