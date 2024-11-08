.686
.model flat

public dectobin

.data

.code
; int dectobin(char* number)
dectobin PROC
    push ebp
    mov ebp, esp
    sub esp, 4

    mov DWORD PTR [ebp - 4], 10

    mov ebx, [ebp + 8]
    mov eax, 0
    mov esi, 0

    while1:
        xor ecx, ecx
        mov cl, BYTE PTR [ebx + esi]
        sub cl, '0'

        add eax, ecx

        cmp BYTE PTR [ebx + esi + 1], 0
        je end_while1
        
        mul DWORD PTR [ebp - 4]
        inc esi
        jmp while1
    end_while1:
 
    mov esp, ebp
    pop ebp
    ret
dectobin ENDP
END
