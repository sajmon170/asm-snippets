.686
.model flat

public _main
extern _printf: PROC
extern _ExitProcess@4: PROC

.data
single db "%X", 0DH, 0AH, 0
linie  dd 421, 422, 443
       dd 442, 444, 427, 432
format db "%u.%u ", 0
newln  db 0DH, 0AH, 0
array  dd -34232335, 04ba1665aH, 23234892, 0

MAX = 4
;rejestr24 db 04bh, 0a1h, 066h, 05ah
;rejestr24 dd 04ba1665aH
rejestr24 db 05Ah, 066h, 0A1h, 0cbh

.code
count PROC
    xor cl, cl
    mov esi, 0

    while1:
        cmp esi, 32
        je end_while1

        shl eax, 1
        setc bl
        add cl, bl
        
        inc esi
        jmp while1
    end_while1:

    ret
count ENDP

; CL - month, EBX - pointer to array
calendar PROC
    movzx ecx, cl
    mov eax, [ebx + ecx]

    mov esi, 0
    while1:
        cmp esi, 32
        je end_while1

        begin_if:
            bt eax, esi
            jnc end_if
        if_holiday:
            push eax
            inc esi
            
            push esi
            push ecx
            push OFFSET format
            call _printf
            add esp, 4
            pop ecx
            pop esi

            dec esi
            pop eax
        end_if:

        inc esi
        jmp while1
    end_while1:

    push OFFSET newln
    call _printf
    add esp, 4
    
    ret
calendar ENDP

decsum PROC
    xor ecx, ecx
    mov ebx, 10

    while1:
        cmp eax, 0
        je end_while1

        xor edx, edx
        div ebx
        add cl, dl
        
        jmp while1
    end_while1:

    ret
decsum ENDP

przesun PROC
    mov esi, MAX-1
    shl rejestr24[esi], 1
    setc al
    dec esi

    while1: 
        cmp esi, 0
        je end_while1
        
        shl rejestr24[esi], 1
        setc bl
        or rejestr24[esi], al
        mov al, bl        

        dec esi
        jmp while1
    end_while1:

    shl rejestr24[0], 1
    pushf
    setc al
    or rejestr24[MAX-1], al
    popf
    
    ret
przesun ENDP

przesun2 PROC
    mov ecx, MAX-1
    clc
    et:
        rcl rejestr24[ecx], 1
    loop et

    pushf
    setc al
    or rejestr24[MAX-1], al
    popf
    
    ret
przesun2 ENDP

_main PROC
    push DWORD PTR [rejestr24]
    push OFFSET single
    call _printf
    add esp, 12

    call przesun2
    
    push DWORD PTR [rejestr24]
    push OFFSET single
    call _printf
    add esp, 12

    push 0
    call _ExitProcess@4
_main ENDP
END
