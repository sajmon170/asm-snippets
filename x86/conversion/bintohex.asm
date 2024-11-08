.686
.model flat

public bintohex

extern _malloc:  PROC

.data
decode db "0123456789ABCDEF"

.code
; char* bintohex(int num)
bintohex PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]          ; number
    mov ebx, 16
    mov ecx, 0

    while1:
        mov edx, 0
        cmp eax, 0
        je end_while1

        div ebx
        push [OFFSET decode + edx]
        
        inc ecx
        jmp while1
    end_while1:
    
    inc ecx 
    push ecx
    call _malloc
    pop ecx
    dec ecx

    mov edi, 0
    while2:
        cmp edi, ecx
        je end_while2

        pop ebx
        mov BYTE PTR [eax + edi], bl

        inc edi
        jmp while2
    end_while2:

    mov BYTE PTR [eax + edi], 0
    
    mov esp, ebp
    pop ebp
    ret
bintohex ENDP
END
