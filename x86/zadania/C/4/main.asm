.686
.model flat

public _main

; cdecl
extern _printf: PROC

; StdCall
extern _ExitProcess@4: PROC

.data
number dw -1
format db "%X", 0Dh, 0Ah, 0

.code
zapisz5bitow PROC
    BITMASK = 11111b

    and al, BITMASK
    movzx ax, al
    mov dx, BITMASK

    mov ch, 16-5
    sub ch, cl
    mov cl, ch

    shl dx, cl
    not dx

    mov bx, [edi]
    and bx, dx

    shl ax, cl
    or bx, ax

    mov [edi], bx

    ret
zapisz5bitow ENDP

; esi: adres źródła
; edi: adres wyniku
convert PROC
    mov eax, 70
    mul eax

    outer:
        cmp eax, 0
        je end_outer

        mov bl, 0

        if_clamp:
            cmp eax, 8
            jnae if_no_clamp
            mov ecx, 8
            jmp end_if
        if_no_clamp:
            mov ecx, eax
        end_if:

        inner:
            or bl, [esi]
            shl bl, 1
            inc esi
            dec eax
        loop inner

        mov [edi], bl
        inc edi

        jmp outer
    end_outer:
    
    ret
convert ENDP

_main PROC
    movzx eax, number
    push eax
    push OFFSET format
    call _printf
    add esp, 4

    mov eax, -1
    mov al, 0
    mov cl, 7
    mov edi, OFFSET number
    call zapisz5bitow

    movzx eax, number
    push eax
    push OFFSET format
    call _printf
    add esp, 4

    push 0
    call _ExitProcess@4
_main ENDP
END
