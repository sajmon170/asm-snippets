.686
.model flat

public 8to16

extern _malloc: PROC

.code
; short* 8to16(byte* string)
8to16 PROC
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]
    mov esi, 0

    while1:
        mov al, [ebx + esi]
        cmp al, 0
        je end_while1

        mov ah, 7
        mov cl, 0               ; utf-8 length
        while2:
            inc cl
            bt al, ah
            jnc end_if
            dec ah
        end_while2:

        shl al, cl              ; clear utf data
        shr al, cl

        movzx edx, al

        sub cl, 2
        cmp cl, 0
        jl end_while3
        while3:
            cmp cl, 0
            je end_while3

            inc esi
            mov al, [ebx + esi]
            shl al, 2
            shr al, 2
            shl edx, 6
            or dl, al
            
            dec cl
            jmp while3
        end_while3:

        push edx
        
        inc esi
        jmp while1
    end_while1:
    
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    ret
8to16 ENDP
END
